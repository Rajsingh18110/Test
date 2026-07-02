<?php
/**
 * get_subscriptions.php
 * Fetches creators & posts for the subscriptions page.
 * PHP 8.3 safe – does NOT call initialize_database().
 */

// ── 0. Capture stray output + catch fatal errors before they blank-page ──────
ob_start();
ini_set('display_errors', 0);
error_reporting(E_ALL);

register_shutdown_function(function () {
    $e = error_get_last();
    if ($e && in_array($e['type'], [E_ERROR, E_PARSE, E_COMPILE_ERROR, E_CORE_ERROR])) {
        ob_end_clean();
        if (!headers_sent()) {
            http_response_code(500);
            header('Content-Type: application/json; charset=UTF-8');
        }
        echo json_encode([
            'fatal_error' => true,
            'message'     => $e['message'],
            'file'        => basename($e['file']),
            'line'        => $e['line']
        ]);
    }
});

// ── 1. CORS ───────────────────────────────────────────────────────────────────
try {
    require('../cors-handler.php');
} catch (Throwable $e) {
    ob_end_clean();
    if (!headers_sent()) {
        http_response_code(500);
        header('Content-Type: application/json; charset=UTF-8');
    }
    echo json_encode(['error' => 'cors-handler failed: ' . $e->getMessage()]);
    exit();
}
ob_clean(); // discard any stray output from cors-handler

// ── 2. Database ───────────────────────────────────────────────────────────────
try {
    require('../Getdatabase.php');
} catch (Throwable $e) {
    if (!headers_sent()) {
        http_response_code(500);
        header('Content-Type: application/json; charset=UTF-8');
    }
    echo json_encode(['error' => 'Getdatabase failed: ' . $e->getMessage()]);
    exit();
}

ob_end_clean(); // we have clean state now
header('Content-Type: application/json; charset=UTF-8');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// ── 3. Verify connection ──────────────────────────────────────────────────────
if (!isset($conn) || !$conn) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection is null – check Getdatabase.php']);
    exit();
}

// ── 4. Validate input ─────────────────────────────────────────────────────────
$email = trim($_GET['email'] ?? '');
if (empty($email)) {
    http_response_code(400);
    echo json_encode(['error' => 'Email parameter is required']);
    exit();
}

// ── 5. Avatar helper ──────────────────────────────────────────────────────────
function subAvatar($gender) {
    $g = strtolower((string)($gender ?? 'male'));
    if ($g === 'female') {
        return 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%23f472b6"/><path d="M50 28a15 15 0 1 0 0 30 15 15 0 1 0 0-30z" fill="%230f172a"/><path d="M50 64c-18 0-33 11-33 22v4h66v-4c0-11-15-22-33-22z" fill="%230f172a"/></svg>';
    }
    if ($g === 'trans' || $g === 'transgender' || $g === 'other') {
        return 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%23a855f7"/><path d="M50 29a15 15 0 1 0 0 30 15 15 0 1 0 0-30z" fill="%230f172a"/><path d="M50 64c-18 0-33 11-33 22v4h66v-4c0-11-15-22-33-22z" fill="%230f172a"/></svg>';
    }
    return 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%2338bdf8"/><path d="M50 30a16 16 0 1 0 0 32 16 16 0 1 0 0-32z" fill="%230f172a"/><path d="M50 66c-18.5 0-34 11-34 22v4h68v-4c0-11-15.5-22-34-22z" fill="%230f172a"/></svg>';
}

// ── 6. Creators the user subscribes to (safe: ORDER BY s.id) ─────────────────
$creatorsStmt = $conn->prepare("
    SELECT c.name, c.bio, c.profile_picture, c.username, c.email, c.gender
    FROM   creator_subscriptions s
    JOIN   blog_creators c ON s.creator_email = c.email
    WHERE  s.subscriber_email = ?
    ORDER  BY s.id DESC
");

if ($creatorsStmt === false) {
    http_response_code(500);
    echo json_encode(['error' => 'creators prepare failed: ' . $conn->error]);
    $conn->close();
    exit();
}

$creatorsStmt->bind_param('s', $email);
if (!$creatorsStmt->execute()) {
    http_response_code(500);
    echo json_encode(['error' => 'creators execute failed: ' . $creatorsStmt->error]);
    $conn->close();
    exit();
}

$creators = [];
$cr = $creatorsStmt->get_result();
while ($row = $cr->fetch_assoc()) {
    if (empty($row['profile_picture'])) {
        $row['profile_picture'] = subAvatar($row['gender']);
    }
    $creators[] = $row;
}
$creatorsStmt->close();

// ── 7. Recent posts from subscribed creators ──────────────────────────────────
$postsStmt = $conn->prepare("
    SELECT p.id, p.title, p.description, p.keywords, p.author,
           p.content, p.slug, p.url, p.created_at, p.email,
           p.views, p.likes, p.dislikes,
           c.username, c.profile_picture, c.gender
    FROM   creator_subscriptions s
    JOIN   blog_posts p  ON s.creator_email = p.email
    LEFT JOIN blog_creators c ON p.email = c.email
    WHERE  s.subscriber_email = ?
    ORDER  BY p.created_at DESC
    LIMIT  50
");

if ($postsStmt === false) {
    http_response_code(500);
    echo json_encode(['error' => 'posts prepare failed: ' . $conn->error]);
    $conn->close();
    exit();
}

$postsStmt->bind_param('s', $email);
if (!$postsStmt->execute()) {
    http_response_code(500);
    echo json_encode(['error' => 'posts execute failed: ' . $postsStmt->error]);
    $conn->close();
    exit();
}

$posts = [];
$pr = $postsStmt->get_result();
while ($row = $pr->fetch_assoc()) {
    if (empty($row['profile_picture'])) {
        $row['profile_picture'] = subAvatar($row['gender']);
    }
    $posts[] = $row;
}
$postsStmt->close();
$conn->close();

// ── 8. Return ─────────────────────────────────────────────────────────────────
echo json_encode(['creators' => $creators, 'posts' => $posts]);
?>
