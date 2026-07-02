<?php
require('../cors-handler.php');
require('../Getdatabase.php');
require('db_init.php');

header("Content-Type: application/json; charset=UTF-8");

// Automatically initialize tables/columns if not exist
initialize_database($conn);

if (!isset($_GET['email'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Email parameter is required']);
    exit();
}

$email = trim($_GET['email']);

$sql = "SELECT name, bio, profile_picture, username, gender, show_email, public_email FROM blog_creators WHERE email = ? LIMIT 1";
$stmt = $conn->prepare($sql);
if (!$stmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to prepare statement']);
    exit();
}

$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result && $result->num_rows === 1) {
    $row = $result->fetch_assoc();
    $profile_picture = $row['profile_picture'];
    $gender = strtolower($row['gender'] ?? 'male');
    
    // Resolve profile picture with gender default if empty
    if (empty($profile_picture)) {
        if ($gender === 'female') {
            $profile_picture = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%23f472b6"/><path d="M50 28a15 15 0 1 0 0 30 15 15 0 1 0 0-30z" fill="%230f172a"/><path d="M50 64c-18 0-33 11-33 22v4h66v-4c0-11-15-22-33-22z" fill="%230f172a"/></svg>';
        } else if ($gender === 'trans' || $gender === 'transgender' || $gender === 'other') {
            $profile_picture = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%23a855f7"/><path d="M50 29a15 15 0 1 0 0 30 15 15 0 1 0 0-30z" fill="%230f172a"/><path d="M50 64c-18 0-33 11-33 22v4h66v-4c0-11-15-22-33-22z" fill="%230f172a"/></svg>';
        } else {
            $profile_picture = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%2338bdf8"/><path d="M50 30a16 16 0 1 0 0 32 16 16 0 1 0 0-32z" fill="%230f172a"/><path d="M50 66c-18.5 0-34 11-34 22v4h68v-4c0-11-15.5-22-34-22z" fill="%230f172a"/></svg>';
        }
    }
    
    echo json_encode([
        'exists' => true,
        'name' => $row['name'],
        'bio' => $row['bio'],
        'profile_picture' => $profile_picture,
        'username' => $row['username'],
        'gender' => $row['gender'],
        'show_email' => intval($row['show_email'] ?? 0),
        'public_email' => $row['public_email']
    ]);
} else {
    echo json_encode(['exists' => false]);
}

$stmt->close();
$conn->close();
?>
