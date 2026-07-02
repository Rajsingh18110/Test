START TRANSACTION;

-- 1. Create Media Uploads Table (Future-proofing for galleries)
CREATE TABLE IF NOT EXISTS media_uploads (
    id INT AUTO_INCREMENT PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    original_name VARCHAR(255) NOT NULL,
    mime_type VARCHAR(50) NOT NULL,
    file_size INT NOT NULL,
    width INT DEFAULT NULL,
    height INT DEFAULT NULL,
    hash VARCHAR(255) NOT NULL UNIQUE,
    uploader_email VARCHAR(255) NOT NULL,
    usage_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Create Redirects Table
CREATE TABLE IF NOT EXISTS slug_redirects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    blog_id INT NOT NULL,
    old_slug VARCHAR(255) NOT NULL UNIQUE,
    new_slug VARCHAR(255) NOT NULL,
    redirect_type INT DEFAULT 301,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (blog_id) REFERENCES blog_posts(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Expand blog_posts with new features
ALTER TABLE blog_posts 
    ADD COLUMN status ENUM('draft', 'scheduled', 'published', 'archived', 'private') DEFAULT 'published' AFTER email,
    ADD COLUMN featured_image VARCHAR(255) DEFAULT NULL AFTER status,
    ADD COLUMN featured_image_thumb VARCHAR(255) DEFAULT NULL AFTER featured_image,
    ADD COLUMN featured_image_medium VARCHAR(255) DEFAULT NULL AFTER featured_image_thumb,
    ADD COLUMN featured_image_large VARCHAR(255) DEFAULT NULL AFTER featured_image_medium,
    ADD COLUMN image_alt VARCHAR(255) DEFAULT NULL AFTER featured_image_large,
    ADD COLUMN image_caption TEXT DEFAULT NULL AFTER image_alt,
    ADD COLUMN image_credit VARCHAR(255) DEFAULT NULL AFTER image_caption,
    ADD COLUMN mime_type VARCHAR(50) DEFAULT NULL AFTER image_credit,
    ADD COLUMN seo_title VARCHAR(255) DEFAULT NULL AFTER mime_type,
    ADD COLUMN seo_description TEXT DEFAULT NULL AFTER seo_title,
    ADD COLUMN focus_keyword VARCHAR(255) DEFAULT NULL AFTER seo_description,
    ADD COLUMN social_title VARCHAR(255) DEFAULT NULL AFTER focus_keyword,
    ADD COLUMN social_description TEXT DEFAULT NULL AFTER social_title,
    ADD COLUMN social_image VARCHAR(255) DEFAULT NULL AFTER social_description,
    ADD COLUMN canonical_url VARCHAR(255) DEFAULT NULL AFTER social_image,
    ADD COLUMN robots_override VARCHAR(50) DEFAULT NULL AFTER canonical_url,
    ADD COLUMN reading_time INT DEFAULT 0 AFTER robots_override,
    ADD COLUMN word_count INT DEFAULT 0 AFTER reading_time,
    ADD COLUMN publish_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP AFTER created_at;

-- 4. Add Performance Indexes
ALTER TABLE blog_posts ADD INDEX idx_status_created (status, created_at);
ALTER TABLE blog_posts ADD INDEX idx_author (author);

COMMIT;
