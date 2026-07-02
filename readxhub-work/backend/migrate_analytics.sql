START TRANSACTION;

-- 1. Create the new unified analytics table
CREATE TABLE IF NOT EXISTS blog_analytics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    blog_id INT NOT NULL,
    viewer_id VARCHAR(255) NOT NULL,
    user_email VARCHAR(255) NULL,
    ip_address VARCHAR(45) NOT NULL,
    user_agent TEXT,
    browser VARCHAR(50),
    operating_system VARCHAR(50),
    device_type VARCHAR(50),
    referrer VARCHAR(255),
    viewer_timezone VARCHAR(100),
    viewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_seen_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_blog_viewer (blog_id, viewer_id),
    INDEX idx_viewed_at (viewed_at),
    FOREIGN KEY (blog_id) REFERENCES blog_posts(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Add trending score column for the HackerNews algorithm
ALTER TABLE blog_posts ADD COLUMN trending_score DECIMAL(10,4) DEFAULT 0.0000;
ALTER TABLE blog_posts ADD INDEX idx_trending (trending_score);

-- 3. We do NOT drop the old blog_views immediately just in case, but it's deprecated.
-- The API will write purely to blog_analytics moving forward.

COMMIT;
