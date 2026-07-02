<?php
// Ensure errors are logged instead of printed directly (cron safety)
ini_set('display_errors', 0);
ini_set('log_errors', 1);
error_reporting(E_ALL);

require_once(__DIR__ . '/../Getdatabase.php');
require_once(__DIR__ . '/db_init.php');

// Run database auto-check/migration first
initialize_database($conn);

/* ==========================================================================
   SMTP CONFIGURATION - PLEASE UPDATE THESE ON YOUR HOSTINGER ACCOUNT
   ========================================================================== */
define('SMTP_HOST', 'smtp.hostinger.com');        // Hostinger SMTP host
define('SMTP_PORT', 465);                         // 465 (SSL) or 587 (TLS)
define('SMTP_USER', 'no-reply@readxhub.in');    // SMTP Username
define('SMTP_PASS', 'Adarsh@Lucky@10100');        // SMTP Password
define('SMTP_FROM_EMAIL', 'no-reply@readxhub.in');
define('SMTP_FROM_NAME', 'ReadXHub');
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
    // If PHPMailer isn't found anywhere, log a warning and exit
    error_log("CRON ERROR: PHPMailer files not found in vendor or local directory.");
    echo json_encode(["status" => "error", "message" => "PHPMailer files missing."]);
    exit();
}

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// Fetch up to 5 unsent posts per cron execution to manage system resource usage
$unsentSql = "SELECT id, title, description, slug, author, email, created_at FROM blog_posts WHERE notifications_sent = 0 AND status = 'published' LIMIT 5";
$unsentResult = $conn->query($unsentSql);

if (!$unsentResult) {
    error_log("CRON ERROR: Failed to query unsent posts: " . $conn->error);
    exit();
}

$processed = 0;

while ($post = $unsentResult->fetch_assoc()) {
    $postId = $post['id'];
    $postTitle = $post['title'];
    $postDesc = $post['description'];
    $postSlug = $post['slug'];
    $postAuthor = $post['author'];
    $creatorEmail = $post['email'];
    $postCreatedAt = $post['created_at'];

    // 1. Fetch subscribers for this creator who subscribed BEFORE or AT the time the post was created
    $subSql = "SELECT subscriber_email FROM creator_subscriptions WHERE creator_email = ? AND created_at <= ?";
    $subStmt = $conn->prepare($subSql);
    if (!$subStmt) {
        error_log("CRON ERROR: Failed to prepare subscriber query: " . $conn->error);
        continue;
    }
    
    $subStmt->bind_param("ss", $creatorEmail, $postCreatedAt);
    $subStmt->execute();
    $subResult = $subStmt->get_result();
    
    $subscribers = [];
    while ($row = $subResult->fetch_assoc()) {
        $subscribers[] = $row['subscriber_email'];
    }
    $subStmt->close();

    // 2. If there are subscribers, send the notification email
    if (count($subscribers) > 0) {
        $mail = new PHPMailer(true);

        try {
            // SMTP Settings
            $mail->isSMTP();
            $mail->Host       = SMTP_HOST;
            $mail->SMTPAuth   = true;
            $mail->Username   = SMTP_USER;
            $mail->Password   = SMTP_PASS;
            $mail->SMTPSecure = SMTP_SECURE;
            $mail->Port       = SMTP_PORT;

            // Sender
            $mail->setFrom(SMTP_FROM_EMAIL, SMTP_FROM_NAME);
            
            // To prevent exposing list, send to a dummy address and use BCC for subscribers
            $mail->addAddress(SMTP_FROM_EMAIL, "ReadXHub Readers");
            
            foreach ($subscribers as $emailAddress) {
                $mail->addBCC($emailAddress);
            }

            // Content
            $mail->isHTML(true);
            $mail->Subject = "New Publication from " . $postAuthor . ": " . $postTitle;

            // Styling a premium HTML newsletter template (Dark mode theme aligned with ReadXHub style)
            $articleUrl = "https://readxhub.in/blog/" . $postSlug;
            
            $mail->Body = '
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="utf-8">
            </head>
            <body style="margin:0; padding:0; background-color:#030712; color:#f3f4f6; font-family:-apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Helvetica, Arial, sans-serif;">
                <div style="background-color:#030712; padding:40px 20px; min-height:100%;">
                    <div style="max-width:600px; margin:0 auto; font-family:-apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Helvetica, Arial, sans-serif;">
                        <!-- Header -->
                        <div style="text-align:center; margin-bottom:30px;">
                            <h1 style="color:#ffffff; font-size:24px; font-weight:800; margin:0; letter-spacing:-0.025em; font-family:-apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, sans-serif;">
                                ReadXHub
                            </h1>
                        </div>
                        <!-- Content Card -->
                        <div style="background-color:#111827; border:1px solid #1f2937; border-radius:16px; padding:30px; box-shadow:0 10px 15px -3px rgba(0,0,0,0.3);">
                            <div style="font-size:11px; font-weight:700; text-transform:uppercase; letter-spacing:0.05em; color:#22d3ee; margin-bottom:12px; font-family:-apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, sans-serif;">
                                New Post by ' . htmlspecialchars($postAuthor) . '
                            </div>
                            <h2 style="color:#ffffff; font-size:20px; font-weight:700; line-height:1.3; margin:0 0 15px 0; font-family:-apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, sans-serif;">
                                ' . htmlspecialchars($postTitle) . '
                            </h2>
                            <p style="color:#9ca3af; font-size:14px; line-height:1.6; margin:0 0 25px 0; font-family:-apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, sans-serif;">
                                ' . htmlspecialchars($postDesc) . '
                            </p>
                            <div style="text-align:center;">
                                <a href="' . $articleUrl . '" style="display:inline-block; background-color:#22d3ee; color:#030712; font-weight:750; font-size:13px; text-decoration:none; padding:12px 28px; border-radius:10px; font-family:-apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, sans-serif; box-shadow:0 4px 6px -1px rgba(34,211,238,0.2);">
                                    Read Full Article
                                </a>
                            </div>
                        </div>
                        <!-- Footer -->
                        <div style="text-align:center; margin-top:30px; font-size:11px; color:#4b5563; line-height:1.5; font-family:-apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, sans-serif;">
                            You received this email because you subscribed to ' . htmlspecialchars($postAuthor) . ' on ReadXHub.<br>
                            ReadXHub &copy; ' . date("Y") . ' | Technology, Development, AI & Cybersecurity Publications.
                        </div>
                    </div>
                </div>
            </body>
            </html>
            ';

            $mail->send();
        } catch (Exception $e) {
            error_log("CRON ERROR: Failed to send email for post ID " . $postId . ": " . $mail->ErrorInfo);
            // Skip updating database notifications_sent so we try again next execution
            continue;
        }
    }

    // 3. Mark the post as notification sent
    $updateSql = "UPDATE blog_posts SET notifications_sent = 1 WHERE id = ?";
    $updateStmt = $conn->prepare($updateSql);
    if ($updateStmt) {
        $updateStmt->bind_param("i", $postId);
        $updateStmt->execute();
        $updateStmt->close();
    }
    
    $processed++;
}

$conn->close();
echo json_encode(["status" => "success", "processed_posts" => $processed]);
?>
