<?php
require('../cors-handler.php');
require('../Getdatabase.php');

header("Content-Type: application/json; charset=UTF-8");

if (!isset($_GET['slug'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Slug parameter is required']);
    exit();
}

$slug = trim($_GET['slug']);
$user_email = isset($_COOKIE['auth_token']) ? trim($_COOKIE['auth_token']) : null;

// IP & UA
$ip_address = $_SERVER['HTTP_X_FORWARDED_FOR'] ?? $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0';
$user_agent = $_SERVER['HTTP_USER_AGENT'] ?? 'Unknown';

// Generate viewer_id
if (!empty($user_email)) {
    $viewer_id = 'user:' . $user_email;
} else {
    $salt = "readxhub_analytics_salt";
    $viewer_id = 'guest:' . hash('sha256', $ip_address . $user_agent . $salt);
}

// Extract device info roughly
$browser = 'Unknown';
if (strpos($user_agent, 'Chrome') !== false) $browser = 'Chrome';
elseif (strpos($user_agent, 'Firefox') !== false) $browser = 'Firefox';
elseif (strpos($user_agent, 'Safari') !== false) $browser = 'Safari';
elseif (strpos($user_agent, 'Edge') !== false) $browser = 'Edge';

$os = 'Unknown';
if (strpos($user_agent, 'Windows') !== false) $os = 'Windows';
elseif (strpos($user_agent, 'Mac') !== false) $os = 'MacOS';
elseif (strpos($user_agent, 'Linux') !== false) $os = 'Linux';
elseif (strpos($user_agent, 'Android') !== false) $os = 'Android';
elseif (strpos($user_agent, 'iOS') !== false || strpos($user_agent, 'iPhone') !== false) $os = 'iOS';

$device_type = 'Desktop';
if (preg_match('/Mobile|Android|iPhone|iPod|BlackBerry|IEMobile|Opera Mini/i', $user_agent)) {
    $device_type = 'Mobile';
} elseif (preg_match('/Tablet|iPad/i', $user_agent)) {
    $device_type = 'Tablet';
}

$referrer = $_SERVER['HTTP_REFERER'] ?? null;

// Determine Timezone from IP
$viewer_timezone = 'Unknown';
if (filter_var($ip_address, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE)) {
    $ch = curl_init("http://ip-api.com/json/{$ip_address}?fields=timezone");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 2);
    $response = curl_exec($ch);
    if (!curl_errno($ch)) {
        $data = @json_decode($response);
        if ($data && isset($data->timezone)) {
            $viewer_timezone = $data->timezone;
        }
    }
    curl_close($ch);
}

// 1. Resolve blog_id from slug
$stmt = $conn->prepare("SELECT id FROM blog_posts WHERE slug = ? LIMIT 1");
if (!$stmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to prepare statement']);
    exit();
}
$stmt->bind_param("s", $slug);
$stmt->execute();
$res = $stmt->get_result();
if ($res->num_rows === 0) {
    http_response_code(404);
    echo json_encode(['error' => 'Blog not found']);
    $stmt->close();
    exit();
}
$blog = $res->fetch_assoc();
$blog_id = intval($blog['id']);
$stmt->close();

$conn->begin_transaction();
try {
    // Check cooldown
    $stmt = $conn->prepare("SELECT last_seen_at FROM blog_analytics WHERE blog_id = ? AND viewer_id = ? LIMIT 1");
    if (!$stmt) {
        // Fallback for pre-migration state: Just increment view if analytics table doesn't exist
        $conn->query("UPDATE blog_posts SET views = views + 1 WHERE id = $blog_id");
        $conn->commit();
        echo json_encode(['success' => true, 'message' => 'Legacy tracking fallback']);
        exit();
    }

    $stmt->bind_param("is", $blog_id, $viewer_id);
    $stmt->execute();
    $res = $stmt->get_result();
    
    $should_increment_view = false;

    if ($res->num_rows === 0) {
        // First time seeing this viewer for this blog
        $should_increment_view = true;
        
        $insertStmt = $conn->prepare("
            INSERT INTO blog_analytics 
            (blog_id, viewer_id, user_email, ip_address, user_agent, browser, operating_system, device_type, referrer, viewer_timezone) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ");
        $insertStmt->bind_param("isssssssss", $blog_id, $viewer_id, $user_email, $ip_address, $user_agent, $browser, $os, $device_type, $referrer, $viewer_timezone);
        $insertStmt->execute();
        $insertStmt->close();
    } else {
        $row = $res->fetch_assoc();
        $last_seen = strtotime($row['last_seen_at']);
        $now = time();
        
        // 24 Hour Cooldown check
        if (($now - $last_seen) > 86400) {
            $should_increment_view = true;
        }
        
        // Update last_seen_at regardless
        $updateStmt = $conn->prepare("UPDATE blog_analytics SET last_seen_at = CURRENT_TIMESTAMP WHERE blog_id = ? AND viewer_id = ?");
        $updateStmt->bind_param("is", $blog_id, $viewer_id);
        $updateStmt->execute();
        $updateStmt->close();
    }
    $stmt->close();

    if ($should_increment_view) {
        // Atomic increment
        $conn->query("UPDATE blog_posts SET views = views + 1 WHERE id = $blog_id");
        $conn->commit();
        echo json_encode(['success' => true, 'message' => 'New view tracked successfully', 'viewer_id' => $viewer_id]);
    } else {
        $conn->commit();
        echo json_encode(['success' => true, 'message' => 'View ignored due to 24-hour cooldown', 'viewer_id' => $viewer_id]);
    }

} catch (Exception $e) {
    $conn->rollback();
    http_response_code(500);
    echo json_encode(['error' => 'Analytics transaction failed: ' . $e->getMessage()]);
}

$conn->close();
?>
