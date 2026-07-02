<?php
require('../cors-handler.php');
require('../Getdatabase.php');
header("Content-Type: application/json; charset=UTF-8");

// Check if slug parameter is provided
if (!isset($_GET['slug']) || empty($_GET['slug'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Slug parameter is required']);
    exit();
}

$slug = $_GET['slug'];

// Prepare and execute query to fetch blog by slug
$sql = "SELECT id, title, content, author, created_at, slug FROM blog_posts WHERE slug = ?";
$stmt = $conn->prepare($sql);
if ($stmt === false) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to prepare statement']);
    exit();
}

$stmt->bind_param("s", $slug);
$stmt->execute();
$result = $stmt->get_result();

if ($result && $result->num_rows > 0) {
    $blog = $result->fetch_assoc();
    echo json_encode($blog);
} else {
    http_response_code(404);
    echo json_encode(['error' => 'Blog not found']);
}

$stmt->close();
$conn->close();
?>