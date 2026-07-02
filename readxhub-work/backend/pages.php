<?php
// pages.php  (…/blogs/pages.php)
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require('../cors-handler.php');
require('../Getdatabase.php');

header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

/* ------------------------------------------------------------
 * 1.  Validate e‑mail coming from the query string
 * ---------------------------------------------------------- */
if (!isset($_GET['email']) || !filter_var($_GET['email'], FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing or invalid e‑mail.']);
    exit();
}
$email = $_GET['email'];

/* ------------------------------------------------------------
 * 2.  Prepared statement to fetch only the author’s posts
 * ---------------------------------------------------------- */
$sql  = "SELECT *
         FROM   blog_posts
         WHERE  email = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

$posts = [];
while ($row = $result->fetch_assoc()) {
    $posts[] = $row;
}

echo json_encode($posts);

$stmt->close();
$conn->close();
?>
