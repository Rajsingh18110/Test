<?php

require('../cors-handler.php');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require('../Getdatabase.php');

// Sanitize and fetch data from POST
$title = $conn->real_escape_string($_POST['title']);
$description = $conn->real_escape_string($_POST['description']);
$keywords = $conn->real_escape_string($_POST['keywords']);
$author = $conn->real_escape_string($_POST['author']);
$content = $conn->real_escape_string($_POST['content']);
$email = $conn->real_escape_string($_POST['email']); // NEW: Accept email

// Check for duplicate post by title and content
$check_sql = "SELECT id FROM blog_posts WHERE title = '$title' AND content = '$content' LIMIT 1";
$check_result = $conn->query($check_sql);

if ($check_result->num_rows > 0) {
    echo "Duplicate blog post: This title and content already exist.";
    $conn->close();
    exit();
}

// Create unique slug from title
function createSlug($title) {
    $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $title), '-'));
    return $slug . '-' . time(); // Ensure uniqueness
}

$slug = createSlug($title);
$url = "https://readxhub.in/blogs/post.php?slug=" . $slug;

// Insert post into database with email
$sql = "INSERT INTO blog_posts (title, description, keywords, author, content, slug, url, email)
        VALUES ('$title', '$description', '$keywords', '$author', '$content', '$slug', '$url', '$email')";

if ($conn->query($sql) === TRUE) {
    echo json_encode([
        "status" => "success",
        "message" => "Blog post inserted successfully!",
        "url" => $url
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "Error: " . $conn->error
    ]);
}

$conn->close();
?>
