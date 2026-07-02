<?php
/**
 * debug_subs.php — temporary diagnostic for get_subscriptions 500 error
 * Upload to blogs.readxhub.in root, visit:
 *   https://readxhub.in/blogs/debug_subs.php
 * DELETE this file after you're done debugging!
 */
header("Content-Type: application/json; charset=UTF-8");
error_reporting(E_ALL);
ini_set('display_errors', 0); // we capture manually

$report = [];

// ── Step 1: Load cors-handler ────────────────────────────────────────────────
try {
    require('../cors-handler.php');
    $report['step1_cors_handler'] = 'OK';
} catch (Throwable $e) {
    $report['step1_cors_handler'] = 'FAILED: ' . $e->getMessage();
}

// ── Step 2: Load Getdatabase.php ─────────────────────────────────────────────
try {
    require('../Getdatabase.php');
    $report['step2_getdatabase'] = isset($conn) ? 'OK – $conn is set' : 'WARNING – $conn not set after require';
} catch (Throwable $e) {
    $report['step2_getdatabase'] = 'FAILED: ' . $e->getMessage();
}

// ── Step 3: Verify DB connection ─────────────────────────────────────────────
if (!isset($conn) || !$conn) {
    $report['step3_db_connection'] = 'FAILED – $conn is null or false';
    echo json_encode($report, JSON_PRETTY_PRINT);
    exit();
}
$report['step3_db_connection'] = 'OK – connected';

// ── Step 4: Load db_init.php ──────────────────────────────────────────────────
try {
    require('db_init.php');
    $report['step4_db_init_load'] = 'OK (function defined)';
} catch (Throwable $e) {
    $report['step4_db_init_load'] = 'FAILED: ' . $e->getMessage();
}

// ── Step 5: Run initialize_database() ────────────────────────────────────────
try {
    initialize_database($conn);
    $report['step5_initialize_database'] = 'OK';
} catch (Throwable $e) {
    $report['step5_initialize_database'] = 'FAILED: ' . $e->getMessage();
}

// ── Step 6: Show all tables ───────────────────────────────────────────────────
$tables = [];
$res = $conn->query("SHOW TABLES");
if ($res) {
    while ($row = $res->fetch_array()) { $tables[] = $row[0]; }
}
$report['step6_tables'] = $tables;

// ── Step 7: creator_subscriptions columns ────────────────────────────────────
if (in_array('creator_subscriptions', $tables)) {
    $cols = [];
    $res = $conn->query("SHOW COLUMNS FROM creator_subscriptions");
    if ($res) {
        while ($row = $res->fetch_assoc()) {
            $cols[] = $row['Field'] . ' (' . $row['Type'] . ')';
        }
    }
    $report['step7_creator_subscriptions_columns'] = $cols;
} else {
    $report['step7_creator_subscriptions_columns'] = 'TABLE DOES NOT EXIST';
}

// ── Step 8: Test the exact creators query from get_subscriptions.php ─────────
$creatorsSql = "
    SELECT c.name, c.bio, c.profile_picture, c.username, c.email, c.gender
    FROM creator_subscriptions s
    JOIN blog_creators c ON s.creator_email = c.email
    WHERE s.subscriber_email = ?
    ORDER BY s.id DESC
";
$stmt = $conn->prepare($creatorsSql);
if ($stmt) {
    $report['step8_creators_query_prepare'] = 'OK';
    $testEmail = 'test@test.com';
    $stmt->bind_param("s", $testEmail);
    if ($stmt->execute()) {
        $report['step8_creators_query_execute'] = 'OK';
    } else {
        $report['step8_creators_query_execute'] = 'FAILED: ' . $stmt->error;
    }
    $stmt->close();
} else {
    $report['step8_creators_query_prepare'] = 'FAILED: ' . $conn->error;
}

// ── Step 9: Test the posts query ─────────────────────────────────────────────
$postsSql = "
    SELECT p.id, p.title, p.slug, p.created_at, p.email,
           c.username, c.profile_picture, c.gender
    FROM creator_subscriptions s
    JOIN blog_posts p ON s.creator_email = p.email
    LEFT JOIN blog_creators c ON p.email = c.email
    WHERE s.subscriber_email = ?
    ORDER BY p.created_at DESC
    LIMIT 5
";
$stmt = $conn->prepare($postsSql);
if ($stmt) {
    $report['step9_posts_query_prepare'] = 'OK';
    $testEmail = 'test@test.com';
    $stmt->bind_param("s", $testEmail);
    if ($stmt->execute()) {
        $report['step9_posts_query_execute'] = 'OK';
    } else {
        $report['step9_posts_query_execute'] = 'FAILED: ' . $stmt->error;
    }
    $stmt->close();
} else {
    $report['step9_posts_query_prepare'] = 'FAILED: ' . $conn->error;
}

// ── Step 10: PHP version info ─────────────────────────────────────────────────
$report['php_version'] = PHP_VERSION;
$report['mysqli_version'] = mysqli_get_client_info();

$conn->close();
echo json_encode($report, JSON_PRETTY_PRINT);
?>
