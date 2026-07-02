<?php
// Prevent direct access
if (basename($_SERVER['PHP_SELF']) == 'db_init.php') {
    http_response_code(403);
    exit("Forbidden");
}

function initialize_database($conn) {
    if (!$conn) {
        error_log("initialize_database: \$conn is null, skipping migrations.");
        return;
    }

    // ── Remove duplicate comments (keep earliest id per blog+user+text) ────────
    // This is a one-time cleanup; no-op once duplicates are gone.
    try {
        $conn->query("
            DELETE bc2
            FROM   blogcomment bc1
            JOIN   blogcomment bc2
                ON  bc2.blog_id    = bc1.blog_id
                AND bc2.user_email = bc1.user_email
                AND bc2.text       = bc1.text
                AND bc2.id         > bc1.id
        ");
    } catch (Throwable $e) {
        error_log("Dedup blogcomment error: " . $e->getMessage());
    }

    // Cleanup string 'null'/'undefined'/empty image fields to SQL NULL
    try {
        $fields = ['featured_image', 'featured_image_thumb', 'featured_image_medium', 'featured_image_large', 'image_alt', 'image_caption', 'image_credit'];
        foreach ($fields as $field) {
            $conn->query("UPDATE blog_posts SET `$field` = NULL WHERE `$field` = 'null' OR `$field` = 'undefined' OR `$field` = ''");
        }
    } catch (Throwable $e) {
        error_log("Database image null cleanup error: " . $e->getMessage());
    }

    // Recalculate reading time and word count for all posts to fix old entries
    try {
        $result = $conn->query("SELECT id, content FROM blog_posts");
        if ($result) {
            $stmt = $conn->prepare("UPDATE blog_posts SET reading_time = ?, word_count = ? WHERE id = ?");
            if ($stmt) {
                while ($row = $result->fetch_assoc()) {
                    $content = $row['content'];
                    $clean_content = strip_tags($content);
                    $image_count = preg_match_all('/!\[.*?\]\(.*?\)/', $content, $matches);
                    $clean_content = preg_replace('/!\[.*?\]\(.*?\)/', '', $clean_content);
                    $video_count = preg_match_all('/\[youtube:[^\]]+\]/', $content, $matches);
                    $clean_content = preg_replace('/\[youtube:[^\]]+\]/', '', $clean_content);
                    
                    $words = preg_split('/\s+/', trim($clean_content));
                    $word_count = empty($words[0]) ? 0 : count($words);
                    
                    $wpm = 180;
                    $time = $word_count / $wpm;
                    
                    $image_time = 0;
                    if ($image_count > 0) {
                        $first_image_time = 12;
                        for ($i = 0; $i < $image_count; $i++) {
                            $image_time += max(3, $first_image_time - $i) / 60;
                        }
                    }
                    $video_time = $video_count * 1.0;
                    $total_time = ceil($time + $image_time + $video_time);
                    $reading_time = max(1, (int)$total_time);

                    $stmt->bind_param("iii", $reading_time, $word_count, $row['id']);
                    $stmt->execute();
                }
                $stmt->close();
            }
        }
    } catch (Throwable $e) {
        error_log("Database reading time recalculation error: " . $e->getMessage());
    }



    // 1. Create blog_creators if not exists
    $creatorsTableSql = "
        CREATE TABLE IF NOT EXISTS blog_creators (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            phone VARCHAR(20) NOT NULL,
            date_of_birth DATE NOT NULL,
            bio TEXT NOT NULL,
            profile_picture VARCHAR(255) NOT NULL,
            email VARCHAR(255) NOT NULL UNIQUE,
            username VARCHAR(255) UNIQUE,
            gender VARCHAR(20) DEFAULT 'male',
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ";
    if (!$conn->query($creatorsTableSql)) {
        error_log("Failed to create blog_creators table: " . $conn->error);
    }

    // 2. Create blog_posts if not exists
    $postsTableSql = "
        CREATE TABLE IF NOT EXISTS blog_posts (
            id INT AUTO_INCREMENT PRIMARY KEY,
            title VARCHAR(255) NOT NULL,
            description TEXT NOT NULL,
            keywords TEXT,
            author VARCHAR(255) NOT NULL,
            content LONGTEXT NOT NULL,
            slug VARCHAR(255) NOT NULL UNIQUE,
            url VARCHAR(255),
            email VARCHAR(255) NOT NULL,
            views INT DEFAULT 0,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ";
    if (!$conn->query($postsTableSql)) {
        error_log("Failed to create blog_posts table: " . $conn->error);
    }

    // 3. Create blogcomment if not exists
    $commentTableSql = "
        CREATE TABLE IF NOT EXISTS blogcomment (
            id INT AUTO_INCREMENT PRIMARY KEY,
            blog_id INT NOT NULL,
            user_email VARCHAR(255) NOT NULL,
            user_name VARCHAR(255) NOT NULL,
            profile_picture_url VARCHAR(255) NOT NULL,
            text TEXT NOT NULL,
            parent_id INT DEFAULT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ";
    if (!$conn->query($commentTableSql)) {
        error_log("Failed to create blogcomment table: " . $conn->error);
    }

    // 3b. Create creator_subscriptions if not exists
    $subsTableSql = "
        CREATE TABLE IF NOT EXISTS creator_subscriptions (
            id INT AUTO_INCREMENT PRIMARY KEY,
            creator_email VARCHAR(255) NOT NULL,
            subscriber_email VARCHAR(255) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            UNIQUE KEY unique_sub (creator_email, subscriber_email)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ";
    if (!$conn->query($subsTableSql)) {
        error_log("Failed to create creator_subscriptions table: " . $conn->error);
    }

    // 4. Check & add columns dynamically (Migrations)
    // check 'username' in 'blog_creators'
    $res = $conn->query("SHOW COLUMNS FROM blog_creators LIKE 'username'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_creators ADD COLUMN username VARCHAR(255) UNIQUE AFTER email");
    }

    // check 'gender' in 'blog_creators'
    $res = $conn->query("SHOW COLUMNS FROM blog_creators LIKE 'gender'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_creators ADD COLUMN gender VARCHAR(20) DEFAULT 'male' AFTER username");
    }

    // check 'show_email' in 'blog_creators'
    $res = $conn->query("SHOW COLUMNS FROM blog_creators LIKE 'show_email'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_creators ADD COLUMN show_email TINYINT(1) DEFAULT 0 AFTER gender");
    }

    // check 'public_email' in 'blog_creators'
    $res = $conn->query("SHOW COLUMNS FROM blog_creators LIKE 'public_email'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_creators ADD COLUMN public_email VARCHAR(255) DEFAULT NULL AFTER show_email");
    }

    // check 'created_at' in 'creator_subscriptions'
    $res = $conn->query("SHOW COLUMNS FROM creator_subscriptions LIKE 'created_at'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE creator_subscriptions ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP AFTER subscriber_email");
    }

    // check 'views' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'views'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN views INT DEFAULT 0 AFTER email");
    }

    // check 'notifications_sent' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'notifications_sent'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN notifications_sent TINYINT(1) DEFAULT 0 AFTER views");
    }

    // check 'likes' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'likes'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN likes INT DEFAULT 0 AFTER notifications_sent");
    }

    // check 'dislikes' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'dislikes'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN dislikes INT DEFAULT 0 AFTER likes");
    }

    // check 'status' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'status'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN status ENUM('draft', 'scheduled', 'published', 'archived', 'private') DEFAULT 'published' AFTER email");
    }

    // check 'featured_image' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'featured_image'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN featured_image VARCHAR(255) DEFAULT NULL AFTER status");
    }

    // check 'featured_image_thumb' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'featured_image_thumb'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN featured_image_thumb VARCHAR(255) DEFAULT NULL AFTER featured_image");
    }

    // check 'featured_image_medium' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'featured_image_medium'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN featured_image_medium VARCHAR(255) DEFAULT NULL AFTER featured_image_thumb");
    }

    // check 'featured_image_large' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'featured_image_large'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN featured_image_large VARCHAR(255) DEFAULT NULL AFTER featured_image_medium");
    }

    // check 'image_alt' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'image_alt'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN image_alt VARCHAR(255) DEFAULT NULL AFTER featured_image_large");
    }

    // check 'image_caption' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'image_caption'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN image_caption TEXT DEFAULT NULL AFTER image_alt");
    }

    // check 'image_credit' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'image_credit'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN image_credit VARCHAR(255) DEFAULT NULL AFTER image_caption");
    }

    // check 'mime_type' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'mime_type'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN mime_type VARCHAR(50) DEFAULT NULL AFTER image_credit");
    }

    // check 'seo_title' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'seo_title'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN seo_title VARCHAR(255) DEFAULT NULL AFTER mime_type");
    }

    // check 'seo_description' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'seo_description'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN seo_description TEXT DEFAULT NULL AFTER seo_title");
    }

    // check 'focus_keyword' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'focus_keyword'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN focus_keyword VARCHAR(255) DEFAULT NULL AFTER seo_description");
    }

    // check 'social_title' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'social_title'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN social_title VARCHAR(255) DEFAULT NULL AFTER focus_keyword");
    }

    // check 'social_description' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'social_description'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN social_description TEXT DEFAULT NULL AFTER social_title");
    }

    // check 'social_image' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'social_image'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN social_image VARCHAR(255) DEFAULT NULL AFTER social_description");
    }

    // check 'canonical_url' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'canonical_url'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN canonical_url VARCHAR(255) DEFAULT NULL AFTER social_image");
    }

    // check 'robots_override' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'robots_override'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN robots_override VARCHAR(50) DEFAULT NULL AFTER canonical_url");
    }

    // check 'reading_time' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'reading_time'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN reading_time INT DEFAULT 0 AFTER robots_override");
    }

    // check 'word_count' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'word_count'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN word_count INT DEFAULT 0 AFTER reading_time");
    }

    // check 'publish_date' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'publish_date'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN publish_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP AFTER created_at");
    }

    // check 'trending_score' in 'blog_posts'
    $res = $conn->query("SHOW COLUMNS FROM blog_posts LIKE 'trending_score'");
    if ($res && $res->num_rows == 0) {
        $conn->query("ALTER TABLE blog_posts ADD COLUMN trending_score DECIMAL(10,4) DEFAULT 0.0000");
    }

    // Slug redirects preserve SEO equity after URL corrections.
    try {
        $conn->query("CREATE TABLE IF NOT EXISTS slug_redirects (
            id INT AUTO_INCREMENT PRIMARY KEY,
            blog_id INT NULL,
            old_slug VARCHAR(255) NOT NULL UNIQUE,
            new_slug VARCHAR(255) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            INDEX idx_new_slug (new_slug)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

        $typoRows = $conn->query("SELECT id, slug FROM blog_posts WHERE slug LIKE '%explaination%'");
        if ($typoRows) {
            while ($row = $typoRows->fetch_assoc()) {
                $oldSlug = $row['slug'];
                $newSlug = str_replace('explaination', 'explanation', $oldSlug);
                if ($oldSlug === $newSlug) continue;

                $redirectStmt = $conn->prepare("INSERT INTO slug_redirects (blog_id, old_slug, new_slug) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE new_slug = VALUES(new_slug)");
                if ($redirectStmt) {
                    $redirectStmt->bind_param("iss", $row['id'], $oldSlug, $newSlug);
                    $redirectStmt->execute();
                    $redirectStmt->close();
                }

                $updateStmt = $conn->prepare("UPDATE blog_posts SET slug = ?, url = CONCAT('/blog/', ?) WHERE id = ? AND NOT EXISTS (SELECT 1 FROM (SELECT id FROM blog_posts WHERE slug = ?) AS existing_slug)");
                if ($updateStmt) {
                    $updateStmt->bind_param("ssis", $newSlug, $newSlug, $row['id'], $newSlug);
                    $updateStmt->execute();
                    $updateStmt->close();
                }
            }
        }
    } catch (Throwable $e) {
        error_log("Slug redirect migration error: " . $e->getMessage());
    }

    try {
        $conn->query("UPDATE blog_posts SET canonical_url = REPLACE(canonical_url, 'https://blogs.readxhub.in', 'https://readxhub.in') WHERE canonical_url LIKE 'https://blogs.readxhub.in/%'");
    } catch (Throwable $e) {
        error_log("Canonical URL migration error: " . $e->getMessage());
    }

    // 4b. Create blog_reactions table if not exists (MOVED INSIDE FUNCTION)
    try {
        $conn->query("CREATE TABLE IF NOT EXISTS blog_reactions (
            id INT AUTO_INCREMENT PRIMARY KEY,
            blog_id INT NOT NULL,
            user_email VARCHAR(255) NOT NULL,
            reaction ENUM('like','dislike') NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            UNIQUE KEY uq_blog_user (blog_id, user_email)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");
    } catch (Throwable $e) {
        error_log("Failed to create blog_reactions table: " . $e->getMessage());
    }

    // 4c. Create blog_views table if not exists (MOVED INSIDE FUNCTION)
    try {
        $conn->query("CREATE TABLE IF NOT EXISTS blog_views (
            id INT AUTO_INCREMENT PRIMARY KEY,
            blog_id INT NOT NULL,
            user_email VARCHAR(255) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            UNIQUE KEY uq_blog_view_user (blog_id, user_email)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");
    } catch (Throwable $e) {
        error_log("Failed to create blog_views table: " . $e->getMessage());
    }

    // 4d. Enforce unique index on blog_reactions (MOVED INSIDE FUNCTION)
    try {
        $conn->query("
            DELETE r1 FROM blog_reactions r1
            INNER JOIN blog_reactions r2 ON r1.blog_id = r2.blog_id AND r1.user_email = r2.user_email
            WHERE r1.id > r2.id
        ");
        $indexCheck = $conn->query("SHOW INDEX FROM blog_reactions WHERE Key_name = 'uq_blog_user'");
        if ($indexCheck && $indexCheck->num_rows == 0) {
            $conn->query("ALTER TABLE blog_reactions ADD UNIQUE KEY uq_blog_user (blog_id, user_email)");
        }
    } catch (Throwable $e) {
        error_log("Migration error for blog_reactions: " . $e->getMessage());
    }

    // 4e. Enforce unique index on blog_views (MOVED INSIDE FUNCTION)
    try {
        $conn->query("
            DELETE v1 FROM blog_views v1
            INNER JOIN blog_views v2 ON v1.blog_id = v2.blog_id AND v1.user_email = v2.user_email
            WHERE v1.id > v2.id
        ");
        $viewIndexCheck = $conn->query("SHOW INDEX FROM blog_views WHERE Key_name = 'uq_blog_view_user'");
        if ($viewIndexCheck && $viewIndexCheck->num_rows == 0) {
            $conn->query("ALTER TABLE blog_views ADD UNIQUE KEY uq_blog_view_user (blog_id, user_email)");
        }
    } catch (Throwable $e) {
        error_log("Migration error for blog_views: " . $e->getMessage());
    }

    // 5. Backfill usernames for existing creators who don't have one
    $emptyCreatorsRes = $conn->query("SELECT id, name, email FROM blog_creators WHERE username IS NULL OR username = ''");
    if ($emptyCreatorsRes && $emptyCreatorsRes->num_rows > 0) {
        while ($row = $emptyCreatorsRes->fetch_assoc()) {
            $creatorId = $row['id'];
            $creatorName = $row['name'];

            // Try to generate a clean username from name, e.g. "alan_turing"
            $baseUsername = strtolower(trim(preg_replace('/[^a-zA-Z0-9]+/', '_', $creatorName), '_'));
            if (empty($baseUsername)) {
                $baseUsername = "user";
            }

            // Ensure uniqueness
            $username = $baseUsername;
            $counter = 1;
            while (true) {
                $checkStmt = $conn->prepare("SELECT id FROM blog_creators WHERE username = ? AND id != ? LIMIT 1");
                $checkStmt->bind_param("si", $username, $creatorId);
                $checkStmt->execute();
                $checkRes = $checkStmt->get_result();
                if ($checkRes->num_rows == 0) {
                    $checkStmt->close();
                    break;
                }
                $checkStmt->close();
                $username = $baseUsername . "_" . rand(1000, 9999);
            }

            // Update
            $updateStmt = $conn->prepare("UPDATE blog_creators SET username = ? WHERE id = ?");
            $updateStmt->bind_param("si", $username, $creatorId);
            $updateStmt->execute();
            $updateStmt->close();
        }
    }

    // 6. Create blog_reports table if not exists
    try {
        $conn->query("CREATE TABLE IF NOT EXISTS blog_reports (
            id INT AUTO_INCREMENT PRIMARY KEY,
            blog_id INT NOT NULL,
            user_email VARCHAR(255) NULL,
            report_notes TEXT NOT NULL,
            status VARCHAR(20) DEFAULT 'pending',
            email_sent INT DEFAULT 0,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (blog_id) REFERENCES blog_posts(id) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");
    } catch (Throwable $e) {
        error_log("Failed to create blog_reports table: " . $e->getMessage());
    }

    // 6b. Create generic reports table for articles, comments, and profiles
    try {
        $conn->query("CREATE TABLE IF NOT EXISTS reports (
            id INT AUTO_INCREMENT PRIMARY KEY,
            target_type ENUM('article', 'comment', 'profile') NOT NULL,
            blog_id INT DEFAULT NULL,
            comment_id INT DEFAULT NULL,
            target_identifier VARCHAR(255) DEFAULT NULL,
            reporter_email VARCHAR(255) NOT NULL,
            reported_user_email VARCHAR(255) DEFAULT NULL,
            reported_user_name VARCHAR(255) DEFAULT NULL,
            report_notes TEXT NOT NULL,
            status VARCHAR(20) DEFAULT 'pending',
            email_sent TINYINT(1) DEFAULT 0,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (blog_id) REFERENCES blog_posts(id) ON DELETE SET NULL,
            INDEX idx_reporter_target (reporter_email, reported_user_email, created_at)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");
    } catch (Throwable $e) {
        error_log("Failed to create reports table: " . $e->getMessage());
    }

    // 7. Create/Update blog_advertisements table (Allowing multiple ads per slot)
    try {
        $conn->query("CREATE TABLE IF NOT EXISTS blog_advertisements (
            id INT AUTO_INCREMENT PRIMARY KEY,
            slot_name VARCHAR(50) NOT NULL,
            image_url VARCHAR(255) NOT NULL,
            link_url VARCHAR(255) NOT NULL,
            alt_text VARCHAR(255) DEFAULT '',
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");
        
        // Drop unique constraint if table already existed with UNIQUE on slot_name
        $conn->query("ALTER TABLE blog_advertisements DROP INDEX slot_name");
        
        // Clean up legacy database rows with backend/ prefixes
        $conn->query("UPDATE blog_advertisements SET image_url = REPLACE(image_url, 'backend/uploads/', 'uploads/') WHERE image_url LIKE 'backend/uploads/%'");
    } catch (Throwable $e) {
        // Ignore if index drop fails
    }

    // 8. Create API keys table for developer access
    try {
        $conn->query("CREATE TABLE IF NOT EXISTS api_keys (
            id INT AUTO_INCREMENT PRIMARY KEY,
            api_key VARCHAR(64) NOT NULL UNIQUE,
            creator_email VARCHAR(255) NOT NULL,
            creator_name VARCHAR(255) NOT NULL,
            description TEXT DEFAULT NULL,
            is_active TINYINT(1) DEFAULT 1,
            requests_count INT DEFAULT 0,
            last_used_at TIMESTAMP NULL DEFAULT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            FOREIGN KEY (creator_email) REFERENCES blog_creators(email) ON DELETE CASCADE,
            INDEX idx_creator_email (creator_email),
            INDEX idx_api_key (api_key)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");
    } catch (Throwable $e) {
        error_log("Failed to create api_keys table: " . $e->getMessage());
    }

    // 9. Create API usage logs table
    try {
        $conn->query("CREATE TABLE IF NOT EXISTS api_usage_logs (
            id INT AUTO_INCREMENT PRIMARY KEY,
            api_key_id INT NOT NULL,
            endpoint VARCHAR(255) NOT NULL,
            method VARCHAR(10) NOT NULL,
            query_params TEXT DEFAULT NULL,
            response_status INT DEFAULT 200,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (api_key_id) REFERENCES api_keys(id) ON DELETE CASCADE,
            INDEX idx_api_key_id (api_key_id),
            INDEX idx_created_at (created_at)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");
    } catch (Throwable $e) {
        error_log("Failed to create api_usage_logs table: " . $e->getMessage());
    }
}
?>
