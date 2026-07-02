<?php
require('../cors-handler.php');
require('../Getdatabase.php');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

header('Content-Type: application/json');

function respond($status, $code, $message, $extra = []) {
    echo json_encode(array_merge([
        "status"  => $status,
        "code"    => $code,
        "message" => $message
    ], $extra));
    exit();
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respond('error', 'INVALID_METHOD', 'Only POST is allowed.');
}

// 1. Core Fields
$title       = trim($_POST['title']       ?? '');
$description = trim($_POST['description'] ?? '');
$content     = trim($_POST['content']     ?? '');
$author      = trim($_POST['author']      ?? '');
$email       = trim($_POST['email']       ?? '');

// 2. Status & Dates
date_default_timezone_set('Asia/Kolkata'); // Indian Timing
$status       = trim($_POST['status'] ?? 'draft');
$publish_date = trim($_POST['publish_date'] ?? date('Y-m-d H:i:s'));

// Helper to sanitize optional fields to proper NULLs
function sanitize_input($val) {
    if ($val === null) return null;
    $trimmed = trim($val);
    if ($trimmed === '' || $trimmed === 'null' || $trimmed === 'undefined') {
        return null;
    }
    return $trimmed;
}

// 3. Featured Image Fields
$featured_image        = sanitize_input($_POST['featured_image'] ?? null);
$featured_image_thumb  = sanitize_input($_POST['featured_image_thumb'] ?? null);
$featured_image_medium = sanitize_input($_POST['featured_image_medium'] ?? null);
$featured_image_large  = sanitize_input($_POST['featured_image_large'] ?? null);
$image_alt             = sanitize_input($_POST['image_alt'] ?? null);
$image_caption         = sanitize_input($_POST['image_caption'] ?? null);
$image_credit          = sanitize_input($_POST['image_credit'] ?? null);
$mime_type             = sanitize_input($_POST['mime_type'] ?? null);

// 4. SEO & Social Fields
$seo_title          = sanitize_input($_POST['seo_title'] ?? null);
$seo_description    = sanitize_input($_POST['seo_description'] ?? null);
$focus_keyword      = sanitize_input($_POST['focus_keyword'] ?? null);
$social_title       = sanitize_input($_POST['social_title'] ?? null);
$social_description = sanitize_input($_POST['social_description'] ?? null);
$social_image       = sanitize_input($_POST['social_image'] ?? null);
$canonical_url      = sanitize_input($_POST['canonical_url'] ?? null);
$robots_override    = sanitize_input($_POST['robots_override'] ?? null);
$keywords           = trim($_POST['keywords'] ?? '');

// Validation
if ($title === '' || $description === '' || $content === '' || $email === '' || $author === '') {
    respond("error", "VALIDATION_ERROR", "Title, description, content, author and email are required.");
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    respond("error", "INVALID_EMAIL", "Provided email address is invalid.");
}

// Analytics Generation
function calculate_reading_time_and_words($content, &$word_count) {
    if (empty($content)) {
        $word_count = 0;
        return 1;
    }
    
    // Strip HTML tags
    $clean_content = strip_tags($content);
    
    // Count markdown images like ![alt](url)
    $image_count = preg_match_all('/!\[.*?\]\(.*?\)/', $content, $matches);
    // Remove images from content before counting words
    $clean_content = preg_replace('/!\[.*?\]\(.*?\)/', '', $clean_content);
    
    // Count YouTube embeds like [youtube:ID]
    $video_count = preg_match_all('/\[youtube:[^\]]+\]/', $content, $matches);
    // Remove video embeds from content before counting words
    $clean_content = preg_replace('/\[youtube:[^\]]+\]/', '', $clean_content);
    
    // Split by any sequence of whitespace characters (handles UTF-8 and punctuation correctly)
    $words = preg_split('/\s+/', trim($clean_content));
    $word_count = empty($words[0]) ? 0 : count($words);
    
    // Reading speed: 180 words per minute
    $wpm = 180;
    $time = $word_count / $wpm;
    
    // Add time for images (Medium algorithm: 12s for 1st, 11s for 2nd, etc. down to 3s)
    $image_time = 0;
    if ($image_count > 0) {
        $first_image_time = 12;
        for ($i = 0; $i < $image_count; $i++) {
            $image_time += max(3, $first_image_time - $i) / 60; // in minutes
        }
    }
    
    // Add time for videos (60s per video embed)
    $video_time = $video_count * 1.0; // 1 minute per video
    
    $total_time = ceil($time + $image_time + $video_time);
    return max(1, (int)$total_time);
}

$word_count = 0;
$reading_time = calculate_reading_time_and_words($content, $word_count);

// Duplicate check
$checkSql = "SELECT id FROM blog_posts WHERE title = ? LIMIT 1";
$checkStmt = $conn->prepare($checkSql);
$checkStmt->bind_param("s", $title);
$checkStmt->execute();
$checkStmt->store_result();
if ($checkStmt->num_rows > 0) {
    respond("error", "DUPLICATE_POST", "A blog post with this title already exists.");
}
$checkStmt->close();

// Slug Generation
$slug = strtolower(trim(preg_replace('/[^a-zA-Z0-9]+/', '-', $title), '-')) . '-' . time();
$url  = "/blog/" . $slug; // Relative URL to support dual domains

if (empty($canonical_url)) {
    $canonical_url = "https://readxhub.in" . $url;
}

// Transactions ensure we don't end up with partial data
$conn->begin_transaction();

try {
    $sql = "INSERT INTO blog_posts (
        title, description, keywords, content, author, email, slug, url,
        status, publish_date, 
        featured_image, featured_image_thumb, featured_image_medium, featured_image_large,
        image_alt, image_caption, image_credit, mime_type,
        seo_title, seo_description, focus_keyword,
        social_title, social_description, social_image,
        canonical_url, robots_override, reading_time, word_count
    ) VALUES (
        ?, ?, ?, ?, ?, ?, ?, ?,
        ?, ?,
        ?, ?, ?, ?,
        ?, ?, ?, ?,
        ?, ?, ?,
        ?, ?, ?,
        ?, ?, ?, ?
    )";

    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        throw new Exception("Prepare failed: " . $conn->error);
    }

    $stmt->bind_param(
        "ssssssssssssssssssssssssssii",
        $title, $description, $keywords, $content, $author, $email, $slug, $url,
        $status, $publish_date,
        $featured_image, $featured_image_thumb, $featured_image_medium, $featured_image_large,
        $image_alt, $image_caption, $image_credit, $mime_type,
        $seo_title, $seo_description, $focus_keyword,
        $social_title, $social_description, $social_image,
        $canonical_url, $robots_override, $reading_time, $word_count
    );

    if (!$stmt->execute()) {
        throw new Exception("Execute failed: " . $stmt->error);
    }
    
    $blog_id = $stmt->insert_id;
    $stmt->close();
    
    $conn->commit();
    
    respond("success", "POST_CREATED", "Blog post inserted successfully.", [
        "id" => $blog_id,
        "url"  => $url,
        "slug" => $slug,
        "status" => $status
    ]);

} catch (Exception $e) {
    $conn->rollback();
    respond("error", "DB_INSERT_FAILED", "Failed to insert blog post: " . $e->getMessage());
}
?>
