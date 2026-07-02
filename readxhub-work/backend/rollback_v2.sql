START TRANSACTION;

-- Remove columns from blog_posts
ALTER TABLE blog_posts 
    DROP COLUMN status,
    DROP COLUMN featured_image,
    DROP COLUMN featured_image_thumb,
    DROP COLUMN featured_image_medium,
    DROP COLUMN featured_image_large,
    DROP COLUMN image_alt,
    DROP COLUMN image_caption,
    DROP COLUMN image_credit,
    DROP COLUMN mime_type,
    DROP COLUMN seo_title,
    DROP COLUMN seo_description,
    DROP COLUMN focus_keyword,
    DROP COLUMN social_title,
    DROP COLUMN social_description,
    DROP COLUMN social_image,
    DROP COLUMN canonical_url,
    DROP COLUMN robots_override,
    DROP COLUMN reading_time,
    DROP COLUMN word_count,
    DROP COLUMN publish_date;

-- Remove Indexes
ALTER TABLE blog_posts DROP INDEX idx_status_created;
ALTER TABLE blog_posts DROP INDEX idx_author;

-- Drop new tables
DROP TABLE IF EXISTS slug_redirects;
DROP TABLE IF EXISTS media_uploads;

COMMIT;
