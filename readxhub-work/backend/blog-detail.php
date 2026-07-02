<?php
$databaseFile = __DIR__ . '/../Getdatabase.php';
if (file_exists($databaseFile)) {
    require_once $databaseFile;
} else {
    $conn = null;
}

// Function to create slug from title
function createSlug($string) {
    $slug = preg_replace('/[^a-z0-9-]+/', '-', strtolower(trim($string)));
    return rtrim($slug, '-');
}
function removeUnwantedTags($content) {
    // Remove unwanted tags
    $content = preg_replace('/<script.*?<\/script>/is', '', $content); // Remove script tags
    $content = preg_replace('/<style.*?<\/style>/is', '', $content); // Remove style tags
    $content = preg_replace('/<iframe.*?<\/iframe>/is', '', $content); // Remove iframe tags
    // Add more rules as needed

    return $content;
}

if (!isset($conn) || !($conn instanceof mysqli)) {
    http_response_code(500);
    echo 'Database connection is unavailable.';
    exit;
}

// Fetch a single blog post by ID
$blog = null;
if (isset($_GET['id'])) {
    $id = $conn->real_escape_string($_GET['id']);
    
    // Prepare the SQL statement with placeholders
    $sql = "SELECT * FROM blogs WHERE id = ?";
    $stmt = $conn->prepare($sql);
    
    if ($stmt === false) {
        die("Prepare failed: " . htmlspecialchars($conn->error));
    }
    
    $stmt->bind_param("i", $id);
    
    if (!$stmt->execute()) {
        die("Execute failed: " . htmlspecialchars($stmt->error));
    }
    
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        $blog = $result->fetch_assoc();
    } else {
        echo "Blog post not found.";
        exit;
    }
    
    $stmt->close();
}

if (isset($conn) && $conn instanceof mysqli) {
    $conn->close();
}

if (!$blog) {
    echo "Blog post not found.";
    exit;
}

// Split tags into an array
$tags = explode(',', $blog['tags']); // Assuming tags are stored as comma-separated values


$siteBaseUrl = 'https://readxhub.in';
$blogTitle = urlencode($blog['title']);
$blogUrl = urlencode($siteBaseUrl . '/blog-detail.php?id=' . $blog['id']);
$whatsappMessage = "Check out this amazing blog: $blogTitle - $blogUrl";
$whatsappLink = "https://wa.me/?text=$whatsappMessage";

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo htmlspecialchars($blog['title']); ?> - ReadXHub</title>
    <meta name="description" content="<?php echo htmlspecialchars($blog['description']); ?>">
    <meta name="keywords" content="<?php echo htmlspecialchars($blog['keywords']); ?>">
    <meta name="author" content="<?php echo htmlspecialchars($blog['author']); ?>">
    <link rel="icon" type="image/x-icon" href="/logo.png">

    <!-- Open Graph tags -->
    <meta property="og:title" content="<?php echo htmlspecialchars($blog['title']); ?>">
    <meta property="og:description" content="<?php echo htmlspecialchars($blog['description']); ?>">
    <meta property="og:image" content="<?php echo htmlspecialchars($blog['image']); ?>">
    <meta property="og:url" content="<?php echo htmlspecialchars($siteBaseUrl . '/blog-detail.php?id=' . $blog['id']); ?>">
    
    <!-- Twitter Card tags -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="<?php echo htmlspecialchars($blog['title']); ?>">
    <meta name="twitter:description" content="<?php echo htmlspecialchars($blog['description']); ?>">
    <meta name="twitter:image" content="<?php echo htmlspecialchars($blog['image']); ?>">
    
    <!-- Canonical tag -->
    <link rel="canonical" href="<?php echo htmlspecialchars($siteBaseUrl . '/blog-detail.php?id=' . $blog['id']); ?>">
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap">
    <style>
        /* Basic Reset and Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Roboto', sans-serif;
            background: #f0f2f5;
            color: #333;
            padding: 20px;
        }

        /* Header */
        .header {
            background: linear-gradient(to right, #ff8a00, #da1b60);
            color: #fff;
            padding: 20px 0;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
        }
        .header h1 {
            font-size: 2.5rem;
        }

        /* Blog Post Detail */
        .blog-detail {
            max-width: 800px;
            margin: 20px auto;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .blog-detail h2 {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        .blog-detail p {
            font-size: 1rem;
            line-height: 1.6;
            color: #555;
        }
        .blog-tags {
            margin: 20px 0;
        }
        .blog-tags span {
            background: #da1b60;
            color: #fff;
            padding: 5px 10px;
            border-radius: 5px;
            margin-right: 5px;
            display: inline-block;
        }

        /* Footer */
        .footer {
            background: #222;
            color: #fff;
            text-align: center;
            padding: 20px;
            margin-top: 40px;
            border-radius: 10px;
        }
        .footer a {
            color: #61ce70;
            text-decoration: none;
        }
        .footer a:hover {
            text-decoration: underline;
        }

        /* Comment Section Styles */
        .comment-section {
            margin: 20px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
        }

        .comment-section h2 {
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }

        /* Comment Form Styles */
        .comment-section form {
            margin-bottom: 20px;
        }

        .comment-class {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            color: #333;
        }

        .comment-btn {
            margin-top: 10px;
            padding: 10px 15px;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            color: #fff;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .comment-btn:hover {
            background-color: #0056b3;
        }

        /* Comment and Reply Styles */
        .comment {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fff;
        }

        .comment p {
            margin: 0;
            font-size: 16px;
            color: #333;
        }

        .comment small {
            display: block;
            margin-top: 5px;
            font-size: 12px;
            color: #888;
        }

        .comment .edit-form, .comment .delete-form, .comment form {
            margin-top: 10px;
        }

        .comment textarea {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            color: #333;
        }

        .comment button {
            margin-top: 5px;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            color: #fff;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .comment .edit-form button {
            background-color: #28a745;
        }

        .comment .edit-form button:hover {
            background-color: #218838;
        }

        .comment .delete-form button {
            background-color: #dc3545;
        }

        .comment .delete-form button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <header class="header">
        <h1>Welcome To Malicious Direction</h1>
    </header>

<main class="blog-detail">
    <h2><?php echo htmlspecialchars($blog['title']); ?></h2>
    <p><?php echo removeUnwantedTags($blog['content']); ?></p>
    <div class="blog-tags">
        <?php foreach ($tags as $tag): ?>
            <span><?php echo htmlspecialchars(trim($tag)); ?></span>
        <?php endforeach; ?>
    </div>
    <a href="<?php echo $whatsappLink; ?>" target="_blank" style="display: inline-block; padding: 10px 15px; background-color: #25D366; color: white; border-radius: 5px; text-decoration: none; font-weight: bold;">
    Share on WhatsApp
</a>
</main>


  
    <footer class="footer">
        <p>&copy; 2024 ReadXHub. All rights reserved.</p>
        <a href="https://readxhub.in">Visit our site</a>
    </footer>
</body>
</html>
