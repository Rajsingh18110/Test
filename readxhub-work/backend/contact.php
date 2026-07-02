<?php
require('../cors-handler.php');
require('../Getdatabase.php');

header('Content-Type: application/json; charset=UTF-8');

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

$name = trim($input['name'] ?? '');
$email = trim($input['email'] ?? '');
$subject = trim($input['subject'] ?? 'New message from ReadXHub contact page');
$message = trim($input['message'] ?? '');
$logged_in_email = isset($_COOKIE['auth_token']) ? trim($_COOKIE['auth_token']) : '';

if (!empty($logged_in_email)) {
    $email = $logged_in_email;
}

if (!$name || !$email || !$message) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Name, email, and message are required.']);
    exit();
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Invalid email address.']);
    exit();
}

$adminEmail = 'adarsh.singhvishnu@gmail.com';
$senderEmail = 'no-reply@readxhub.in';
$senderName = 'ReadXHub';

$autoload_path = __DIR__ . '/../vendor/autoload.php';
$vendor_phpmailer_dir = __DIR__ . '/../vendor/phpmailer/src/';
$local_phpmailer_dir = __DIR__ . '/PHPMailer/src/';

$loaded = false;
if (file_exists($autoload_path)) {
    require_once $autoload_path;
    $loaded = true;
} elseif (file_exists($vendor_phpmailer_dir . 'PHPMailer.php')) {
    require_once $vendor_phpmailer_dir . 'Exception.php';
    require_once $vendor_phpmailer_dir . 'PHPMailer.php';
    require_once $vendor_phpmailer_dir . 'SMTP.php';
    $loaded = true;
} elseif (file_exists($local_phpmailer_dir . 'PHPMailer.php')) {
    require_once $local_phpmailer_dir . 'Exception.php';
    require_once $local_phpmailer_dir . 'PHPMailer.php';
    require_once $local_phpmailer_dir . 'SMTP.php';
    $loaded = true;
}

if (!$loaded) {
    error_log('PHPMailer could not be loaded in contact.php');
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'Server mailer is unavailable.']);
    exit();
}

$phpMailerClass = 'PHPMailer\\PHPMailer\\PHPMailer';
$phpMailerExceptionClass = 'PHPMailer\\PHPMailer\\Exception';

if (!class_exists($phpMailerClass) || !class_exists($phpMailerExceptionClass)) {
    error_log('PHPMailer classes are unavailable in contact.php');
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'Server mailer is unavailable.']);
    exit();
}

try {
    $mail = new $phpMailerClass(true);
    $mail->isSMTP();
    $mail->Host       = 'smtp.hostinger.com';
    $mail->SMTPAuth   = true;
    $mail->Username   = 'no-reply@readxhub.in';
    $mail->Password   = 'Adarsh@Lucky@10100';
    $mail->SMTPSecure = 'ssl';
    $mail->Port       = 465;

    $mail->setFrom($senderEmail, $senderName);
    $mail->addReplyTo($email, $name);
    $mail->addAddress($adminEmail);

    $mail->isHTML(true);
    $mail->Subject = $subject;
    $mail->Body = "<html><body>"
        . "<h2>New contact form message</h2>"
        . "<p><strong>Name:</strong> " . htmlspecialchars($name) . "</p>"
        . "<p><strong>Email:</strong> " . htmlspecialchars($email) . "</p>"
        . "<p><strong>Subject:</strong> " . htmlspecialchars($subject) . "</p>"
        . "<p><strong>Message:</strong></p>"
        . "<div style='white-space: pre-wrap; font-family: Arial, sans-serif; background: #f8fafc; padding: 12px; border-radius: 10px; border: 1px solid #d1d5db;'>" . nl2br(htmlspecialchars($message)) . "</div>"
        . "</body></html>";
    $mail->AltBody = "New contact form message\n\nName: $name\nEmail: $email\nSubject: $subject\nMessage:\n$message";

    if ($mail->send()) {
        echo json_encode(['success' => true, 'message' => 'Message sent successfully.']);
    } else {
        http_response_code(500);
        echo json_encode(['success' => false, 'error' => 'Unable to send email at this time.']);
    }
} catch (Throwable $e) {
    error_log('Contact form email error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'Mail send failed.']);
}
