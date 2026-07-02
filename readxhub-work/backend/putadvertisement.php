<?php
// putadvertisement.php - Admin Advertisement Dashboard
session_start();
require_once(__DIR__ . '/../Getdatabase.php');
require_once(__DIR__ . '/db_init.php');

// Trigger database auto-migration/check
initialize_database($conn);

$admin_password_hash = hash('sha256', 'Adarsh@Ayushi#10100');

// Login handling
if (isset($_POST['login'])) {
    $password_input = isset($_POST['password']) ? $_POST['password'] : '';
    if (hash('sha256', $password_input) === $admin_password_hash) {
        $_SESSION['admin_logged_in'] = true;
    } else {
        $login_error = "Invalid admin credentials. Access Denied.";
    }
}

// Logout handling
if (isset($_GET['action']) && $_GET['action'] === 'logout') {
    $_SESSION['admin_logged_in'] = false;
    session_destroy();
    header("Location: putadvertisement.php");
    exit();
}

$is_logged_in = isset($_SESSION['admin_logged_in']) && $_SESSION['admin_logged_in'] === true;

// Action handling: Save Ad
$message = '';
$error = '';

if ($is_logged_in && $_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_ad'])) {
    $slot_name = isset($_POST['slot_name']) ? trim($_POST['slot_name']) : '';
    $link_url = isset($_POST['link_url']) ? trim($_POST['link_url']) : '';
    $alt_text = isset($_POST['alt_text']) ? trim($_POST['alt_text']) : '';
    $image_url = isset($_POST['image_url']) ? trim($_POST['image_url']) : '';
    
    // Check if slot name is valid
    $valid_slots = ['top_banner', 'sidebar', 'in_article', 'footer_banner'];
    if (!in_array($slot_name, $valid_slots)) {
        $error = "Invalid advertisement slot selected.";
    } elseif (empty($link_url)) {
        $error = "Destination hyperlink URL is required.";
    } else {
        // Handle File Upload if provided
        if (isset($_FILES['image_file']) && $_FILES['image_file']['error'] === UPLOAD_ERR_OK) {
            $fileTmpPath = $_FILES['image_file']['tmp_name'];
            $fileName = $_FILES['image_file']['name'];
            $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));
            
            $allowedExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
            if (in_array($fileExtension, $allowedExtensions)) {
                $uploadDir = __DIR__ . '/uploads/media/';
                if (!is_dir($uploadDir)) {
                    mkdir($uploadDir, 0755, true);
                }
                
                $newFileName = md5(time() . $fileName) . '.' . $fileExtension;
                $destPath = $uploadDir . $newFileName;
                
                if (move_uploaded_file($fileTmpPath, $destPath)) {
                    $image_url = 'uploads/media/' . $newFileName;
                } else {
                    $error = "Failed to save uploaded file on server.";
                }
            } else {
                $error = "Invalid file type. Allowed formats: JPG, PNG, GIF, WEBP.";
            }
        }
        
        if (empty($error)) {
            if (empty($image_url)) {
                $error = "Please provide an image URL or upload an image file.";
            } else {
                // Insert the advertisement
                $saveStmt = $conn->prepare("
                    INSERT INTO blog_advertisements (slot_name, image_url, link_url, alt_text) 
                    VALUES (?, ?, ?, ?)
                ");
                if ($saveStmt) {
                    $saveStmt->bind_param("ssss", $slot_name, $image_url, $link_url, $alt_text);
                    if ($saveStmt->execute()) {
                        $message = "Advertisement for " . htmlspecialchars(ucwords(str_replace('_', ' ', $slot_name))) . " saved successfully!";
                    } else {
                        $error = "Database execution error: " . $saveStmt->error;
                    }
                    $saveStmt->close();
                } else {
                    $error = "Database prepare error: " . $conn->error;
                }
            }
        }
    }
}

// Action handling: Delete Ad
if ($is_logged_in && isset($_GET['action']) && $_GET['action'] === 'delete' && isset($_GET['id'])) {
    $del_id = intval($_GET['id']);
    $delStmt = $conn->prepare("DELETE FROM blog_advertisements WHERE id = ?");
    if ($delStmt) {
        $delStmt->bind_param("i", $del_id);
        if ($delStmt->execute()) {
            $message = "Advertisement deleted successfully.";
        } else {
            $error = "Failed to delete advertisement.";
        }
        $delStmt->close();
    }
}

// Retrieve all current ads
$current_ads = [];
if ($is_logged_in) {
    $res = $conn->query("SELECT * FROM blog_advertisements ORDER BY slot_name ASC, id DESC");
    if ($res) {
        while ($row = $res->fetch_assoc()) {
            $current_ads[] = $row;
        }
    }
}
$conn->close();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advertisement Control Panel - ReadXHub</title>
    <style>
        :root {
            --bg-color: #030712;
            --card-bg: rgba(17, 24, 39, 0.7);
            --border-color: rgba(31, 41, 55, 0.8);
            --text-color: #e5e7eb;
            --cyan-accent: #22d3ee;
            --cyan-hover: #0891b2;
            --red-accent: #f87171;
            --input-bg: #090d16;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            margin: 0;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 90vh;
        }
        .container {
            width: 100%;
            max-width: 800px;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(8px);
        }
        h1 {
            font-size: 22px;
            font-weight: 800;
            margin-top: 0;
            margin-bottom: 20px;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        h1 span {
            color: var(--cyan-accent);
        }
        .logout-btn {
            font-size: 12px;
            color: var(--red-accent);
            text-decoration: none;
            border: 1px solid var(--red-accent);
            padding: 4px 10px;
            border-radius: 6px;
            transition: all 0.2s;
        }
        .logout-btn:hover {
            background-color: var(--red-accent);
            color: #000;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #9ca3af;
            margin-bottom: 6px;
        }
        input, select, textarea {
            width: 100%;
            padding: 10px 12px;
            background-color: var(--input-bg);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            color: #fff;
            box-sizing: border-box;
            font-size: 13px;
        }
        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--cyan-accent);
        }
        .submit-btn {
            background-color: var(--cyan-accent);
            color: #030712;
            font-weight: 700;
            cursor: pointer;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-size: 13px;
            width: 100%;
            transition: all 0.2s;
        }
        .submit-btn:hover {
            background-color: var(--cyan-hover);
        }
        .alert {
            padding: 12px 15px;
            border-radius: 8px;
            font-size: 13px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .alert-success {
            background-color: rgba(16, 185, 129, 0.15);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.2);
        }
        .alert-danger {
            background-color: rgba(239, 68, 68, 0.15);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.2);
        }
        .ad-list {
            margin-top: 30px;
            border-top: 1px solid var(--border-color);
            padding-top: 20px;
        }
        .ad-item {
            background-color: var(--input-bg);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
        }
        .ad-preview {
            width: 120px;
            height: 60px;
            background-color: #111827;
            border-radius: 6px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid var(--border-color);
        }
        .ad-preview img {
            width: 100%;
            height: 100%;
            object-cover: contain;
        }
        .ad-info {
            flex-grow: 1;
        }
        .ad-slot-title {
            font-weight: 700;
            color: #fff;
            font-size: 13px;
            margin-bottom: 4px;
        }
        .ad-url {
            font-size: 11px;
            color: #9ca3af;
            word-break: break-all;
        }
        .delete-link {
            color: var(--red-accent);
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            border: 1px solid rgba(248, 113, 113, 0.2);
            padding: 6px 12px;
            border-radius: 6px;
            transition: all 0.2s;
        }
        .delete-link:hover {
            background-color: var(--red-accent);
            color: #000;
        }
    </style>
</head>
<body>

<div class="container">
    <?php if (!$is_logged_in): ?>
        <h1>Control Panel <span>Login</span></h1>
        
        <?php if (isset($login_error)): ?>
            <div class="alert alert-danger"><?php echo htmlspecialchars($login_error); ?></div>
        <?php endif; ?>
        
        <form method="POST">
            <div class="form-group">
                <label for="password">Enter Admin Password</label>
                <input type="password" id="password" name="password" required placeholder="••••••••••••••">
            </div>
            <button type="submit" name="login" class="submit-btn">Authenticate</button>
        </form>
    <?php else: ?>
        <h1>
            Advertisement <span>Control Panel</span>
            <a href="?action=logout" class="logout-btn">Log Out</a>
        </h1>

        <?php if (!empty($message)): ?>
            <div class="alert alert-success"><?php echo htmlspecialchars($message); ?></div>
        <?php endif; ?>
        <?php if (!empty($error)): ?>
            <div class="alert alert-danger"><?php echo htmlspecialchars($error); ?></div>
        <?php endif; ?>

        <form method="POST" enctype="multipart/form-data">
            <input type="hidden" name="save_ad" value="1">
            <div class="form-group">
                <label for="slot_name">Select Target Ad Slot</label>
                <select id="slot_name" name="slot_name" required>
                    <option value="">-- Choose Placement --</option>
                    <option value="top_banner">Top Banner Ad Slot</option>
                    <option value="sidebar">Sidebar Ad Slot</option>
                    <option value="in_article">In-Article Ad Slot</option>
                    <option value="footer_banner">Footer Banner Ad Slot</option>
                </select>
            </div>

            <div class="form-group">
                <label for="image_file">Upload Image File (Recommended)</label>
                <input type="file" id="image_file" name="image_file" accept="image/*">
            </div>

            <div class="form-group">
                <label for="image_url">OR Input Image URL (Fallback)</label>
                <input type="text" id="image_url" name="image_url" placeholder="https://example.com/banner.png">
            </div>

            <div class="form-group">
                <label for="link_url">Hyperlink Destination URL</label>
                <input type="url" id="link_url" name="link_url" required placeholder="https://readxhub.in">
            </div>

            <div class="form-group">
                <label for="alt_text">Alt Text (For accessibility & SEO)</label>
                <input type="text" id="alt_text" name="alt_text" placeholder="e.g. Check out readxhub premium tracks">
            </div>

            <button type="submit" class="submit-btn">Save Advertisement</button>
        </form>

        <div class="ad-list">
            <h2 style="font-size: 15px; font-weight: 800; margin-bottom: 15px; color: #fff;">Active Advertisements</h2>
            
            <?php if (empty($current_ads)): ?>
                <p style="font-size: 12px; color: #9ca3af; text-align: center; padding: 20px; border: 1px dashed var(--border-color); border-radius: 8px;">No active advertisements found. Configure one above.</p>
            <?php else: ?>
                <?php foreach ($current_ads as $ad): ?>
                    <div class="ad-item">
                        <div class="ad-preview">
                            <?php 
                                $src = $ad['image_url'];
                                if (strpos($src, 'http') !== 0) {
                                    $src = '/' . $src;
                                }
                            ?>
                            <img src="<?php echo htmlspecialchars($src); ?>" alt="<?php echo htmlspecialchars($ad['alt_text']); ?>">
                        </div>
                        <div class="ad-info">
                            <div class="ad-slot-title"><?php echo htmlspecialchars(ucwords(str_replace('_', ' ', $ad['slot_name']))); ?></div>
                            <div class="ad-url"><?php echo htmlspecialchars($ad['link_url']); ?></div>
                        </div>
                        <div>
                            <a href="?action=delete&id=<?php echo urlencode($ad['id']); ?>" class="delete-link" onclick="return confirm('Are you sure you want to delete this ad?');">Delete</a>
                        </div>
                    </div>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>
    <?php endif; ?>
</div>

</body>
</html>
