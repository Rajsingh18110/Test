<?php
require('../cors-handler.php');
require('../Getdatabase.php');
require('db_init.php');

header("Content-Type: application/json; charset=UTF-8");

if (!isset($conn) || !$conn) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection is unavailable.']);
    exit();
}

// Automatically initialize tables/columns if not exist
initialize_database($conn);

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// 1. Resolve inputs
if ($method === 'POST') {
    // Check if JSON payload or form-encoded
    $data = json_decode(file_get_contents("php://input"), true);
    if (!$data) {
        $data = $_POST;
    }
} else {
    $data = $_GET;
}

$action = trim($data['action'] ?? '');
$creator_identifier = trim($data['creator_identifier'] ?? '');
$subscriber_email   = trim($data['subscriber_email'] ?? $data['email'] ?? '');
$logged_in_email    = isset($_COOKIE['auth_token']) ? trim($_COOKIE['auth_token']) : '';

if (!empty($logged_in_email) && !filter_var($logged_in_email, FILTER_VALIDATE_EMAIL)) {
    $logged_in_email = '';
}

// Fall back to the provided subscriber email only when the login cookie is absent or invalid.
if (empty($logged_in_email) && !empty($subscriber_email) && filter_var($subscriber_email, FILTER_VALIDATE_EMAIL)) {
    $logged_in_email = $subscriber_email;
}

if (in_array($action, ['subscribe', 'unsubscribe', 'check', 'get_feed'], true)) {
    if (empty($logged_in_email)) {
        http_response_code(401);
        echo json_encode(['error' => 'Login is required to manage subscriptions']);
        exit();
    }

    // Always use the authenticated login email for subscription requests.
    $subscriber_email = $logged_in_email;
}

if (empty($action) || (empty($creator_identifier) && $action !== 'get_feed') || empty($subscriber_email)) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing required fields (action, creator_identifier, subscriber_email)']);
    exit();
}


if (!filter_var($subscriber_email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid subscriber email format']);
    exit();
}

// 2. Resolve Creator Email from Username/Email (Skip for get_feed)
$creator_email = '';
if ($action !== 'get_feed') {
    if (strpos($creator_identifier, '@') !== false) {
        $creator_email = $creator_identifier;
    } else {
        $cStmt = $conn->prepare("SELECT email FROM blog_creators WHERE username = ? LIMIT 1");
        if ($cStmt) {
            $cStmt->bind_param("s", $creator_identifier);
            $cStmt->execute();
            $cRes = $cStmt->get_result();
            if ($row = $cRes->fetch_assoc()) {
                $creator_email = $row['email'];
            }
            $cStmt->close();
        }
    }

    if (empty($creator_email)) {
        http_response_code(404);
        echo json_encode(['error' => 'Creator not found']);
        exit();
    }
}

// 3. Process Actions
$is_self = (strcasecmp($creator_email, $subscriber_email) === 0);

if ($action === 'subscribe') {
    if ($is_self) {
        http_response_code(400);
        echo json_encode(['error' => 'You cannot subscribe to yourself.']);
        exit();
    }

    $stmt = $conn->prepare("INSERT IGNORE INTO creator_subscriptions (creator_email, subscriber_email) VALUES (?, ?)");
    if (!$stmt) {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to prepare insert statement']);
        exit();
    }
    $stmt->bind_param("ss", $creator_email, $subscriber_email);
    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Subscribed successfully']);
    } else {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to execute subscription']);
    }
    $stmt->close();

} else if ($action === 'unsubscribe') {
    $stmt = $conn->prepare("DELETE FROM creator_subscriptions WHERE creator_email = ? AND subscriber_email = ?");
    if (!$stmt) {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to prepare delete statement']);
        exit();
    }
    $stmt->bind_param("ss", $creator_email, $subscriber_email);
    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Unsubscribed successfully']);
    } else {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to execute unsubscription']);
    }
    $stmt->close();

} else if ($action === 'check') {
    if ($is_self) {
        echo json_encode(['subscribed' => false, 'is_self' => true]);
        exit();
    }

    $stmt = $conn->prepare("SELECT id FROM creator_subscriptions WHERE creator_email = ? AND subscriber_email = ? LIMIT 1");
    if (!$stmt) {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to prepare check statement']);
        exit();
    }
    $stmt->bind_param("ss", $creator_email, $subscriber_email);
    $stmt->execute();
    $res = $stmt->get_result();
    $is_subscribed = ($res && $res->num_rows > 0);
    echo json_encode(['subscribed' => $is_subscribed, 'is_self' => false]);
    $stmt->close();

} else if ($action === 'get_feed') {
    // ── Return subscription feed (creators + posts) ───────────────────────
    header('Content-Type: application/json');
    if (empty($subscriber_email)) {
        http_response_code(400);
        echo json_encode(['error' => 'subscriber_email is required for get_feed']);
        $conn->close();
        exit();
    }

    try {
        // Subscribed creators – same subquery dedup pattern as fetch_new_blogs.php
        $creatorsStmt = $conn->prepare("
            SELECT  c.name, c.bio, c.profile_picture, c.username, c.email, c.gender
            FROM    creator_subscriptions s
            JOIN    (
                        SELECT email, name, bio, username, profile_picture, gender
                        FROM   blog_creators bc
                        WHERE  bc.id = (SELECT MIN(id) FROM blog_creators WHERE email COLLATE utf8mb4_unicode_ci = bc.email COLLATE utf8mb4_unicode_ci)
                    ) c ON s.creator_email COLLATE utf8mb4_unicode_ci = c.email COLLATE utf8mb4_unicode_ci
            WHERE   s.subscriber_email COLLATE utf8mb4_unicode_ci = ?
            ORDER   BY s.id DESC
        ");

        $creators = [];
        if ($creatorsStmt) {
            $creatorsStmt->bind_param('s', $subscriber_email);
            $creatorsStmt->execute();
            $cResult = $creatorsStmt->get_result();
            while ($row = $cResult->fetch_assoc()) {
                $creators[] = $row;
            }
            $creatorsStmt->close();
        } else {
            throw new Exception('get_feed creators prepare failed: ' . $conn->error);
        }

        // Recent posts from subscribed creators
        $postsStmt = $conn->prepare("
            SELECT  p.id, p.title, p.description, p.slug, p.url,
                    p.created_at, p.email, p.author,
                    p.views, p.likes, p.dislikes,
                    c.username, c.profile_picture, c.gender, c.name AS creator_name
            FROM    creator_subscriptions s
            JOIN    blog_posts p ON s.creator_email COLLATE utf8mb4_unicode_ci = p.email COLLATE utf8mb4_unicode_ci
            LEFT JOIN (
                        SELECT email, username, profile_picture, gender, name
                        FROM   blog_creators bc
                        WHERE  bc.id = (SELECT MIN(id) FROM blog_creators WHERE email COLLATE utf8mb4_unicode_ci = bc.email COLLATE utf8mb4_unicode_ci)
                    ) c ON p.email COLLATE utf8mb4_unicode_ci = c.email COLLATE utf8mb4_unicode_ci
            WHERE   s.subscriber_email COLLATE utf8mb4_unicode_ci = ?
            ORDER   BY p.created_at DESC
            LIMIT   50
        ");

        $posts = [];
        if ($postsStmt) {
            $postsStmt->bind_param('s', $subscriber_email);
            $postsStmt->execute();
            $pResult = $postsStmt->get_result();
            while ($row = $pResult->fetch_assoc()) {
                $posts[] = $row;
            }
            $postsStmt->close();
        } else {
            throw new Exception('get_feed posts prepare failed: ' . $conn->error);
        }

        echo json_encode(['creators' => $creators, 'posts' => $posts]);

    } catch (Throwable $e) {
        http_response_code(500);
        echo json_encode([
            'error' => $e->getMessage()
        ]);
        exit();
    }

} else {
    http_response_code(400);
    echo json_encode(['error' => 'Unsupported action. Allowed: subscribe, unsubscribe, check, get_feed']);
}

$conn->close();
?>
