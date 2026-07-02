<?php
require('../cors-handler.php');
require('../Getdatabase.php');
require('db_init.php');

// Automatically initialize tables/columns if not exist
initialize_database($conn);

header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$limit = isset($_GET['limit']) ? intval($_GET['limit']) : 50;
$offset = isset($_GET['offset']) ? intval($_GET['offset']) : 0;
$q = isset($_GET['q']) ? trim($_GET['q']) : '';
$sort = isset($_GET['sort']) ? trim($_GET['sort']) : 'recent';

$orderBy = "ORDER BY p.publish_date DESC";
if ($sort === 'trending') {
    $orderBy = "ORDER BY p.trending_score DESC, p.publish_date DESC";
} else if ($sort === 'popular') {
    $orderBy = "ORDER BY p.views DESC, p.likes DESC";
}

if ($limit <= 0) $limit = 50;
if ($offset < 0) $offset = 0;

$posts = [];

if ($q !== '') {
    // Search query
    $search = "%" . $q . "%";
    $sql = "
        SELECT p.*, c.username, c.profile_picture, c.gender 
        FROM blog_posts p
        LEFT JOIN (
            SELECT email, username, profile_picture, gender 
            FROM blog_creators gc
            WHERE gc.id = (SELECT MIN(id) FROM blog_creators WHERE email = gc.email)
        ) c ON p.email = c.email
        WHERE p.status = 'published' AND (p.title LIKE ? OR p.description LIKE ? OR p.keywords LIKE ? OR p.content LIKE ?)
        $orderBy 
        LIMIT ? OFFSET ?
    ";
    
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to prepare search statement']);
        exit();
    }
    
    $stmt->bind_param("ssssii", $search, $search, $search, $search, $limit, $offset);
    $stmt->execute();
    $result = $stmt->get_result();
    
    while ($row = $result->fetch_assoc()) {
        $posts[] = $row;
    }
    $stmt->close();
} else {
    // Normal query
    $sql = "
        SELECT p.*, c.username, c.profile_picture, c.gender
        FROM blog_posts p
        LEFT JOIN (
            SELECT email, username, profile_picture, gender 
            FROM blog_creators gc
            WHERE gc.id = (SELECT MIN(id) FROM blog_creators WHERE email = gc.email)
        ) c ON p.email = c.email
        WHERE p.status = 'published'
        $orderBy 
        LIMIT ? OFFSET ?
    ";
    
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to prepare query statement']);
        exit();
    }
    
    $stmt->bind_param("ii", $limit, $offset);
    $stmt->execute();
    $result = $stmt->get_result();
    
    while ($row = $result->fetch_assoc()) {
        $posts[] = $row;
    }
    $stmt->close();
}

$conn->close();
echo json_encode($posts);
?>
