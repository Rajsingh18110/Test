START TRANSACTION;

DROP TABLE IF EXISTS blog_analytics;
ALTER TABLE blog_posts DROP INDEX idx_trending;
ALTER TABLE blog_posts DROP COLUMN trending_score;

COMMIT;
