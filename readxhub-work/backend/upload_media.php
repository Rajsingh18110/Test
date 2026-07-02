<?php
require('../cors-handler.php');
require('../Getdatabase.php');
require('image_optimizer.php');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

header('Content-Type: application/json');

function respond($status, $code, $message, $data = []) {
    echo json_encode(array_merge([
        "status"  => $status,
        "code"    => $code,
        "message" => $message
    ], $data));
    exit();
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respond('error', 'INVALID_METHOD', 'Only POST is allowed.');
}

$email = trim($_POST['email'] ?? '');
if (empty($email)) {
    respond('error', 'MISSING_AUTH', 'Uploader email is required.');
}

if (!isset($_FILES['file'])) {
    respond('error', 'NO_FILE', 'No file was uploaded.');
}

try {
    $optimizer = new ImageOptimizer();
    $paths = $optimizer->processUpload($_FILES['file']);
    
    $fileSize = $_FILES['file']['size'];
    $mime = $paths['mime'];
    $hash = $paths['hash'];
    $originalName = $paths['original_name'];
    
    // Get width/height
    $width = null;
    $height = null;
    if ($mime !== 'image/svg+xml') {
        $checkPath = __DIR__ . '/' . basename($paths['original']); // fallback
        if (file_exists(__DIR__ . '/../' . $paths['original'])) {
            $checkPath = __DIR__ . '/../' . $paths['original'];
        } elseif (file_exists(__DIR__ . '/' . $paths['original'])) {
            $checkPath = __DIR__ . '/' . $paths['original'];
        } elseif (file_exists(__DIR__ . '/uploads/media/' . basename($paths['original']))) {
            $checkPath = __DIR__ . '/uploads/media/' . basename($paths['original']);
        }
        
        $info = @getimagesize($checkPath);
        if ($info) {
            $width = $info[0];
            $height = $info[1];
        }
    }

    // Insert into media_uploads
    $stmt = $conn->prepare("INSERT INTO media_uploads (file_name, original_name, mime_type, file_size, width, height, hash, uploader_email) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    if ($stmt) {
        $primaryPath = $paths['large'] ?? $paths['original'];
        $stmt->bind_param("sssiisss", $primaryPath, $originalName, $mime, $fileSize, $width, $height, $hash, $email);
        $stmt->execute();
        $mediaId = $stmt->insert_id;
        $stmt->close();
        
        $paths['media_id'] = $mediaId;
        $paths['width'] = $width;
        $paths['height'] = $height;
    }

    respond('success', 'UPLOAD_SUCCESS', 'Image optimized and stored.', ['data' => $paths]);

} catch (Exception $e) {
    respond('error', 'UPLOAD_FAILED', $e->getMessage());
}
?>
