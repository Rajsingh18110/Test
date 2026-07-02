<?php
require('../cors-handler.php');
require('../Getdatabase.php');

header("Content-Type: application/json; charset=UTF-8");

if (!isset($_GET['email'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Email parameter is required']);
    exit();
}

$email = trim($_GET['email']);

$sql = "SELECT name FROM blog_creators WHERE email = ? LIMIT 1";
$stmt = $conn->prepare($sql);
if (!$stmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to prepare statement']);
    exit();
}

$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result && $result->num_rows === 1) {
    $row = $result->fetch_assoc();
    echo json_encode(['name' => $row['name']]);
} else {
    echo json_encode(['name' => null]);
}

$stmt->close();
$conn->close();
?>
