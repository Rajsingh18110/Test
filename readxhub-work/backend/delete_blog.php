<?php
require('../cors-handler.php');
require('../Getdatabase.php');

header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$input = json_decode(file_get_contents('php://input'), true);
$id = $input['id'] ?? '';
$email = $input['email'] ?? '';

if (empty($id) || empty($email)) {
    http_response_code(400);
    echo json_encode(['error' => 'ID and email parameters are required']);
    exit();
}

// Prepare check query to verify email match
$checkSql = "SELECT id FROM blog_posts WHERE id = ? AND email = ? LIMIT 1";
$checkStmt = $conn->prepare($checkSql);
if (!$checkStmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to prepare statement']);
    exit();
}

$checkStmt->bind_param("is", $id, $email);
$checkStmt->execute();
$checkStmt->store_result();

if ($checkStmt->num_rows === 0) {
    http_response_code(403);
    echo json_encode(['error' => 'Unauthorized or post does not exist']);
    $checkStmt->close();
    $conn->close();
    exit();
}
$checkStmt->close();

// Delete the post
$deleteSql = "DELETE FROM blog_posts WHERE id = ?";
$deleteStmt = $conn->prepare($deleteSql);
if (!$deleteStmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to prepare delete statement']);
    $conn->close();
    exit();
}

$deleteStmt->bind_param("i", $id);
if ($deleteStmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Post deleted successfully']);
} else {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to delete post']);
}

$deleteStmt->close();
$conn->close();
?>
