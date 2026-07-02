<?php
require('../cors-handler.php');
require('../Getdatabase.php');

header('Content-Type: application/json; charset=UTF-8');

if (!$conn) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection is unavailable.']);
    exit;
}

// Only allow POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    exit;
}

$payload = json_decode(file_get_contents('php://input'), true);
if (!$payload) {
    $payload = $_POST;
}

$user_email = null;
if (isset($_COOKIE['auth_token']) && !empty($_COOKIE['auth_token'])) {
    $user_email = filter_var(trim($_COOKIE['auth_token']), FILTER_VALIDATE_EMAIL);
}

$bodyEmail = trim($payload['user_email'] ?? $payload['email'] ?? '');
if (empty($user_email) && !empty($bodyEmail)) {
    $bodyEmail = filter_var($bodyEmail, FILTER_VALIDATE_EMAIL);
    if ($bodyEmail) {
        $user_email = $bodyEmail;
    }
}

$blog_id = isset($payload['blog_id']) ? intval($payload['blog_id']) : 0;
$reaction = isset($payload['reaction']) && in_array($payload['reaction'], ['like', 'dislike'], true)
    ? $payload['reaction']
    : '';

if (empty($user_email)) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

if ($blog_id <= 0 || $reaction === '') {
    http_response_code(400);
    echo json_encode(['error' => 'Missing or invalid blog_id or reaction']);
    exit;
}

$conn->begin_transaction();
try {
    // Ensure blog exists
    $stmt = $conn->prepare('SELECT likes, dislikes, views FROM blog_posts WHERE id = ?');
    if (!$stmt) {
        throw new Exception('Prepare failed: ' . $conn->error);
    }
    $stmt->bind_param('i', $blog_id);
    $stmt->execute();
    $res = $stmt->get_result();
    if ($res->num_rows === 0) {
        http_response_code(404);
        echo json_encode(['error' => 'Blog not found']);
        $stmt->close();
        exit;
    }
    $blog = $res->fetch_assoc();
    $stmt->close();

    // Check if user already reacted
    $stmt = $conn->prepare('SELECT reaction FROM blog_reactions WHERE blog_id = ? AND user_email = ?');
    if (!$stmt) {
        throw new Exception('Database query failed: ' . $conn->error);
    }
    $stmt->bind_param('is', $blog_id, $user_email);
    $stmt->execute();
    $res = $stmt->get_result();
    $existing = $res ? $res->fetch_assoc() : null;
    $stmt->close();

    $trending_update_sql = "
        UPDATE blog_posts 
        SET trending_score = ((views * 1) + (likes * 5)) / POWER(GREATEST(TIMESTAMPDIFF(HOUR, publish_date, NOW()), 0) + 2, 1.5)
        WHERE id = $blog_id
    ";

    if ($existing) {
        if ($existing['reaction'] === $reaction) {
            $conn->commit();
            echo json_encode(['likes' => $blog['likes'], 'dislikes' => $blog['dislikes']]);
            exit;
        }
        // Change reaction: decrement previous, increment new
        $decrement_col = $existing['reaction'] === 'like' ? 'likes' : 'dislikes';
        $increment_col = $reaction === 'like' ? 'likes' : 'dislikes';
        
        $stmt = $conn->prepare("UPDATE blog_posts SET $decrement_col = GREATEST($decrement_col-1,0), $increment_col = $increment_col + 1 WHERE id = ?");
        $stmt->bind_param('i', $blog_id);
        if (!$stmt->execute()) {
            throw new Exception('Unable to update reaction counts.');
        }
        $stmt->close();

        $stmt = $conn->prepare('UPDATE blog_reactions SET reaction = ? WHERE blog_id = ? AND user_email = ?');
        $stmt->bind_param('sis', $reaction, $blog_id, $user_email);
        if (!$stmt->execute()) {
            throw new Exception('Unable to update existing reaction.');
        }
        $stmt->close();
    } else {
        // New reaction
        $stmt = $conn->prepare('INSERT INTO blog_reactions (blog_id, user_email, reaction) VALUES (?,?,?)');
        $stmt->bind_param('iss', $blog_id, $user_email, $reaction);
        if (!$stmt->execute()) {
            throw new Exception('Unable to save the reaction.');
        }
        $stmt->close();

        $col = $reaction === 'like' ? 'likes' : 'dislikes';
        $stmt = $conn->prepare("UPDATE blog_posts SET $col = $col + 1 WHERE id = ?");
        $stmt->bind_param('i', $blog_id);
        if (!$stmt->execute()) {
            throw new Exception('Unable to update blog like/dislike counts.');
        }
        $stmt->close();
    }

    // Attempt to update trending score if the column exists
    try {
        $conn->query($trending_update_sql);
    } catch (Throwable $e) {
        // Ignore if column doesn't exist yet
    }
    
    $conn->commit();

    // Return updated counts
    $stmt = $conn->prepare('SELECT likes, dislikes FROM blog_posts WHERE id = ?');
    $stmt->bind_param('i', $blog_id);
    $stmt->execute();
    $res = $stmt->get_result();
    $updated = $res->fetch_assoc();
    $stmt->close();

    echo json_encode(['likes' => $updated['likes'], 'dislikes' => $updated['dislikes']]);

} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}

$conn->close();
?>
