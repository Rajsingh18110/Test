<?php
require('../cors-handler.php');
require('../Getdatabase.php');
require('db_init.php');

header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$q = isset($_GET['q']) ? trim($_GET['q']) : '';

if (empty($q)) {
    echo json_encode([]);
    exit();
}

$search = "%" . $q . "%";
$sql = "SELECT id, name, username, email, bio, profile_picture, gender FROM blog_creators WHERE name LIKE ? OR username LIKE ? OR bio LIKE ? LIMIT 10";

$stmt = $conn->prepare($sql);
if (!$stmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to prepare statement']);
    exit();
}

$stmt->bind_param("sss", $search, $search, $search);
$stmt->execute();
$result = $stmt->get_result();

$authors = [];
while ($row = $result->fetch_assoc()) {
    $profile_picture = $row['profile_picture'];
    $gender = strtolower($row['gender'] ?? 'male');
    if (empty($profile_picture)) {
        if ($gender === 'female') {
            $profile_picture = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%23f472b6"/><path d="M50 28a15 15 0 1 0 0 30 15 15 0 1 0 0-30z" fill="%230f172a"/><path d="M50 64c-18 0-33 11-33 22v4h66v-4c0-11-15-22-33-22z" fill="%230f172a"/></svg>';
        } else if ($gender === 'trans' || $gender === 'transgender' || $gender === 'other') {
            $profile_picture = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%23a855f7"/><path d="M50 29a15 15 0 1 0 0 30 15 15 0 1 0 0-30z" fill="%230f172a"/><path d="M50 64c-18 0-33 11-33 22v4h66v-4c0-11-15-22-33-22z" fill="%230f172a"/></svg>';
        } else {
            $profile_picture = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%2338bdf8"/><path d="M50 30a16 16 0 1 0 0 32 16 16 0 1 0 0-32z" fill="%230f172a"/><path d="M50 66c-18.5 0-34 11-34 22v4h68v-4c0-11-15.5-22-34-22z" fill="%230f172a"/></svg>';
        }
    }
    
    $authors[] = [
        'id' => $row['id'],
        'name' => $row['name'],
        'username' => $row['username'],
        'email' => $row['email'],
        'bio' => $row['bio'],
        'profile_picture' => $profile_picture,
        'gender' => $row['gender']
    ];
}

$stmt->close();
$conn->close();

echo json_encode($authors);
?>
