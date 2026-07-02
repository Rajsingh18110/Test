<?php
require('../cors-handler.php');
require('../Getdatabase.php');

header('Content-Type: application/json; charset=UTF-8');

if (!$conn) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection is unavailable.']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

if (!isset($_GET['blog_id'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing blog_id']);
    exit;
}
$blog_id = intval($_GET['blog_id']);

// List mode (default): lightweight metadata only, newest first
if (!isset($_GET['revision_id'])) {
    $stmt = $conn->prepare('
        SELECT id, title, edited_by_name, edited_by_email, edit_summary, created_at
        FROM blog_revisions
        WHERE blog_id = ?
        ORDER BY created_at DESC
    ');
    $stmt->bind_param('i', $blog_id);
    $stmt->execute();
    $res = $stmt->get_result();
    $revisions = [];
    while ($row = $res->fetch_assoc()) {
        $row['id'] = (int)$row['id'];
        $revisions[] = $row;
    }
    $stmt->close();
    echo json_encode($revisions);
    $conn->close();
    exit;
}

// Single revision mode: full content, for diff/restore views
$revision_id = intval($_GET['revision_id']);
$stmt = $conn->prepare('SELECT * FROM blog_revisions WHERE id = ? AND blog_id = ?');
$stmt->bind_param('ii', $revision_id, $blog_id);
$stmt->execute();
$res = $stmt->get_result();
if ($res->num_rows === 0) {
    http_response_code(404);
    echo json_encode(['error' => 'Revision not found']);
    exit;
}
echo json_encode($res->fetch_assoc());
$conn->close();
