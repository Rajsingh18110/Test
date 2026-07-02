<?php
require('../cors-handler.php');
require('../Getdatabase.php');

header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$input = json_decode(file_get_contents('php://input'), true);
$slugs = $input['slugs'] ?? [];

if (!is_array($slugs) || empty($slugs)) {
    echo json_encode([]);
    exit();
}

// Prepare dynamic placeholder query safely
$placeholders = implode(',', array_fill(0, count($slugs), '?'));
$sql = "SELECT slug, views FROM blog_posts WHERE slug IN ($placeholders)";

$stmt = $conn->prepare($sql);
if (!$stmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to prepare statement']);
    exit();
}

// Bind dynamic parameters
$types = str_repeat('s', count($slugs));
$stmt->bind_param($types, ...$slugs);
$stmt->execute();
$result = $stmt->get_result();

$views = [];
while ($row = $result->fetch_assoc()) {
    $views[$row['slug']] = intval($row['views']);
}

// Ensure all input slugs have a value in the response
foreach ($slugs as $slug) {
    if (!isset($views[$slug])) {
        $views[$slug] = 0;
    }
}

echo json_encode($views);

$stmt->close();
$conn->close();
?>
