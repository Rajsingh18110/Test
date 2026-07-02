<?php
require('../cors-handler.php');
require('../Getdatabase.php');

header("Content-Type: application/json; charset=UTF-8");

if (!isset($_GET['id']) && !isset($_GET['slug'])) {
    http_response_code(400);
    echo json_encode(['error' => 'ID or Slug parameter is required']);
    exit();
}

$id = $_GET['id'] ?? '';
$slug = $_GET['slug'] ?? '';

if (!empty($id)) {
    $sql = "SELECT p.id, p.title, p.description, p.author, p.content, p.created_at, p.slug, p.email, p.views, p.likes, p.dislikes, p.reading_time, c.username, c.profile_picture, c.gender 
            FROM blog_posts p 
            LEFT JOIN (
                SELECT email, username, profile_picture, gender 
                FROM blog_creators gc
                WHERE gc.id = (SELECT MIN(id) FROM blog_creators WHERE email = gc.email)
            ) c ON p.email = c.email 
            WHERE p.id = ? LIMIT 1";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $id);
} else {
    $sql = "SELECT p.id, p.title, p.description, p.author, p.content, p.created_at, p.slug, p.email, p.views, p.likes, p.dislikes, p.reading_time, c.username, c.profile_picture, c.gender 
            FROM blog_posts p 
            LEFT JOIN (
                SELECT email, username, profile_picture, gender 
                FROM blog_creators gc
                WHERE gc.id = (SELECT MIN(id) FROM blog_creators WHERE email = gc.email)
            ) c ON p.email = c.email 
            WHERE p.slug = ? LIMIT 1";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $slug);
}

if (!$stmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to prepare statement']);
    exit();
}

$stmt->execute();
$result = $stmt->get_result();

if ($result && $result->num_rows === 1) {
    echo json_encode($result->fetch_assoc());
} else {
    http_response_code(404);
    echo json_encode(['error' => 'Blog post not found']);
}

$stmt->close();
$conn->close();
?>
