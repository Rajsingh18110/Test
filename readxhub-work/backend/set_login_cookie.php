<?php
require('../cors-handler.php');

header('Content-Type: application/json; charset=UTF-8');

$method = $_SERVER['REQUEST_METHOD'];
if ($method === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Accept POST with JSON body or form-encoded
$data = json_decode(file_get_contents('php://input'), true);
if (!$data) {
    $data = $_POST;
}

$email = trim($data['email'] ?? '');
if (empty($email) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['error' => 'Valid email is required']);
    exit();
}

// Set auth cookie for 365 days; allow cross-site requests with credentials
$expiry = time() + (365 * 24 * 60 * 60);
setcookie('auth_token', $email, $expiry, '/', '.readxhub.in', true, true);

header('Set-Cookie: auth_token=' . rawurlencode($email) . '; Path=/; Domain=.readxhub.in; Max-Age=' . (365 * 24 * 60 * 60) . '; Secure; SameSite=None');

echo json_encode(['success' => true, 'message' => 'Login cookie set']);
exit();

?>
