-- ReadXHub v3 migration
-- Adds: comment voting, article revision history, and karma support.
-- Safe to run once; uses IF NOT EXISTS guards where MySQL supports them.

-- 1) Comment voting (Reddit-style upvote/downvote on individual comments)
CREATE TABLE IF NOT EXISTS `comment_votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_id` int(11) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `vote` tinyint(1) NOT NULL COMMENT '1 = upvote, -1 = downvote',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_comment_user` (`comment_id`, `user_email`),
  KEY `idx_comment_id` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2) Article revision history (Wikipedia-style edit history)
CREATE TABLE IF NOT EXISTS `blog_revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blog_id` int(11) NOT NULL,
  `title` text DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `edited_by_email` varchar(255) DEFAULT NULL,
  `edited_by_name` varchar(255) DEFAULT NULL,
  `edit_summary` varchar(500) DEFAULT NULL COMMENT 'short note describing what changed',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_blog_id` (`blog_id`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3) Karma ledger (denormalized, fast lookups for author/user reputation)
CREATE TABLE IF NOT EXISTS `user_karma` (
  `user_email` varchar(255) NOT NULL,
  `post_karma` int(11) NOT NULL DEFAULT 0,
  `comment_karma` int(11) NOT NULL DEFAULT 0,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
