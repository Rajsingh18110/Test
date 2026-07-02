<?php
require('../cors-handler.php');
require('../Getdatabase.php');
require('db_init.php');

header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Automatically initialize tables/columns if not exist
initialize_database($conn);

$name = trim($_POST['name'] ?? '');
$bio = trim($_POST['bio'] ?? '');
$email = trim($_POST['email'] ?? '');
$username = trim($_POST['username'] ?? '');
$gender = strtolower(trim($_POST['gender'] ?? 'male'));
$show_email = intval($_POST['show_email'] ?? 0);
$public_email = trim($_POST['public_email'] ?? '');

if (empty($name) || empty($bio) || empty($email) || empty($username)) {
    http_response_code(400);
    echo json_encode(['error' => 'Name, bio, email, and username fields are required']);
    exit();
}

// Validate username
if (!preg_match('/^[a-zA-Z0-9._-]{3,30}$/', $username)) {
    http_response_code(400);
    echo json_encode(['error' => 'Username must be 3-30 chars and contain only letters, numbers, underscores, dots, or dashes.']);
    exit();
}

// Check uniqueness
$uCheck = $conn->prepare("SELECT id FROM blog_creators WHERE username = ? AND email != ? LIMIT 1");
$uCheck->bind_param("ss", $username, $email);
$uCheck->execute();
$uCheckRes = $uCheck->get_result();
if ($uCheckRes->num_rows > 0) {
    http_response_code(400);
    echo json_encode(['error' => 'Username is already taken by another creator.']);
    $uCheck->close();
    exit();
}
$uCheck->close();

$upload_dir = 'uploads/';
if (!is_dir($upload_dir)) {
    mkdir($upload_dir, 0777, true);
}

// 1. Check if profile exists and get existing photo
$checkSql = "SELECT profile_picture, gender FROM blog_creators WHERE email = ? LIMIT 1";
$checkStmt = $conn->prepare($checkSql);
if (!$checkStmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to prepare select query']);
    exit();
}
$checkStmt->bind_param("s", $email);
$checkStmt->execute();
$checkRes = $checkStmt->get_result();

if (!$checkRes || $checkRes->num_rows === 0) {
    http_response_code(404);
    echo json_encode(['error' => 'Creator profile not found']);
    $checkStmt->close();
    $conn->close();
    exit();
}

$row = $checkRes->fetch_assoc();
$profile_picture_path = $row['profile_picture'];
$checkStmt->close();

// 2. Handle file upload if provided
if (isset($_FILES['profile_picture']) && $_FILES['profile_picture']['error'] === UPLOAD_ERR_OK) {
    $file_tmp = $_FILES['profile_picture']['tmp_name'];
    $file_name = time() . '_' . preg_replace('/[^a-zA-Z0-9._-]/', '_', $_FILES['profile_picture']['name']);
    $target_file = $upload_dir . $file_name;
    
    if (move_uploaded_file($file_tmp, $target_file)) {
        $profile_picture_path = 'https://readxhub.in/blogs/' . $target_file;
    } else {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to upload new profile picture']);
        exit();
    }
} else {
    // If they changed gender and had a default profile picture, update to the new gender's default avatar
    $isDefaultPic = empty($profile_picture_path) || (strpos($profile_picture_path, 'data:image/svg+xml;') === 0);
    if ($isDefaultPic) {
        if ($gender === 'female') {
            $profile_picture_path = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%23f472b6"/><path d="M50 28a15 15 0 1 0 0 30 15 15 0 1 0 0-30z" fill="%230f172a"/><path d="M50 64c-18 0-33 11-33 22v4h66v-4c0-11-15-22-33-22z" fill="%230f172a"/></svg>';
        } else if ($gender === 'trans' || $gender === 'transgender' || $gender === 'other') {
            $profile_picture_path = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%23a855f7"/><path d="M50 29a15 15 0 1 0 0 30 15 15 0 1 0 0-30z" fill="%230f172a"/><path d="M50 64c-18 0-33 11-33 22v4h66v-4c0-11-15-22-33-22z" fill="%230f172a"/></svg>';
        } else {
            $profile_picture_path = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%2338bdf8"/><path d="M50 30a16 16 0 1 0 0 32 16 16 0 1 0 0-32z" fill="%230f172a"/><path d="M50 66c-18.5 0-34 11-34 22v4h68v-4c0-11-15.5-22-34-22z" fill="%230f172a"/></svg>';
        }
    }
}

// 3. Update profile details
$updateSql = "UPDATE blog_creators SET name = ?, bio = ?, profile_picture = ?, username = ?, gender = ?, show_email = ?, public_email = ? WHERE email = ?";
$updateStmt = $conn->prepare($updateSql);
if (!$updateStmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to prepare update query']);
    $conn->close();
    exit();
}

$updateStmt->bind_param("sssssiss", $name, $bio, $profile_picture_path, $username, $gender, $show_email, $public_email, $email);

if ($updateStmt->execute()) {
    // Also update all author names in their posts to match the new creator name!
    $updatePostsSql = "UPDATE blog_posts SET author = ? WHERE email = ?";
    $updatePostsStmt = $conn->prepare($updatePostsSql);
    if ($updatePostsStmt) {
        $updatePostsStmt->bind_param("ss", $name, $email);
        $updatePostsStmt->execute();
        $updatePostsStmt->close();
    }

    echo json_encode([
        'success' => true,
        'message' => 'Profile updated successfully',
        'name' => $name,
        'bio' => $bio,
        'profile_picture' => $profile_picture_path,
        'username' => $username,
        'gender' => $gender,
        'show_email' => $show_email,
        'public_email' => $public_email
    ]);
} else {
    http_response_code(500);
    echo json_encode(['error' => 'Database update failed: ' . $updateStmt->error]);
}

$updateStmt->close();
$conn->close();
?>
