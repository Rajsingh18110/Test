<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require('../cors-handler.php');
require('../Getdatabase.php');

header("Content-Type: application/json; charset=UTF-8");

if (!isset($conn) || !$conn) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'Database connection is unavailable.']);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    $input = $_POST;
}

$target_type = isset($input['target_type']) ? trim($input['target_type']) : '';
$reporter_email = isset($input['reporter_email']) ? trim($input['reporter_email']) : '';
$report_notes = isset($input['report_notes']) ? trim($input['report_notes']) : '';
$blog_id = isset($input['blog_id']) ? intval($input['blog_id']) : null;
$comment_id = isset($input['comment_id']) ? intval($input['comment_id']) : null;
$reported_user_email = isset($input['reported_user_email']) ? trim($input['reported_user_email']) : '';
$reported_user_name = isset($input['reported_user_name']) ? trim($input['reported_user_name']) : '';
$target_identifier = isset($input['target_identifier']) ? trim($input['target_identifier']) : '';
$logged_in_email = isset($_COOKIE['auth_token']) ? trim($_COOKIE['auth_token']) : '';

if (!empty($logged_in_email) && !filter_var($logged_in_email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Invalid authenticated email token']);
    exit();
}

if (empty($logged_in_email)) {
    http_response_code(401);
    echo json_encode(['success' => false, 'error' => 'Login is required to submit a report']);
    exit();
}

$reporter_email = $logged_in_email;

$allowedTypes = ['article', 'comment', 'profile'];
if (!in_array($target_type, $allowedTypes, true)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Invalid report type']);
    exit();
}

if (empty($reporter_email) || !filter_var($reporter_email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'A valid reporting email is required']);
    exit();
}

if (empty($report_notes)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Report details are required']);
    exit();
}

if ($target_type === 'article') {
    if (!$blog_id || $blog_id <= 0) {
        http_response_code(400);
        echo json_encode(['success' => false, 'error' => 'Invalid article identifier']);
        exit();
    }
    $checkSql = "SELECT id, author, email, title, slug FROM blog_posts WHERE id = ? LIMIT 1";
    $checkStmt = $conn->prepare($checkSql);
    if (!$checkStmt) {
        http_response_code(500);
        echo json_encode(['success' => false, 'error' => 'Database error preparing article lookup']);
        exit();
    }
    $checkStmt->bind_param("i", $blog_id);
    $checkStmt->execute();
    $result = $checkStmt->get_result();
    if ($result->num_rows === 0) {
        http_response_code(404);
        echo json_encode(['success' => false, 'error' => 'Article not found']);
        $checkStmt->close();
        exit();
    }
    $article = $result->fetch_assoc();
    $reported_user_email = $article['email'];
    $reported_user_name = $article['author'];
    $target_identifier = $article['slug'];
    $checkStmt->close();
}

if ($target_type === 'comment') {
    if (!$comment_id || $comment_id <= 0) {
        http_response_code(400);
        echo json_encode(['success' => false, 'error' => 'Invalid comment identifier']);
        exit();
    }
    $checkSql = "SELECT id, blog_id, user_email, user_name, text FROM blogcomment WHERE id = ? LIMIT 1";
    $checkStmt = $conn->prepare($checkSql);
    if (!$checkStmt) {
        http_response_code(500);
        echo json_encode(['success' => false, 'error' => 'Database error preparing comment lookup']);
        exit();
    }
    $checkStmt->bind_param("i", $comment_id);
    $checkStmt->execute();
    $result = $checkStmt->get_result();
    if ($result->num_rows === 0) {
        http_response_code(404);
        echo json_encode(['success' => false, 'error' => 'Comment not found']);
        $checkStmt->close();
        exit();
    }
    $comment = $result->fetch_assoc();
    $blog_id = $comment['blog_id'];
    $reported_user_email = $comment['user_email'];
    $reported_user_name = $comment['user_name'];
    $target_identifier = substr($comment['text'], 0, 160);
    $checkStmt->close();
}

if ($target_type === 'profile') {
    if (empty($reported_user_email) || !filter_var($reported_user_email, FILTER_VALIDATE_EMAIL)) {
        http_response_code(400);
        echo json_encode(['success' => false, 'error' => 'Valid profile owner email is required']);
        exit();
    }
}

if (!empty($reported_user_email) && strcasecmp($reporter_email, $reported_user_email) === 0) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'You cannot report yourself']);
    exit();
}

$limitSql = "SELECT COUNT(*) as report_count FROM reports WHERE reporter_email = ? AND reported_user_email = ? AND created_at >= DATE_SUB(NOW(), INTERVAL 1 DAY)";
$limitStmt = $conn->prepare($limitSql);
if (!$limitStmt) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'Database error preparing rate limit check']);
    exit();
}
$limitStmt->bind_param("ss", $reporter_email, $reported_user_email);
$limitStmt->execute();
$limitResult = $limitStmt->get_result();
$limitRow = $limitResult->fetch_assoc();
$limitStmt->close();
if ($limitRow && intval($limitRow['report_count']) >= 2) {
    http_response_code(429);
    echo json_encode(['success' => false, 'error' => 'You have already reported this user twice in the last 24 hours.']);
    exit();
}

$insertSql = "INSERT INTO reports (target_type, blog_id, comment_id, target_identifier, reporter_email, reported_user_email, reported_user_name, report_notes, status, email_sent) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'pending', 0)";
$insertStmt = $conn->prepare($insertSql);
if (!$insertStmt) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'Database error preparing report insertion']);
    exit();
}
$targetIdentifierVal = empty($target_identifier) ? null : $target_identifier;
$commentIdVal = $comment_id ?: null;
$blogIdVal = $blog_id ?: null;
$reportedNameVal = empty($reported_user_name) ? null : $reported_user_name;
$insertStmt->bind_param("siisssss", $target_type, $blogIdVal, $commentIdVal, $targetIdentifierVal, $reporter_email, $reported_user_email, $reportedNameVal, $report_notes);

$inserted = $insertStmt->execute();
$reportId = $insertStmt->insert_id;
$insertStmt->close();

$adminEmail = 'adarsh.singhvishnu@gmail.com';
$senderEmail = 'no-reply@readxhub.in';
$senderName = 'ReadXHub Reports';

if ($inserted && $reportId > 0) {
    // Report saved. Acknowledgement email will be delivered by the report cron job.
}

$conn->close();

if ($inserted) {
    echo json_encode(['success' => true, 'message' => 'Report submitted successfully']);
} else {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'Failed to save report.']);
}
?>
