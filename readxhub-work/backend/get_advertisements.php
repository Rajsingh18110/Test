<?php
require('../cors-handler.php');
require('../Getdatabase.php');

header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$sql = "SELECT slot_name, image_url, link_url, alt_text FROM blog_advertisements";
$result = $conn->query($sql);

$ads = [];
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $ads[$row['slot_name']][] = [
            'image_url' => $row['image_url'],
            'link_url'  => $row['link_url'],
            'alt_text'  => $row['alt_text']
        ];
    }
}

$conn->close();
echo json_encode(['success' => true, 'data' => $ads]);
?>
