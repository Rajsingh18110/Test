<?php
require('../cors-handler.php');

header("Content-Type: application/json");

require('../Getdatabase.php');

$request_method = $_SERVER["REQUEST_METHOD"];
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Debugging: Log request method
file_put_contents("debug.log", "Request Method: $request_method\n", FILE_APPEND);

// Fetch comments + replies

if ($request_method === "GET") {
    if (!isset($_GET["blog_id"])) {
        echo json_encode(["error" => "Missing blog ID"]);
        exit;
    }

    $blog_id = intval($_GET["blog_id"]);
    
    file_put_contents("debug.log", "Fetching comments for blog_id: $blog_id\n", FILE_APPEND);
    
    $stmt = $conn->prepare("SELECT * FROM blogcomment WHERE blog_id = ? ORDER BY created_at ASC");
    
    if (!$stmt) {
        echo json_encode(["error" => "Prepare failed: " . $conn->error]);
        exit;
    }

    $stmt->bind_param("i", $blog_id);
    $stmt->execute();
    $result = $stmt->get_result();

    $allComments = [];

    while ($row = $result->fetch_assoc()) {
        // Ensure parent_id is null or int
        $row['parent_id'] = $row['parent_id'] !== null ? (int)$row['parent_id'] : null;
        $row['id'] = (int)$row['id'];
        $allComments[] = $row;
    }

    // Return as flat array
    echo json_encode($allComments);
    exit;
}


// Insert new comment or reply
if ($request_method === "POST") {
    $data = json_decode(file_get_contents("php://input"), true);
    
    file_put_contents("debug.log", "Received POST data: " . json_encode($data) . "\n", FILE_APPEND);

    if (!isset($data["blog_id"], $data["text"], $data["user_email"], $data["user_name"], $data["profile_picture_url"])) {
        echo json_encode(["error" => "Invalid data"]);
        exit;
    }

    $parent_id = isset($data["parent_id"]) ? intval($data["parent_id"]) : null;

    $stmt = $conn->prepare("INSERT INTO blogcomment (blog_id, user_email, user_name, profile_picture_url, text, parent_id) VALUES (?, ?, ?, ?, ?, ?)");
    
    if (!$stmt) {
        echo json_encode(["error" => "Prepare failed: " . $conn->error]);
        exit;
    }

    $stmt->bind_param("issssi", $data["blog_id"], $data["user_email"], $data["user_name"], $data["profile_picture_url"], $data["text"], $parent_id);
    
    if ($stmt->execute()) {
        echo json_encode(["message" => "Comment or reply added"]);
    } else {
        echo json_encode(["error" => "Insert failed: " . $stmt->error]);
    }
    exit;
}

// Update a comment
if ($request_method === "PUT") {
    $data = json_decode(file_get_contents("php://input"), true);
    
    file_put_contents("debug.log", "Received PUT data: " . json_encode($data) . "\n", FILE_APPEND);

    if (!isset($data["id"], $data["text"], $data["user_email"])) {
        echo json_encode(["error" => "Invalid data"]);
        exit;
    }

    $stmt = $conn->prepare("UPDATE blogcomment SET text = ? WHERE id = ? AND user_email = ?");
    
    if (!$stmt) {
        echo json_encode(["error" => "Prepare failed: " . $conn->error]);
        exit;
    }

    $stmt->bind_param("sis", $data["text"], $data["id"], $data["user_email"]);
    
    if ($stmt->execute()) {
        echo json_encode(["message" => "Comment updated"]);
    } else {
        echo json_encode(["error" => "Update failed: " . $stmt->error]);
    }
    exit;
}

// Delete a comment (and its replies)


// Delete a comment (and its replies if top-level)
if ($request_method === "DELETE") {
    $data = json_decode(file_get_contents("php://input"), true);

    file_put_contents("debug.log", "Received DELETE data: " . json_encode($data) . "\n", FILE_APPEND);

    if (!isset($data["id"], $data["user_email"])) {
        echo json_encode(["error" => "Invalid data"]);
        exit;
    }

    // Get the comment to check if it's a reply or top-level
    $stmt = $conn->prepare("SELECT parent_id FROM blogcomment WHERE id = ?");
    $stmt->bind_param("i", $data["id"]);
    $stmt->execute();
    $result = $stmt->get_result();
    $comment = $result->fetch_assoc();

    if (!$comment) {
        echo json_encode(["error" => "Comment not found"]);
        exit;
    }

    if ($comment['parent_id'] === null) {
        // Top-level comment: delete all replies and the comment itself
        $deleteReplies = $conn->prepare("DELETE FROM blogcomment WHERE parent_id = ?");
        $deleteReplies->bind_param("i", $data["id"]);
        $deleteReplies->execute();

        $stmt = $conn->prepare("DELETE FROM blogcomment WHERE id = ? AND user_email = ?");
        $stmt->bind_param("is", $data["id"], $data["user_email"]);
        if ($stmt->execute()) {
            echo json_encode(["message" => "Comment and its replies deleted"]);
        } else {
            echo json_encode(["error" => "Delete failed: " . $stmt->error]);
        }
    } else {
        // Reply: only delete if user is the owner
        $stmt = $conn->prepare("DELETE FROM blogcomment WHERE id = ? AND user_email = ?");
        $stmt->bind_param("is", $data["id"], $data["user_email"]);
        if ($stmt->execute()) {
            echo json_encode(["message" => "Reply deleted"]);
        } else {
            echo json_encode(["error" => "Delete failed: " . $stmt->error]);
        }
    }
    exit;
}



// Handle OPTIONS request for CORS
if ($request_method === "OPTIONS") {
    header("HTTP/1.1 200 OK");
    exit;
}

echo json_encode(["error" => "Invalid request method"]);
?>
