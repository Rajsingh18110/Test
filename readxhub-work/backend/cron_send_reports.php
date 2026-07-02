<?php
// Ensure errors are logged instead of printed directly (cron safety)
ini_set('display_errors', 0);
ini_set('log_errors', 1);
error_reporting(E_ALL);

require_once(__DIR__ . '/../Getdatabase.php');
require_once(__DIR__ . '/db_init.php');

if (!isset($conn) || !$conn) {
    error_log('CRON ERROR: Database connection is unavailable.');
    echo json_encode(["status" => "error", "message" => "Database connection is unavailable."]);
    exit();
}

// Run database auto-check/migration first to ensure blog_reports table exists
initialize_database($conn);

/* ==========================================================================
   SMTP CONFIGURATION
   ========================================================================== */
define('SMTP_HOST', 'smtp.hostinger.com');        // Hostinger SMTP host
define('SMTP_PORT', 465);                         // 465 (SSL)
define('SMTP_USER', 'no-reply@readxhub.in');    // SMTP Username
define('SMTP_PASS', 'Adarsh@Lucky@10100');        // SMTP Password
define('SMTP_FROM_EMAIL', 'no-reply@readxhub.in');
define('SMTP_FROM_NAME', 'ReadXHub Admin');
define('SMTP_SECURE', 'ssl');                     // 'ssl' or 'tls'

// Load PHPMailer
$autoload_path = __DIR__ . '/../vendor/autoload.php';
$vendor_phpmailer_dir = __DIR__ . '/../vendor/phpmailer/src/';
$local_phpmailer_dir = __DIR__ . '/PHPMailer/src/';

if (file_exists($autoload_path)) {
    require_once $autoload_path;
} elseif (file_exists($vendor_phpmailer_dir . 'PHPMailer.php')) {
    require_once $vendor_phpmailer_dir . 'Exception.php';
    require_once $vendor_phpmailer_dir . 'PHPMailer.php';
    require_once $vendor_phpmailer_dir . 'SMTP.php';
} elseif (file_exists($local_phpmailer_dir . 'PHPMailer.php')) {
    require_once $local_phpmailer_dir . 'Exception.php';
    require_once $local_phpmailer_dir . 'PHPMailer.php';
    require_once $local_phpmailer_dir . 'SMTP.php';
} else {
    error_log("CRON ERROR: PHPMailer files not found in vendor or local directory.");
    echo json_encode(["status" => "error", "message" => "PHPMailer files missing."]);
    exit();
}

if (!class_exists('PHPMailer\\PHPMailer\\PHPMailer') || !class_exists('PHPMailer\\PHPMailer\\Exception')) {
    error_log('CRON ERROR: PHPMailer classes are unavailable.');
    echo json_encode(["status" => "error", "message" => "PHPMailer classes unavailable."]);
    exit();
}

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// Fetch unsent reports from the generic reports table
$reportsSql = "
    SELECT r.id, r.target_type, r.blog_id, r.comment_id, r.target_identifier,
           r.reporter_email, r.report_notes, r.reported_user_email, r.reported_user_name,
           r.created_at, p.title AS blog_title, p.slug AS blog_slug
    FROM reports r
    LEFT JOIN blog_posts p ON r.blog_id = p.id
    WHERE r.email_sent = 0
    ORDER BY r.created_at ASC
    LIMIT 50
";
$result = $conn->query($reportsSql);

if (!$result) {
    error_log("CRON ERROR: Failed to query unsent reports: " . $conn->error);
    exit();
}

$reportIds = [];

while ($row = $result->fetch_assoc()) {
    $reportIds[] = (int)$row['id'];

    $adminSubject = "ReadXHub Report: " . ucfirst($row['target_type']) . " (#" . $row['id'] . ")";
    $reporterSubject = "ReadXHub - We received your report";

    $targetDetails = "";
    if ($row['target_type'] === 'article') {
        $targetDetails = "<p><strong>Article:</strong> " . htmlspecialchars($row['blog_title'] ?: 'Unknown') . "</p>";
        if (!empty($row['blog_slug'])) {
            $targetDetails .= "<p><strong>Link:</strong> <a href=\"https://readxhub.in/blog/" . htmlspecialchars($row['blog_slug']) . "\" target=\"_blank\">View Article</a></p>";
        }
    } elseif ($row['target_type'] === 'comment') {
        $targetDetails = "<p><strong>Comment ID:</strong> " . intval($row['comment_id']) . "</p>";
        if (!empty($row['target_identifier'])) {
            $targetDetails .= "<p><strong>Excerpt:</strong> " . htmlspecialchars($row['target_identifier']) . "</p>";
        }
    } else {
        $targetDetails = "<p><strong>Profile Email:</strong> " . htmlspecialchars($row['reported_user_email']) . "</p>";
        if (!empty($row['reported_user_name'])) {
            $targetDetails .= "<p><strong>Profile Name:</strong> " . htmlspecialchars($row['reported_user_name']) . "</p>";
        }
    }

    $adminBody = "<html><body>"
        . "<h2>New Report Submitted</h2>"
        . "<p><strong>Target Type:</strong> " . ucfirst(htmlspecialchars($row['target_type'])) . "</p>"
        . $targetDetails
        . "<p><strong>Reported User:</strong> " . htmlspecialchars($row['reported_user_name'] ?: 'Unknown') . " (" . htmlspecialchars($row['reported_user_email']) . ")</p>"
        . "<p><strong>Reporter Email:</strong> " . htmlspecialchars($row['reporter_email']) . "</p>"
        . "<p><strong>Report Notes:</strong></p>"
        . "<div style='white-space: pre-wrap; padding: 12px; border: 1px solid #e2e8f0; background: #f8fafc; color: #111827; border-radius: 8px; margin-bottom: 16px;'>" . nl2br(htmlspecialchars($row['report_notes'])) . "</div>"
        . "<p><strong>Submitted At:</strong> " . date('M d, Y H:i:s', strtotime($row['created_at'])) . "</p>"
        . "</body></html>";

    $reporterBody = "<html><body>"
        . "<h2>We received your report</h2>"
        . "<p>Thank you for reporting this content. Our review team will investigate the report and follow up if further action is required.</p>"
        . "<p><strong>Report Type:</strong> " . ucfirst(htmlspecialchars($row['target_type'])) . "</p>"
        . $targetDetails
        . "<p><strong>Your report:</strong></p>"
        . "<div style='white-space: pre-wrap; padding: 12px; border: 1px solid #e2e8f0; background: #f8fafc; color: #111827; border-radius: 8px; margin-bottom: 16px;'>" . nl2br(htmlspecialchars($row['report_notes'])) . "</div>"
        . "<p>We will review this as soon as possible.</p>"
        . "</body></html>";

    try {
        $mail = new PHPMailer(true);
        $mail->isSMTP();
        $mail->Host       = SMTP_HOST;
        $mail->SMTPAuth   = true;
        $mail->Username   = SMTP_USER;
        $mail->Password   = SMTP_PASS;
        $mail->SMTPSecure = SMTP_SECURE;
        $mail->Port       = SMTP_PORT;

        $mail->setFrom(SMTP_FROM_EMAIL, SMTP_FROM_NAME);
        $mail->addAddress($adminEmail);
        $mail->addReplyTo($row['reporter_email']);

        $mail->isHTML(true);
        $mail->Subject = $adminSubject;
        $mail->Body    = $adminBody;
        $mail->AltBody = strip_tags($adminBody);
        $mail->send();

        $reporterMail = new PHPMailer(true);
        $reporterMail->isSMTP();
        $reporterMail->Host       = SMTP_HOST;
        $reporterMail->SMTPAuth   = true;
        $reporterMail->Username   = SMTP_USER;
        $reporterMail->Password   = SMTP_PASS;
        $reporterMail->SMTPSecure = SMTP_SECURE;
        $reporterMail->Port       = SMTP_PORT;

        $reporterMail->setFrom(SMTP_FROM_EMAIL, SMTP_FROM_NAME);
        $reporterMail->addAddress($row['reporter_email']);
        $reporterMail->isHTML(true);
        $reporterMail->Subject = $reporterSubject;
        $reporterMail->Body    = $reporterBody;
        $reporterMail->AltBody = strip_tags($reporterBody);
        $reporterMail->send();
    } catch (Exception $e) {
        error_log("CRON ERROR: Failed to send report email for report #" . intval($row['id']) . ": " . $e->getMessage());
        continue;
    }
}

if (!empty($reportIds)) {
    $idsPlaceholder = implode(',', array_map('intval', $reportIds));
    $conn->query("UPDATE reports SET email_sent = 1 WHERE id IN ($idsPlaceholder)");
}

echo json_encode(["status" => "success", "message" => "Report notifications processed."]);

$conn->close();

