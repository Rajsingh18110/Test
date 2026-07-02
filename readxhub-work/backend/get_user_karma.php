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

$email = isset($_GET['user_email']) ? filter_var(trim($_GET['user_email']), FILTER_VALIDATE_EMAIL) : null;
if (!$email) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing or invalid user_email']);
    exit;
}

// Post karma: sum of (likes - dislikes) across all posts by this author
$stmt = $conn->prepare('
    SELECT COALESCE(SUM(likes - dislikes), 0) AS post_karma
    FROM blog_posts
    WHERE email = ?
');
$stmt->bind_param('s', $email);
$stmt->execute();
$postKarma = (int)($stmt->get_result()->fetch_assoc()['post_karma'] ?? 0);
$stmt->close();

// Comment karma: sum of votes on this user's comments
$stmt = $conn->prepare('
    SELECT COALESCE(SUM(cv.vote), 0) AS comment_karma
    FROM comment_votes cv
    INNER JOIN blogcomment bc ON bc.id = cv.comment_id
    WHERE bc.user_email = ?
');
$stmt->bind_param('s', $email);
$stmt->execute();
$commentKarma = (int)($stmt->get_result()->fetch_assoc()['comment_karma'] ?? 0);
$stmt->close();

// Keep the ledger table warm for fast future lookups (best-effort)
$upsert = $conn->prepare('
    INSERT INTO user_karma (user_email, post_karma, comment_karma) VALUES (?, ?, ?)
    ON DUPLICATE KEY UPDATE post_karma = VALUES(post_karma), comment_karma = VALUES(comment_karma)
');
$upsert->bind_param('sii', $email, $postKarma, $commentKarma);
$upsert->execute();
$upsert->close();

echo json_encode([
    'user_email' => $email,
    'post_karma' => $postKarma,
    'comment_karma' => $commentKarma,
    'total_karma' => $postKarma + $commentKarma,
]);
$conn->close();
