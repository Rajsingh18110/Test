<?php
// This file should ideally be called by a server cron job (e.g. every 5 minutes)
// Usage: php /path/to/backend/cron_publish_scheduled.php
// Or via HTTP: GET https://domain/backend/cron_publish_scheduled.php?secret=YOUR_SECRET_TOKEN

require_once(__DIR__ . '/../Getdatabase.php');

// Optional: Add a secret token check if accessed via HTTP to prevent abuse
$secret_token = "readxhub_secure_cron_trigger";
if (isset($_SERVER['HTTP_HOST'])) {
    if (!isset($_GET['secret']) || $_GET['secret'] !== $secret_token) {
        http_response_code(403);
        exit("Forbidden");
    }
}

try {
    $conn->begin_transaction();

    // Find all scheduled posts where publish_date has passed
    $sql = "UPDATE blog_posts 
            SET status = 'published' 
            WHERE status = 'scheduled' AND publish_date <= NOW()";
            
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        throw new Exception("Prepare failed: " . $conn->error);
    }

    if (!$stmt->execute()) {
        throw new Exception("Execute failed: " . $stmt->error);
    }
    
    $affected = $stmt->affected_rows;
    $stmt->close();
    $conn->commit();
    
    if (isset($_SERVER['HTTP_HOST'])) {
        echo json_encode(["status" => "success", "published_count" => $affected]);
    } else {
        echo "[CRON] Successfully published $affected scheduled posts.\n";
    }

} catch (Exception $e) {
    $conn->rollback();
    if (isset($_SERVER['HTTP_HOST'])) {
        http_response_code(500);
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    } else {
        echo "[CRON ERROR] " . $e->getMessage() . "\n";
    }
}
?>
