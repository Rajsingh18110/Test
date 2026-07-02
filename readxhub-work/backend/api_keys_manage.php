<?php
// Load CORS helper which sets Access-Control-Allow-Origin and credentials correctly
require(__DIR__ . '/../cors-handler.php');

/** @psalm-suppress PossiblyNullArgument */
header('Content-Type: application/json');

// Set error handler to return JSON for all errors
set_error_handler(function($errno, $errstr, $errfile, $errline) {
    error_log("API Keys Error [$errno]: $errstr in $errfile:$errline");
    http_response_code(500);
    echo json_encode(['error' => 'Server error']);
    exit();
});

// Set exception handler
set_exception_handler(function($exception) {
    error_log("API Keys Exception: " . $exception->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Server error']);
    exit();
});

// `cors-handler.php` already terminates OPTIONS requests when appropriate

require_once '../Getdatabase.php';
require_once 'db_init.php';
$conn = $GLOBALS['conn'];

initialize_database($conn);

if (!$conn) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection failed']);
    exit();
}

if (!isset($_SERVER['HTTP_AUTHORIZATION']) && !isset($_COOKIE['auth_token'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit();
}

function generateApiKey() {
    return bin2hex(random_bytes(32));
}

function safePrepare($conn, $sql) {
    /** @var \mysqli $conn */
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        http_response_code(500);
        echo json_encode(['error' => 'Database error']);
        exit();
    }
    return $stmt;
}

try {
    $action = $_GET['action'] ?? '';
    
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        // List all API keys for a creator
        if ($action === 'list') {
            $email = $_GET['email'] ?? '';
            if (empty($email)) {
                http_response_code(400);
                echo json_encode(['error' => 'Email is required']);
                exit();
            }

            $stmt = $conn->prepare("
                SELECT id, api_key, description, is_active, requests_count, last_used_at, created_at, updated_at
                FROM api_keys
                WHERE creator_email = ?
                ORDER BY created_at DESC
            ");
            if (!$stmt) {
                http_response_code(500);
                echo json_encode(['error' => 'Database error']);
                exit();
            }
            $stmt->bind_param("s", $email);
            $stmt->execute();
            $result = $stmt->get_result();
            $apiKeys = [];
            
            while ($row = $result->fetch_assoc()) {
                $row['api_key'] = substr($row['api_key'], 0, 8) . '...' . substr($row['api_key'], -8);
                $apiKeys[] = $row;
            }
            
            http_response_code(200);
            echo json_encode(['success' => true, 'keys' => $apiKeys]);
            exit();
        }
        
        // Get single API key details
        if ($action === 'get') {
            $keyId = $_GET['key_id'] ?? '';
            if (empty($keyId)) {
                http_response_code(400);
                echo json_encode(['error' => 'Key ID is required']);
                exit();
            }

            $stmt = $conn->prepare("
                SELECT id, api_key, description, is_active, requests_count, last_used_at, created_at
                FROM api_keys
                WHERE id = ?
            ");
            if (!$stmt) {
                http_response_code(500);
                echo json_encode(['error' => 'Database error']);
                exit();
            }
            $stmt->bind_param("i", $keyId);
            $stmt->execute();
            $result = $stmt->get_result();
            
            if ($result->num_rows === 0) {
                http_response_code(404);
                echo json_encode(['error' => 'API key not found']);
                exit();
            }
            
            $key = $result->fetch_assoc();
            $key['api_key'] = substr($key['api_key'], 0, 8) . '...' . substr($key['api_key'], -8);
            
            http_response_code(200);
            echo json_encode(['success' => true, 'key' => $key]);
            exit();
        }
    }
    
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $data = json_decode(file_get_contents("php://input"), true);
        
        // Create new API key
        if ($action === 'create') {
            $email = $data['email'] ?? '';
            $description = $data['description'] ?? '';
            
            if (empty($email)) {
                http_response_code(400);
                echo json_encode(['error' => 'Email is required']);
                exit();
            }

            // Verify creator exists
            $checkStmt = $conn->prepare("SELECT name FROM blog_creators WHERE email = ?");
            if (!$checkStmt) {
                http_response_code(500);
                echo json_encode(['error' => 'Database error']);
                exit();
            }
            $checkStmt->bind_param("s", $email);
            $checkStmt->execute();
            $checkResult = $checkStmt->get_result();
            
            if ($checkResult->num_rows === 0) {
                http_response_code(404);
                echo json_encode(['error' => 'Creator not found']);
                exit();
            }
            
            $creatorData = $checkResult->fetch_assoc();
            $creatorName = $creatorData['name'];
            
            // Check limit: max 5 keys per creator
            $limitStmt = $conn->prepare("SELECT COUNT(*) as count FROM api_keys WHERE creator_email = ?");
            if (!$limitStmt) {
                http_response_code(500);
                echo json_encode(['error' => 'Database error']);
                exit();
            }
            $limitStmt->bind_param("s", $email);
            $limitStmt->execute();
            $limitResult = $limitStmt->get_result();
            $limitData = $limitResult->fetch_assoc();
            
            if ($limitData['count'] >= 5) {
                http_response_code(429);
                echo json_encode(['error' => 'Maximum of 5 API keys allowed per account']);
                exit();
            }
            
            $apiKey = generateApiKey();
            $stmt = $conn->prepare("
                INSERT INTO api_keys (api_key, creator_email, creator_name, description, is_active)
                VALUES (?, ?, ?, ?, 1)
            ");
            if (!$stmt) {
                http_response_code(500);
                echo json_encode(['error' => 'Database error']);
                exit();
            }
            $stmt->bind_param("ssss", $apiKey, $email, $creatorName, $description);
            $stmt->execute();
            
            http_response_code(201);
            echo json_encode([
                'success' => true,
                'message' => 'API key created successfully',
                'api_key' => $apiKey,
                'note' => 'Save this key somewhere safe. You won\'t be able to see it again!'
            ]);
            exit();
        }
        
        // Update API key
        if ($action === 'update') {
            $keyId = $data['key_id'] ?? '';
            $description = $data['description'] ?? '';
            
            if (empty($keyId)) {
                http_response_code(400);
                echo json_encode(['error' => 'Key ID is required']);
                exit();
            }
            
            $stmt = $conn->prepare("
                UPDATE api_keys
                SET description = ?, updated_at = CURRENT_TIMESTAMP
                WHERE id = ?
            ");
            if (!$stmt) {
                http_response_code(500);
                echo json_encode(['error' => 'Database error']);
                exit();
            }
            $stmt->bind_param("si", $description, $keyId);
            $stmt->execute();
            
            http_response_code(200);
            echo json_encode(['success' => true, 'message' => 'API key updated']);
            exit();
        }
        
        // Regenerate API key
        if ($action === 'regenerate') {
            $keyId = $data['key_id'] ?? '';
            
            if (empty($keyId)) {
                http_response_code(400);
                echo json_encode(['error' => 'Key ID is required']);
                exit();
            }
            
            $newKey = generateApiKey();
            $stmt = $conn->prepare("
                UPDATE api_keys
                SET api_key = ?, requests_count = 0, updated_at = CURRENT_TIMESTAMP
                WHERE id = ?
            ");
            if (!$stmt) {
                http_response_code(500);
                echo json_encode(['error' => 'Database error']);
                exit();
            }
            $stmt->bind_param("si", $newKey, $keyId);
            $stmt->execute();
            
            http_response_code(200);
            echo json_encode([
                'success' => true,
                'message' => 'API key regenerated',
                'api_key' => $newKey,
                'note' => 'Your old key is now invalid. Save this new key!'
            ]);
            exit();
        }
        
        // Toggle API key status
        if ($action === 'toggle') {
            $keyId = $data['key_id'] ?? '';
            $isActive = $data['is_active'] ?? 0;
            
            if (empty($keyId)) {
                http_response_code(400);
                echo json_encode(['error' => 'Key ID is required']);
                exit();
            }
            
            $stmt = $conn->prepare("
                UPDATE api_keys
                SET is_active = ?, updated_at = CURRENT_TIMESTAMP
                WHERE id = ?
            ");
            if (!$stmt) {
                http_response_code(500);
                echo json_encode(['error' => 'Database error']);
                exit();
            }
            $stmt->bind_param("ii", $isActive, $keyId);
            $stmt->execute();
            
            $status = $isActive ? 'activated' : 'deactivated';
            http_response_code(200);
            echo json_encode(['success' => true, 'message' => "API key $status"]);
            exit();
        }
    }
    
    if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
        $data = json_decode(file_get_contents("php://input"), true);
        
        // Delete API key
        if ($action === 'delete') {
            $keyId = $data['key_id'] ?? '';
            
            if (empty($keyId)) {
                http_response_code(400);
                echo json_encode(['error' => 'Key ID is required']);
                exit();
            }
            
            $stmt = $conn->prepare("DELETE FROM api_keys WHERE id = ?");
            if (!$stmt) {
                http_response_code(500);
                echo json_encode(['error' => 'Database error']);
                exit();
            }
            $stmt->bind_param("i", $keyId);
            $stmt->execute();
            
            http_response_code(200);
            echo json_encode(['success' => true, 'message' => 'API key deleted']);
            exit();
        }
    }
    
    http_response_code(400);
    echo json_encode(['error' => 'Invalid action']);
    
} catch (Exception $e) {
    error_log("API key management error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Server error: ' . $e->getMessage()]);
}
?>
