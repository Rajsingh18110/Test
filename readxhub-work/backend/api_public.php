<?php
// Load CORS helper which sets Access-Control-Allow-Origin and credentials correctly
require_once __DIR__ . '/../cors-handler.php';

/** @psalm-suppress PossiblyNullArgument */
header('Content-Type: application/json');

// Set error handler to return JSON for all errors
set_error_handler(function($errno, $errstr, $errfile, $errline) {
    error_log("API Error [$errno]: $errstr in $errfile:$errline");
    http_response_code(500);
    echo json_encode(['error' => 'Server error']);
    exit();
});

// Set exception handler
set_exception_handler(function($exception) {
    error_log("API Exception: " . $exception->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Server error']);
    exit();
});

require_once __DIR__ . '/../Getdatabase.php';
require_once __DIR__ . '/db_init.php';
$conn = $GLOBALS['conn'];

initialize_database($conn);

if (!$conn) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection failed']);
    exit();
}

try {
    // Get API key from header or query parameter
    $apiKey = '';
    
    if (isset($_SERVER['HTTP_AUTHORIZATION'])) {
        $parts = explode(' ', $_SERVER['HTTP_AUTHORIZATION']);
        if (count($parts) === 2 && $parts[0] === 'Bearer') {
            $apiKey = $parts[1];
        }
    }
    
    if (empty($apiKey)) {
        $apiKey = $_GET['api_key'] ?? '';
    }
    
    if (empty($apiKey)) {
        http_response_code(401);
        echo json_encode(['error' => 'API key is required. Use Authorization: Bearer YOUR_API_KEY or ?api_key=YOUR_API_KEY']);
        exit();
    }
    
    // Validate API key
    $stmt = $conn->prepare("
        SELECT id, creator_email, creator_name, is_active
        FROM api_keys
        WHERE api_key = ?
    ");
    if (!$stmt) {
        http_response_code(500);
        echo json_encode(['error' => 'Database error']);
        exit();
    }
    $stmt->bind_param("s", $apiKey);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows === 0) {
        http_response_code(401);
        echo json_encode(['error' => 'Invalid API key']);
        exit();
    }
    
    $apiKeyData = $result->fetch_assoc();
    
    if (!$apiKeyData['is_active']) {
        http_response_code(401);
        echo json_encode(['error' => 'API key is inactive']);
        exit();
    }
    
    $apiKeyId = $apiKeyData['id'];
    $creatorEmail = $apiKeyData['creator_email'];
    
    // Log API usage
    $endpoint = $_GET['endpoint'] ?? 'get_blogs';
    $method = $_SERVER['REQUEST_METHOD'];
    $queryParams = json_encode($_GET);
    
    $logStmt = $conn->prepare("
        INSERT INTO api_usage_logs (api_key_id, endpoint, method, query_params, response_status)
        VALUES (?, ?, ?, ?, 200)
    ");
    if ($logStmt) {
        $logStmt->bind_param("isss", $apiKeyId, $endpoint, $method, $queryParams);
        $logStmt->execute();
    }
    
    // Update last used timestamp
    $updateStmt = $conn->prepare("
        UPDATE api_keys
        SET requests_count = requests_count + 1, last_used_at = CURRENT_TIMESTAMP
        WHERE id = ?
    ");
    if (!$updateStmt) {
        http_response_code(500);
        echo json_encode(['error' => 'Database error']);
        exit();
    }
    $updateStmt->bind_param("i", $apiKeyId);
    $updateStmt->execute();
    
    // Get query parameters
    $action = $_GET['action'] ?? 'all';
    $limit = intval($_GET['limit'] ?? 10);
    $offset = intval($_GET['offset'] ?? 0);
    $sort = $_GET['sort'] ?? 'created_at';
    $order = $_GET['order'] ?? 'DESC';
    
    // Validate limit
    $limit = min($limit, 100); // Max 100 per request
    $limit = max($limit, 1);
    
    // Validate sort and order
    $allowedSorts = ['created_at', 'title', 'views', 'likes', 'created_at'];
    $sort = in_array($sort, $allowedSorts) ? $sort : 'created_at';
    $order = strtoupper($order) === 'ASC' ? 'ASC' : 'DESC';
    
    if ($action === 'all') {
        // Get all published blogs (no personal data)
        $stmt = $conn->prepare("
            SELECT 
                bp.id,
                bp.title,
                bp.description,
                bp.slug,
                bp.author,
                bc.username as author_username,
                bp.featured_image,
                bp.featured_image_thumb,
                bp.featured_image_medium,
                bp.featured_image_large,
                bp.views,
                bp.likes,
                bp.dislikes,
                bp.created_at,
                bp.reading_time,
                bp.word_count,
                SUBSTRING(bp.content, 1, 300) as excerpt
            FROM blog_posts bp
            LEFT JOIN blog_creators bc ON bp.email = bc.email
            WHERE bp.status = 'published'
            ORDER BY bp.$sort $order
            LIMIT ? OFFSET ?
        ");
        if (!$stmt) {
            http_response_code(500);
            echo json_encode(['error' => 'Database error']);
            exit();
        }
        $stmt->bind_param("ii", $limit, $offset);
        $stmt->execute();
        $result = $stmt->get_result();
        $blogs = [];
        
        while ($row = $result->fetch_assoc()) {
            // Fix image URLs
            if ($row['featured_image'] && !str_starts_with($row['featured_image'], 'http')) {
                $row['featured_image'] = '/uploads/' . ltrim($row['featured_image'], '/');
            }
            if ($row['featured_image_thumb'] && !str_starts_with($row['featured_image_thumb'], 'http')) {
                $row['featured_image_thumb'] = '/uploads/' . ltrim($row['featured_image_thumb'], '/');
            }
            $blogs[] = $row;
        }
        
        // Get total count
        $countStmt = $conn->prepare("SELECT COUNT(*) as total FROM blog_posts WHERE status = 'published'");
        if (!$countStmt) {
            http_response_code(500);
            echo json_encode(['error' => 'Database error']);
            exit();
        }
        $countStmt->execute();
        $countResult = $countStmt->get_result();
        $countData = $countResult->fetch_assoc();
        
        http_response_code(200);
        echo json_encode([
            'success' => true,
            'data' => $blogs,
            'pagination' => [
                'limit' => $limit,
                'offset' => $offset,
                'total' => intval($countData['total'])
            ]
        ]);
        exit();
    }
    
    if ($action === 'search') {
        // Search blogs by title or keywords
        $query = $_GET['q'] ?? '';
        if (empty($query)) {
            http_response_code(400);
            echo json_encode(['error' => 'Search query (q) is required']);
            exit();
        }
        
        $searchTerm = "%$query%";
        $stmt = $conn->prepare("
            SELECT 
                bp.id,
                bp.title,
                bp.description,
                bp.slug,
                bp.author,
                bc.username as author_username,
                bp.featured_image,
                bp.featured_image_thumb,
                bp.views,
                bp.likes,
                bp.created_at,
                bp.reading_time,
                SUBSTRING(bp.content, 1, 300) as excerpt
            FROM blog_posts bp
            LEFT JOIN blog_creators bc ON bp.email = bc.email
            WHERE bp.status = 'published' AND (bp.title LIKE ? OR bp.keywords LIKE ? OR bp.description LIKE ?)
            ORDER BY bp.$sort $order
            LIMIT ? OFFSET ?
        ");
        if (!$stmt) {
            http_response_code(500);
            echo json_encode(['error' => 'Database error']);
            exit();
        }
        $stmt->bind_param("sssii", $searchTerm, $searchTerm, $searchTerm, $limit, $offset);
        $stmt->execute();
        $result = $stmt->get_result();
        $blogs = [];
        
        while ($row = $result->fetch_assoc()) {
            if ($row['featured_image'] && !str_starts_with($row['featured_image'], 'http')) {
                $row['featured_image'] = '/uploads/' . ltrim($row['featured_image'], '/');
            }
            $blogs[] = $row;
        }
        
        http_response_code(200);
        echo json_encode([
            'success' => true,
            'query' => $query,
            'data' => $blogs,
            'count' => count($blogs)
        ]);
        exit();
    }
    
    if ($action === 'author') {
        // Get blogs by specific author username
        $username = $_GET['username'] ?? '';
        if (empty($username)) {
            http_response_code(400);
            echo json_encode(['error' => 'Author username is required']);
            exit();
        }
        
        $stmt = $conn->prepare("
            SELECT 
                bp.id,
                bp.title,
                bp.description,
                bp.slug,
                bp.author,
                bc.username as author_username,
                bp.featured_image,
                bp.featured_image_thumb,
                bp.views,
                bp.likes,
                bp.created_at,
                bp.reading_time,
                SUBSTRING(bp.content, 1, 300) as excerpt
            FROM blog_posts bp
            LEFT JOIN blog_creators bc ON bp.email = bc.email
            WHERE bp.status = 'published' AND bc.username = ?
            ORDER BY bp.$sort $order
            LIMIT ? OFFSET ?
        ");
        if (!$stmt) {
            http_response_code(500);
            echo json_encode(['error' => 'Database error']);
            exit();
        }
        $stmt->bind_param("sii", $username, $limit, $offset);
        $stmt->execute();
        $result = $stmt->get_result();
        $blogs = [];
        
        while ($row = $result->fetch_assoc()) {
            if ($row['featured_image'] && !str_starts_with($row['featured_image'], 'http')) {
                $row['featured_image'] = '/uploads/' . ltrim($row['featured_image'], '/');
            }
            $blogs[] = $row;
        }
        
        http_response_code(200);
        echo json_encode([
            'success' => true,
            'author' => $username,
            'data' => $blogs,
            'count' => count($blogs)
        ]);
        exit();
    }
    
    if ($action === 'single') {
        // Get a single blog by slug
        $slug = $_GET['slug'] ?? '';
        if (empty($slug)) {
            http_response_code(400);
            echo json_encode(['error' => 'Blog slug is required']);
            exit();
        }
        
        $stmt = $conn->prepare("
            SELECT 
                bp.id,
                bp.title,
                bp.description,
                bp.slug,
                bp.author,
                bc.username as author_username,
                bc.profile_picture as author_picture,
                bp.featured_image,
                bp.featured_image_thumb,
                bp.featured_image_medium,
                bp.featured_image_large,
                bp.content,
                bp.views,
                bp.likes,
                bp.dislikes,
                bp.created_at,
                bp.reading_time,
                bp.word_count,
                bp.keywords
            FROM blog_posts bp
            LEFT JOIN blog_creators bc ON bp.email = bc.email
            WHERE bp.status = 'published' AND bp.slug = ?
            LIMIT 1
        ");
        if (!$stmt) {
            http_response_code(500);
            echo json_encode(['error' => 'Database error']);
            exit();
        }
        $stmt->bind_param("s", $slug);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result->num_rows === 0) {
            http_response_code(404);
            echo json_encode(['error' => 'Blog not found']);
            exit();
        }
        
        $blog = $result->fetch_assoc();
        
        // Fix image URLs
        foreach (['featured_image', 'featured_image_thumb', 'featured_image_medium', 'featured_image_large', 'author_picture'] as $field) {
            if ($blog[$field] && !str_starts_with($blog[$field], 'http')) {
                $blog[$field] = '/uploads/' . ltrim($blog[$field], '/');
            }
        }
        
        http_response_code(200);
        echo json_encode([
            'success' => true,
            'data' => $blog
        ]);
        exit();
    }
    
    http_response_code(400);
    echo json_encode(['error' => 'Invalid action. Valid actions: all, search, author, single']);
    
} catch (Exception $e) {
    error_log("Public API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Server error']);
}
?>
