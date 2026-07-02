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

// GET: return vote score + this user's vote for one or more comments on a blog
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (!isset($_GET['blog_id'])) {
        http_response_code(400);
        echo json_encode(['error' => 'Missing blog_id']);
        exit;
    }
    $blog_id = intval($_GET['blog_id']);
    $user_email = isset($_GET['user_email']) ? filter_var(trim($_GET['user_email']), FILTER_VALIDATE_EMAIL) : null;

    $stmt = $conn->prepare("
        SELECT cv.comment_id, SUM(cv.vote) AS score
        FROM comment_votes cv
        INNER JOIN blogcomment bc ON bc.id = cv.comment_id
        WHERE bc.blog_id = ?
        GROUP BY cv.comment_id
    ");
    $stmt->bind_param('i', $blog_id);
    $stmt->execute();
    $res = $stmt->get_result();
    $scores = [];
    while ($row = $res->fetch_assoc()) {
        $scores[(int)$row['comment_id']] = (int)$row['score'];
    }
    $stmt->close();

    $myVotes = [];
    if ($user_email) {
        $stmt = $conn->prepare("
            SELECT cv.comment_id, cv.vote
            FROM comment_votes cv
            INNER JOIN blogcomment bc ON bc.id = cv.comment_id
            WHERE bc.blog_id = ? AND cv.user_email = ?
        ");
        $stmt->bind_param('is', $blog_id, $user_email);
        $stmt->execute();
        $res = $stmt->get_result();
        while ($row = $res->fetch_assoc()) {
            $myVotes[(int)$row['comment_id']] = (int)$row['vote'];
        }
        $stmt->close();
    }

    echo json_encode(['scores' => $scores, 'my_votes' => $myVotes]);
    $conn->close();
    exit;
}

// POST: cast/change/remove a vote
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $payload = json_decode(file_get_contents('php://input'), true);
    if (!$payload) { $payload = $_POST; }

    $user_email = null;
    if (isset($_COOKIE['auth_token']) && !empty($_COOKIE['auth_token'])) {
        $user_email = filter_var(trim($_COOKIE['auth_token']), FILTER_VALIDATE_EMAIL);
    }
    $bodyEmail = trim($payload['user_email'] ?? '');
    if (empty($user_email) && !empty($bodyEmail)) {
        $bodyEmail = filter_var($bodyEmail, FILTER_VALIDATE_EMAIL);
        if ($bodyEmail) { $user_email = $bodyEmail; }
    }

    $comment_id = isset($payload['comment_id']) ? intval($payload['comment_id']) : 0;
    $vote = isset($payload['vote']) ? intval($payload['vote']) : null; // 1, -1, or 0 (remove)

    if (empty($user_email)) {
        http_response_code(401);
        echo json_encode(['error' => 'Unauthorized']);
        exit;
    }
    if ($comment_id <= 0 || !in_array($vote, [1, -1, 0], true)) {
        http_response_code(400);
        echo json_encode(['error' => 'Missing or invalid comment_id or vote']);
        exit;
    }

    if ($vote === 0) {
        $stmt = $conn->prepare('DELETE FROM comment_votes WHERE comment_id = ? AND user_email = ?');
        $stmt->bind_param('is', $comment_id, $user_email);
        $stmt->execute();
        $stmt->close();
    } else {
        $stmt = $conn->prepare('
            INSERT INTO comment_votes (comment_id, user_email, vote) VALUES (?, ?, ?)
            ON DUPLICATE KEY UPDATE vote = VALUES(vote)
        ');
        $stmt->bind_param('isi', $comment_id, $user_email, $vote);
        $stmt->execute();
        $stmt->close();
    }

    // Recompute and return the new score
    $stmt = $conn->prepare('SELECT COALESCE(SUM(vote),0) AS score FROM comment_votes WHERE comment_id = ?');
    $stmt->bind_param('i', $comment_id);
    $stmt->execute();
    $res = $stmt->get_result();
    $score = (int)($res->fetch_assoc()['score'] ?? 0);
    $stmt->close();

    // Update comment author's comment_karma ledger (best-effort, non-fatal)
    $authorStmt = $conn->prepare('SELECT user_email FROM blogcomment WHERE id = ?');
    $authorStmt->bind_param('i', $comment_id);
    $authorStmt->execute();
    $authorRes = $authorStmt->get_result();
    if ($authorRow = $authorRes->fetch_assoc()) {
        $authorEmail = $authorRow['user_email'];
        $karmaStmt = $conn->prepare('
            SELECT COALESCE(SUM(cv.vote),0) AS total
            FROM comment_votes cv
            INNER JOIN blogcomment bc ON bc.id = cv.comment_id
            WHERE bc.user_email = ?
        ');
        $karmaStmt->bind_param('s', $authorEmail);
        $karmaStmt->execute();
        $total = (int)($karmaStmt->get_result()->fetch_assoc()['total'] ?? 0);
        $karmaStmt->close();

        $upsert = $conn->prepare('
            INSERT INTO user_karma (user_email, comment_karma) VALUES (?, ?)
            ON DUPLICATE KEY UPDATE comment_karma = VALUES(comment_karma)
        ');
        $upsert->bind_param('si', $authorEmail, $total);
        $upsert->execute();
        $upsert->close();
    }
    $authorStmt->close();

    echo json_encode(['status' => 'success', 'comment_id' => $comment_id, 'score' => $score, 'my_vote' => $vote]);
    $conn->close();
    exit;
}

http_response_code(405);
echo json_encode(['error' => 'Method not allowed']);
