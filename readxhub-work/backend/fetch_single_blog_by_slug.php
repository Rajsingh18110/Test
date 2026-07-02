<?php
require('../cors-handler.php');
require('../Getdatabase.php');

function ensure_slug_redirects_table($conn) {
    try {
        $conn->query("CREATE TABLE IF NOT EXISTS slug_redirects (
            id INT AUTO_INCREMENT PRIMARY KEY,
            blog_id INT NULL,
            old_slug VARCHAR(255) NOT NULL UNIQUE,
            new_slug VARCHAR(255) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            INDEX idx_new_slug (new_slug)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");
    } catch (Throwable $e) {
        error_log("Failed to ensure slug_redirects table: " . $e->getMessage());
    }
}

header("Content-Type: application/json; charset=UTF-8");
header("Cache-Control: public, max-age=300");

// Validate slug
if (!isset($_GET['slug'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Slug parameter is required']);
    exit();
}

$slug = trim($_GET['slug']);

if (!preg_match('/^[a-z0-9-]{1,200}$/', $slug)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid slug format']);
    exit();
}

ensure_slug_redirects_table($conn);

$normalized_slug = str_replace('explaination', 'explanation', $slug);
if ($normalized_slug !== $slug) {
    $oldStmt = $conn->prepare("SELECT id FROM blog_posts WHERE slug = ? LIMIT 1");
    if ($oldStmt) {
        $oldStmt->bind_param("s", $slug);
        $oldStmt->execute();
        $oldRes = $oldStmt->get_result();
        if ($oldRes && $oldRes->num_rows === 1) {
            $oldPost = $oldRes->fetch_assoc();
            $existsStmt = $conn->prepare("SELECT id FROM blog_posts WHERE slug = ? LIMIT 1");
            if ($existsStmt) {
                $existsStmt->bind_param("s", $normalized_slug);
                $existsStmt->execute();
                $existsRes = $existsStmt->get_result();
                if (!$existsRes || $existsRes->num_rows === 0) {
                    $updateStmt = $conn->prepare("UPDATE blog_posts SET slug = ?, url = CONCAT('/blog/', ?) WHERE id = ?");
                    if ($updateStmt) {
                        $updateStmt->bind_param("ssi", $normalized_slug, $normalized_slug, $oldPost['id']);
                        $updateStmt->execute();
                        $updateStmt->close();
                    }
                }
                $existsStmt->close();
            }

            $redirectStmt = $conn->prepare("INSERT INTO slug_redirects (blog_id, old_slug, new_slug) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE new_slug = VALUES(new_slug)");
            if ($redirectStmt) {
                $redirectStmt->bind_param("iss", $oldPost['id'], $slug, $normalized_slug);
                $redirectStmt->execute();
                $redirectStmt->close();
            }
        }
        $oldStmt->close();
    }

    http_response_code(301);
    echo json_encode(['redirect' => '/blog/' . $normalized_slug, 'new_slug' => $normalized_slug]);
    exit();
}

// Prepare query
$sql = "
SELECT 
  p.*,
  c.username,
  c.profile_picture,
  c.gender
FROM blog_posts p
LEFT JOIN (
    SELECT email, username, profile_picture, gender 
    FROM blog_creators gc
    WHERE gc.id = (SELECT MIN(id) FROM blog_creators WHERE email = gc.email)
) c ON p.email = c.email
WHERE p.slug = ?
LIMIT 1
";

$stmt = $conn->prepare($sql);
if (!$stmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to prepare statement']);
    exit();
}

$stmt->bind_param("s", $slug);
$stmt->execute();
$result = $stmt->get_result();

if ($result && $result->num_rows === 1) {
    echo json_encode($result->fetch_assoc());
} else {
    // Check if it's a redirected slug
    $redirStmt = $conn->prepare("SELECT new_slug FROM slug_redirects WHERE old_slug = ? LIMIT 1");
    $redirStmt->bind_param("s", $slug);
    $redirStmt->execute();
    $redirRes = $redirStmt->get_result();
    
    if ($redirRes && $redirRes->num_rows === 1) {
        $row = $redirRes->fetch_assoc();
        http_response_code(301);
        echo json_encode(['redirect' => '/blog/' . $row['new_slug'], 'new_slug' => $row['new_slug']]);
    } else {
        http_response_code(404);
        echo json_encode(['error' => 'Blog not found']);
    }
    $redirStmt->close();
}

$stmt->close();
$conn->close();
