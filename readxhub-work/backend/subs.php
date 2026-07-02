<?php
/**
 * subs.php – Subscription feed API
 * Follows EXACT same pattern as subscribe.php + fetch_new_blogs.php
 */
require('../cors-handler.php');
require('../Getdatabase.php');

header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

if (!isset($conn) || !$conn) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection failed']);
    exit();
}

$email = trim($_GET['email'] ?? '');
if (empty($email)) {
    http_response_code(400);
    echo json_encode(['error' => 'Email parameter is required']);
    exit();
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. Subscribed creators
//    Uses the SAME subquery-dedup pattern as fetch_new_blogs.php
// ─────────────────────────────────────────────────────────────────────────────
$creatorsSQL = "
    SELECT  c.name, c.bio, c.profile_picture, c.username, c.email, c.gender
    FROM    creator_subscriptions s
    JOIN    (
                SELECT email, name, bio, username, profile_picture, gender
                FROM   blog_creators bc
                WHERE  bc.id = (SELECT MIN(id) FROM blog_creators WHERE email = bc.email)
            ) c ON s.creator_email = c.email
    WHERE   s.subscriber_email = ?
    ORDER   BY s.id DESC
";

$creatorsStmt = $conn->prepare($creatorsSQL);
if (!$creatorsStmt) {
    http_response_code(500);
    echo json_encode(['error' => 'creators prepare failed: ' . $conn->error]);
    $conn->close();
    exit();
}

$creatorsStmt->bind_param('s', $email);
$creatorsStmt->execute();
$creators = $creatorsStmt->get_result()->fetch_all(MYSQLI_ASSOC);
$creatorsStmt->close();

// ─────────────────────────────────────────────────────────────────────────────
// 2. Recent posts from subscribed creators
//    Same subquery-dedup pattern for blog_creators lookup
// ─────────────────────────────────────────────────────────────────────────────
$postsSQL = "
    SELECT  p.id, p.title, p.description, p.slug, p.url,
            p.created_at, p.email, p.author,
            p.views, p.likes, p.dislikes,
            c.username, c.profile_picture, c.gender, c.name AS creator_name
    FROM    creator_subscriptions s
    JOIN    blog_posts p ON s.creator_email = p.email
    LEFT JOIN (
                SELECT email, username, profile_picture, gender, name
                FROM   blog_creators bc
                WHERE  bc.id = (SELECT MIN(id) FROM blog_creators WHERE email = bc.email)
            ) c ON p.email = c.email
    WHERE   s.subscriber_email = ?
    ORDER   BY p.created_at DESC
    LIMIT   50
";

$postsStmt = $conn->prepare($postsSQL);
if (!$postsStmt) {
    http_response_code(500);
    echo json_encode(['error' => 'posts prepare failed: ' . $conn->error]);
    $conn->close();
    exit();
}

$postsStmt->bind_param('s', $email);
$postsStmt->execute();
$posts = $postsStmt->get_result()->fetch_all(MYSQLI_ASSOC);
$postsStmt->close();
$conn->close();

echo json_encode([
    'creators' => $creators,
    'posts'    => $posts,
]);
?>
