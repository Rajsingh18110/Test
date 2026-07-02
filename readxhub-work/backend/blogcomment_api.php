<?php
require('../cors-handler.php');
require('../Getdatabase.php');

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

header("Content-Type: application/json; charset=UTF-8");

$request_method = $_SERVER["REQUEST_METHOD"];
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Debugging: Log request method
file_put_contents("debug.log", "Request Method: $request_method\n", FILE_APPEND);

// Handle OPTIONS request for CORS
if ($request_method === "OPTIONS") {
    http_response_code(200);
    exit;
}

// Fetch comments + replies
if ($request_method === "GET") {
    if (!isset($_GET["blog_id"])) {
        http_response_code(400);
        echo json_encode(["error" => "Missing blog ID"]);
        exit;
    }

    $blog_id = intval($_GET["blog_id"]);
    
    file_put_contents("debug.log", "Fetching comments for blog_id: $blog_id\n", FILE_APPEND);
    
    // Join blog_creators so names/avatars auto-update when a creator changes their profile.
    // GROUP BY bc.id prevents any accidental duplicate rows from the JOIN.
    $stmt = $conn->prepare("
        SELECT bc.id, bc.blog_id, bc.user_email, bc.parent_id, bc.created_at,
               bc.text,
               COALESCE(c.name, bc.user_name) AS user_name,
               COALESCE(c.profile_picture, bc.profile_picture_url) AS profile_picture_url,
               c.username AS creator_username
        FROM blogcomment bc
        LEFT JOIN blog_creators c ON bc.user_email = c.email
        WHERE bc.blog_id = ?
        GROUP BY bc.id
        ORDER BY bc.created_at ASC
    ");
    if (!$stmt) {
        http_response_code(500);
        echo json_encode(["error" => "Prepare failed: " . $conn->error]);
        exit;
    }

    $stmt->bind_param("i", $blog_id);
    $stmt->execute();
    $result = $stmt->get_result();

    $allComments = [];
    while ($row = $result->fetch_assoc()) {
        $row['parent_id'] = $row['parent_id'] !== null ? (int)$row['parent_id'] : null;
        $row['id'] = (int)$row['id'];
        $allComments[] = $row;
    }

    echo json_encode($allComments);
    $stmt->close();
    $conn->close();
    exit;
}

// Insert new comment or reply
if ($request_method === "POST") {
    $data = json_decode(file_get_contents("php://input"), true);
    
    file_put_contents("debug.log", "Received POST data: " . json_encode($data) . "\n", FILE_APPEND);

    if (!isset($data["blog_id"], $data["text"], $data["user_email"], $data["user_name"], $data["profile_picture_url"])) {
        http_response_code(400);
        echo json_encode(["status" => "error", "error" => "Invalid data"]);
        exit;
    }

    $parent_id = isset($data["parent_id"]) ? intval($data["parent_id"]) : null;
    $blog_id   = intval($data["blog_id"]);
    $text      = trim($data["text"]);
    $user_email = trim($data["user_email"]);

    // ── Duplicate guard: same user + same text + same blog in last 60 seconds ──
    $dupStmt = $conn->prepare("
        SELECT id FROM blogcomment
        WHERE  blog_id    = ?
          AND  user_email = ?
          AND  text       = ?
          AND  created_at > DATE_SUB(NOW(), INTERVAL 60 SECOND)
        LIMIT 1
    ");
    if ($dupStmt) {
        $dupStmt->bind_param("iss", $blog_id, $user_email, $text);
        $dupStmt->execute();
        $dupRes = $dupStmt->get_result();
        if ($dupRes->num_rows > 0) {
            $existing = $dupRes->fetch_assoc();
            $dupStmt->close();
            echo json_encode([
                "status"    => "success",
                "message"   => "Comment already posted",
                "id"        => (int)$existing['id'],
                "duplicate" => true
            ]);
            $conn->close();
            exit;
        }
        $dupStmt->close();
    }

    $stmt = $conn->prepare("INSERT INTO blogcomment (blog_id, user_email, user_name, profile_picture_url, text, parent_id) VALUES (?, ?, ?, ?, ?, ?)");
    if (!$stmt) {
        http_response_code(500);
        echo json_encode(["status" => "error", "error" => "Prepare failed: " . $conn->error]);
        exit;
    }

    $stmt->bind_param("issssi", $blog_id, $data["user_email"], $data["user_name"], $data["profile_picture_url"], $text, $parent_id);
    
    if ($stmt->execute()) {
        $insert_id = $stmt->insert_id;

        // Fetch details to send email
        $commenter_name = $data["user_name"];
        $commenter_email = $data["user_email"];
        $comment_text = $text;

        if ($parent_id === null) {
            // New comment -> Notify post author
            $postStmt = $conn->prepare("SELECT title, email, author, slug FROM blog_posts WHERE id = ? LIMIT 1");
            if ($postStmt) {
                $postStmt->bind_param("i", $blog_id);
                $postStmt->execute();
                $postRes = $postStmt->get_result();
                if ($postRes && $postRes->num_rows === 1) {
                    $post = $postRes->fetch_assoc();
                    $postTitle = $post['title'];
                    $authorEmail = $post['email'];
                    $authorName = $post['author'];
                    $postSlug = $post['slug'];

                    // Only send if commenter is not the author
                    if (strtolower(trim($commenter_email)) !== strtolower(trim($authorEmail))) {
                        send_comment_email($authorEmail, $authorName, "New Comment on your article: $postTitle", 
                            "Hello $authorName,<br><br><strong>$commenter_name</strong> has commented on your article <strong>\"$postTitle\"</strong>:<br><br>\"$comment_text\"<br><br><a href=\"https://readxhub.in/blog/$postSlug\" style=\"display:inline-block;background-color:#22d3ee;color:#030712;padding:10px 20px;text-decoration:none;font-weight:bold;border-radius:8px;\">View Comment</a>"
                        );
                    }
                }
                $postStmt->close();
            }
        } else {
            // Reply -> Notify parent commenter AND post author
            $parentStmt = $conn->prepare("SELECT user_email, user_name FROM blogcomment WHERE id = ? LIMIT 1");
            if ($parentStmt) {
                $parentStmt->bind_param("i", $parent_id);
                $parentStmt->execute();
                $parentRes = $parentStmt->get_result();
                if ($parentRes && $parentRes->num_rows === 1) {
                    $parentComment = $parentRes->fetch_assoc();
                    $parentEmail = $parentComment['user_email'];
                    $parentName = $parentComment['user_name'];

                    // Query post details for context
                    $postStmt = $conn->prepare("SELECT title, slug, email, author FROM blog_posts WHERE id = ? LIMIT 1");
                    if ($postStmt) {
                        $postStmt->bind_param("i", $blog_id);
                        $postStmt->execute();
                        $postRes = $postStmt->get_result();
                        if ($postRes && $postRes->num_rows === 1) {
                            $post = $postRes->fetch_assoc();
                            $postTitle = $post['title'];
                            $postSlug = $post['slug'];
                            $authorEmail = $post['email'];
                            $authorName = $post['author'];

                            // Notify parent commenter if they are not the replier
                            if (strtolower(trim($commenter_email)) !== strtolower(trim($parentEmail))) {
                                send_comment_email($parentEmail, $parentName, "New Reply to your comment on ReadXHub", 
                                    "Hello $parentName,<br><br><strong>$commenter_name</strong> has replied to your comment on the article <strong>\"$postTitle\"</strong>:<br><br>\"$comment_text\"<br><br><a href=\"https://readxhub.in/blog/$postSlug\" style=\"display:inline-block;background-color:#22d3ee;color:#030712;padding:10px 20px;text-decoration:none;font-weight:bold;border-radius:8px;\">View Reply</a>"
                                );
                            }

                            // Notify post author if commenter is not the author AND parent commenter is not the author
                            if (strtolower(trim($commenter_email)) !== strtolower(trim($authorEmail)) && strtolower(trim($parentEmail)) !== strtolower(trim($authorEmail))) {
                                send_comment_email($authorEmail, $authorName, "New Reply on your article: $postTitle", 
                                    "Hello $authorName,<br><br><strong>$commenter_name</strong> has replied to a comment on your article <strong>\"$postTitle\"</strong>:<br><br>\"$comment_text\"<br><br><a href=\"https://readxhub.in/blog/$postSlug\" style=\"display:inline-block;background-color:#22d3ee;color:#030712;padding:10px 20px;text-decoration:none;font-weight:bold;border-radius:8px;\">View Reply</a>"
                                );
                            }
                        }
                        $postStmt->close();
                    }
                }
                $parentStmt->close();
            }
        }

        echo json_encode([
            "status"  => "success",
            "message" => "Comment posted",
            "id"      => $insert_id
        ]);
    } else {
        http_response_code(500);
        echo json_encode(["status" => "error", "error" => "Insert failed: " . $stmt->error]);
    }
    
    $stmt->close();
    $conn->close();
    exit;
}

// Update a comment
if ($request_method === "PUT") {
    $data = json_decode(file_get_contents("php://input"), true);
    
    file_put_contents("debug.log", "Received PUT data: " . json_encode($data) . "\n", FILE_APPEND);

    if (!isset($data["id"], $data["text"], $data["user_email"])) {
        http_response_code(400);
        echo json_encode(["status" => "error", "error" => "Invalid data"]);
        exit;
    }

    $stmt = $conn->prepare("UPDATE blogcomment SET text = ? WHERE id = ? AND user_email = ?");
    if (!$stmt) {
        http_response_code(500);
        echo json_encode(["status" => "error", "error" => "Prepare failed: " . $conn->error]);
        exit;
    }

    $stmt->bind_param("sis", $data["text"], $data["id"], $data["user_email"]);
    
    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Comment updated"]);
    } else {
        http_response_code(500);
        echo json_encode(["status" => "error", "error" => "Update failed: " . $stmt->error]);
    }
    
    $stmt->close();
    $conn->close();
    exit;
}

// Delete a comment (and its replies if top-level)
if ($request_method === "DELETE") {
    $data = json_decode(file_get_contents("php://input"), true);

    file_put_contents("debug.log", "Received DELETE data: " . json_encode($data) . "\n", FILE_APPEND);

    if (!isset($data["id"], $data["user_email"])) {
        http_response_code(400);
        echo json_encode(["status" => "error", "error" => "Invalid data"]);
        exit;
    }

    // Get the comment to check if it's a reply or top-level
    $stmt = $conn->prepare("SELECT parent_id FROM blogcomment WHERE id = ?");
    if (!$stmt) {
        http_response_code(500);
        echo json_encode(["status" => "error", "error" => "Prepare select failed: " . $conn->error]);
        exit;
    }
    $stmt->bind_param("i", $data["id"]);
    $stmt->execute();
    $result = $stmt->get_result();
    $comment = $result->fetch_assoc();
    $stmt->close();

    if (!$comment) {
        http_response_code(404);
        echo json_encode(["status" => "error", "error" => "Comment not found"]);
        $conn->close();
        exit;
    }

    if ($comment['parent_id'] === null) {
        // Top-level comment: delete all replies and the comment itself
        $deleteReplies = $conn->prepare("DELETE FROM blogcomment WHERE parent_id = ?");
        $deleteReplies->bind_param("i", $data["id"]);
        $deleteReplies->execute();
        $deleteReplies->close();

        $stmt = $conn->prepare("DELETE FROM blogcomment WHERE id = ? AND user_email = ?");
        $stmt->bind_param("is", $data["id"], $data["user_email"]);
        if ($stmt->execute()) {
            echo json_encode(["status" => "success", "message" => "Comment and its replies deleted"]);
        } else {
            http_response_code(500);
            echo json_encode(["status" => "error", "error" => "Delete failed: " . $stmt->error]);
        }
        $stmt->close();
    } else {
        // Reply: only delete if user is the owner
        $stmt = $conn->prepare("DELETE FROM blogcomment WHERE id = ? AND user_email = ?");
        $stmt->bind_param("is", $data["id"], $data["user_email"]);
        if ($stmt->execute()) {
            echo json_encode(["status" => "success", "message" => "Reply deleted"]);
        } else {
            http_response_code(500);
            echo json_encode(["status" => "error", "error" => "Delete failed: " . $stmt->error]);
        }
        $stmt->close();
    }
    
    $conn->close();
    exit;
}

function send_comment_email($to_email, $to_name, $subject, $body_html) {
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
        error_log("PHPMailer could not be loaded in blogcomment_api.php");
        return false;
    }

    $mail = new PHPMailer(true);
    try {
        $mail->isSMTP();
        $mail->Host       = 'smtp.hostinger.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = 'no-reply@readxhub.in';
        $mail->Password   = 'Adarsh@Lucky@10100';
        $mail->SMTPSecure = 'ssl';
        $mail->Port       = 465;

        $mail->setFrom('no-reply@readxhub.in', 'ReadXHub');
        $mail->addAddress($to_email, $to_name);

        $mail->isHTML(true);
        $mail->Subject = $subject;
        
        $mail->Body = "
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset='utf-8'>
            <style>
                body {
                    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
                    background-color: #030712;
                    color: #f3f4f6;
                    margin: 0;
                    padding: 0;
                }
                .email-container {
                    max-width: 600px;
                    margin: 0 auto;
                    padding: 40px 20px;
                }
                .header {
                    text-align: center;
                    margin-bottom: 30px;
                }
                .header h1 {
                    color: #ffffff;
                    font-size: 24px;
                    font-weight: 800;
                    margin: 0;
                    letter-spacing: -0.025em;
                }
                .header span {
                    color: #22d3ee;
                }
                .content-card {
                    background-color: #111827;
                    border: 1px solid #1f2937;
                    border-radius: 16px;
                    padding: 30px;
                    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.3);
                    color: #cbd5e1;
                    font-size: 14px;
                    line-height: 1.6;
                }
                .footer {
                    text-align: center;
                    margin-top: 30px;
                    font-size: 11px;
                    color: #4b5563;
                    line-height: 1.5;
                }
            </style>
        </head>
        <body>
            <div class='email-container'>
                <div class='header'>
                    <h1>ReadXHub</h1>
                </div>
                <div class='content-card'>
                    $body_html
                </div>
                <div class='footer'>
                    ReadXHub &copy; " . date('Y') . " | Technology, Development, AI & Cybersecurity.
                </div>
            </div>
        </body>
        </html>
        ";

        $mail->send();
        return true;
    } catch (Exception $e) {
        error_log("Failed to send comment notification email: " . $mail->ErrorInfo);
        return false;
    }
}

http_response_code(405);
echo json_encode(["status" => "error", "error" => "Method not allowed"]);
?>
