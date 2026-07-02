<?php
// Legacy proxy endpoint. Please use /assistant_chat.php instead.
header('Content-Type: application/json; charset=UTF-8');
http_response_code(404);
echo json_encode(["success" => false, "error" => "The requested endpoint is no longer available."]);
