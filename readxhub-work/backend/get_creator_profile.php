<?php
require('../cors-handler.php');
require('../Getdatabase.php');
require('db_init.php');

header("Content-Type: application/json; charset=UTF-8");

// Automatically initialize tables/columns if not exist
initialize_database($conn);

$identifier = trim($_GET['username'] ?? $_GET['email'] ?? '');

if (empty($identifier)) {
    http_response_code(400);
    echo json_encode(['error' => 'Username or email parameter is required']);
    exit();
}

// Fetch creator info (autodetect email vs username)
if (strpos($identifier, '@') !== false) {
    $creatorSql = "SELECT name, bio, profile_picture, email, username, gender, show_email, public_email FROM blog_creators WHERE email = ? LIMIT 1";
} else {
    $creatorSql = "SELECT name, bio, profile_picture, email, username, gender, show_email, public_email FROM blog_creators WHERE username = ? LIMIT 1";
}

$creatorStmt = $conn->prepare($creatorSql);
if (!$creatorStmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to prepare creator statement']);
    exit();
}

$creatorStmt->bind_param("s", $identifier);
$creatorStmt->execute();
$creatorResult = $creatorStmt->get_result();

if (!$creatorResult || $creatorResult->num_rows === 0) {
    http_response_code(404);
    echo json_encode(['error' => 'Creator profile not found']);
    $creatorStmt->close();
    $conn->close();
    exit();
}

$creatorData = $creatorResult->fetch_assoc();
$creatorStmt->close();

$email = $creatorData['email'];

// Resolve profile picture with gender default if empty
$profile_picture = $creatorData['profile_picture'];
$gender = strtolower($creatorData['gender'] ?? 'male');
if (empty($profile_picture)) {
    if ($gender === 'female') {
        $profile_picture = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%23f472b6"/><path d="M50 28a15 15 0 1 0 0 30 15 15 0 1 0 0-30z" fill="%230f172a"/><path d="M50 64c-18 0-33 11-33 22v4h66v-4c0-11-15-22-33-22z" fill="%230f172a"/></svg>';
    } else if ($gender === 'trans' || $gender === 'transgender' || $gender === 'other') {
        $profile_picture = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%23a855f7"/><path d="M50 29a15 15 0 1 0 0 30 15 15 0 1 0 0-30z" fill="%230f172a"/><path d="M50 64c-18 0-33 11-33 22v4h66v-4c0-11-15-22-33-22z" fill="%230f172a"/></svg>';
    } else {
        $profile_picture = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%2338bdf8"/><path d="M50 30a16 16 0 1 0 0 32 16 16 0 1 0 0-32z" fill="%230f172a"/><path d="M50 66c-18.5 0-34 11-34 22v4h68v-4c0-11-15.5-22-34-22z" fill="%230f172a"/></svg>';
    }
}

// Fetch all blog posts by this creator using email
$postsSql = "SELECT id, title, description, keywords, author, content, slug, url, created_at, views, reading_time FROM blog_posts WHERE email = ? AND status = 'published' ORDER BY created_at DESC";
$postsStmt = $conn->prepare($postsSql);
if (!$postsStmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to prepare posts statement']);
    $conn->close();
    exit();
}

$postsStmt->bind_param("s", $email);
$postsStmt->execute();
$postsResult = $postsStmt->get_result();

$posts = [];
while ($row = $postsResult->fetch_assoc()) {
    $posts[] = $row;
}
$postsStmt->close();


$publicEmail = null;
if (intval($creatorData['show_email'] ?? 0) === 1) {
    $publicEmail = !empty($creatorData['public_email']) ? $creatorData['public_email'] : $creatorData['email'];
}

// Fetch Total Subscribers
$subSql = "SELECT COUNT(*) as sub_count FROM creator_subscriptions WHERE creator_email = ?";
$subStmt = $conn->prepare($subSql);
$subStmt->bind_param("s", $email);
$subStmt->execute();
$subResult = $subStmt->get_result();
$subRow = $subResult->fetch_assoc();
$totalSubscribers = $subRow['sub_count'] ?? 0;
$subStmt->close();

// Fetch Total Views
$viewSql = "SELECT SUM(views) as total_views FROM blog_posts WHERE email = ? AND status = 'published'";
$viewStmt = $conn->prepare($viewSql);
$viewStmt->bind_param("s", $email);
$viewStmt->execute();
$viewResult = $viewStmt->get_result();
$viewRow = $viewResult->fetch_assoc();
$totalViews = $viewRow['total_views'] ?? 0;
$viewStmt->close();

$conn->close();

echo json_encode([
    'name' => $creatorData['name'],
    'bio' => $creatorData['bio'],
    'profile_picture' => $profile_picture,
    'username' => $creatorData['username'],
    'gender' => $creatorData['gender'],
    'email' => $publicEmail,
    'blogs' => $posts,
    'total_subscribers' => $totalSubscribers,
    'total_views' => $totalViews
]);
?>
