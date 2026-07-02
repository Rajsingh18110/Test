<?php
require('../cors-handler.php');
require('../Getdatabase.php');

header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

if (isset($_GET['id']) && !empty($_GET['id'])) {
    $id = intval($_GET['id']);
    $sql = "SELECT p.id, p.title, p.description, p.author, p.content, p.created_at, p.slug, p.email, p.views, p.likes, p.dislikes, p.reading_time, c.username, c.profile_picture, c.gender 
            FROM blog_posts p 
            LEFT JOIN (
                SELECT email, username, profile_picture, gender 
                FROM blog_creators gc
                WHERE gc.id = (SELECT MIN(id) FROM blog_creators WHERE email = gc.email)
            ) c ON p.email = c.email 
            WHERE p.id = ? LIMIT 1";
    $stmt = $conn->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result && $result->num_rows > 0) {
            $post = $result->fetch_assoc();
            echo json_encode($post);
        } else {
            http_response_code(404);
            echo json_encode(['error' => 'Post not found']);
        }
        $stmt->close();
    } else {
        http_response_code(550);
        echo json_encode(['error' => 'Failed to prepare query']);
    }
} else {
    http_response_code(400);
    echo json_encode(['error' => 'ID parameter is required']);
}

$conn->close();
?>