<?php
ob_start();
ini_set('display_errors', 0);
error_reporting(E_ALL);

// Load database connection & migration assistant
$conn = null;
$post = null;
$error_msg = null;

try {
    require('../Getdatabase.php');
    require('db_init.php');
    if ($conn) {
        initialize_database($conn);
    } else {
        $error_msg = "Database connection failed.";
    }
} catch (Exception $e) {
    $error_msg = "Error loading database: " . $e->getMessage();
}

$slug = isset($_GET['slug']) && !empty($_GET['slug']) ? trim($_GET['slug']) : null;

// Handle user logout action
if (isset($_GET['logout']) && $_GET['logout'] == 1) {
    setcookie('auth_token', '', time() - 3600, '/');
    $redirect_url = 'post.php' . ($slug ? '?slug=' . urlencode($slug) : '');
    header("Location: $redirect_url");
    exit();
}

if ($conn && $slug) {
    // Clean and validate slug input to prevent SQL Injection
    $slug = trim($slug);
    
    // Single query to fetch the post and its author details
    $sql = "SELECT p.id, p.title, p.description, p.keywords, p.author, p.content, p.created_at, p.slug, p.email, p.views,
                   p.featured_image, p.featured_image_large, p.image_alt, p.image_caption, p.image_credit,
                   c.name as creator_name, c.username, c.profile_picture, c.gender, c.bio, c.show_email, c.public_email
            FROM blog_posts p
            LEFT JOIN (
                SELECT email, name, username, profile_picture, gender, bio, show_email, public_email 
                FROM blog_creators gc
                WHERE gc.id = (SELECT MIN(id) FROM blog_creators WHERE email = gc.email)
            ) c ON p.email = c.email
            WHERE p.slug = ? LIMIT 1";
            
    $stmt = $conn->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("s", $slug);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result && $result->num_rows > 0) {
            $post = $result->fetch_assoc();
        }
        $stmt->close();
    }
    
    // Increment view count if post is found
    if ($post) {
        $updateViewsSql = "UPDATE blog_posts SET views = views + 1 WHERE id = ?";
        $updateStmt = $conn->prepare($updateViewsSql);
        if ($updateStmt) {
            $updateStmt->bind_param("i", $post['id']);
            $updateStmt->execute();
            $updateStmt->close();
            $post['views'] += 1;
        }
    }
}

// Fetch comments and structure them as a reply tree
$comments = [];
$comment_tree = [];
if ($conn && $post) {
    $comments_sql = "SELECT * FROM blogcomment WHERE blog_id = ? ORDER BY created_at ASC";
    $c_stmt = $conn->prepare($comments_sql);
    if ($c_stmt) {
        $c_stmt->bind_param("i", $post['id']);
        $c_stmt->execute();
        $c_result = $c_stmt->get_result();
        while ($row = $c_result->fetch_assoc()) {
            $comments[] = $row;
        }
        $c_stmt->close();
    }
    
    // Group replies into their parents
    $replies_by_parent = [];
    foreach ($comments as $c) {
        if (empty($c['parent_id'])) {
            $comment_tree[$c['id']] = $c;
            $comment_tree[$c['id']]['replies'] = [];
        } else {
            $replies_by_parent[$c['parent_id']][] = $c;
        }
    }
    
    foreach ($replies_by_parent as $parentId => $reps) {
        if (isset($comment_tree[$parentId])) {
            $comment_tree[$parentId]['replies'] = $reps;
        } else {
            foreach ($reps as $rep) {
                $comment_tree[$rep['id']] = $rep;
                $comment_tree[$rep['id']]['replies'] = [];
            }
        }
    }
}

// Fetch logged in session user details if cookie exists
$logged_in_user = null;
if ($conn && isset($_COOKIE['auth_token']) && !empty($_COOKIE['auth_token'])) {
    $logged_email = trim($_COOKIE['auth_token']);
    $u_stmt = $conn->prepare("SELECT name, username, profile_picture, gender FROM blog_creators WHERE email = ? LIMIT 1");
    if ($u_stmt) {
        $u_stmt->bind_param("s", $logged_email);
        $u_stmt->execute();
        $u_result = $u_stmt->get_result();
        if ($u_result && $u_result->num_rows > 0) {
            $logged_in_user = $u_result->fetch_assoc();
            $logged_in_user['email'] = $logged_email;
        }
        $u_stmt->close();
    }
}

if ($conn) {
    $conn->close();
}

// Formatting post attributes
$title = $post ? htmlspecialchars($post['title']) : "Post Not Found";
$meta_desc = $post ? htmlspecialchars($post['description']) : "Explore high-quality articles, guides and insights about web development, cybersecurity, AI and modern technology.";
$meta_keywords = $post ? htmlspecialchars($post['keywords']) : "technology articles, cybersecurity, AI, web development, coding, programming";
$author_name = $post ? htmlspecialchars($post['creator_name'] ?? $post['author']) : "Unknown Creator";
$created_at = $post ? date("M d, Y", strtotime($post['created_at'])) : "";
$views = $post ? intval($post['views']) : 0;
$slug_url = $post ? "https://readxhub.in/blogs/post.php?slug=" . urlencode($post['slug']) : "";

// Calculate Reading Time (WPM = 180, including image/video embeds)
$reading_time = 1;
if ($post) {
    $content = $post['content'];
    // Strip HTML tags
    $clean_content = strip_tags($content);
    
    // Count markdown images like ![alt](url)
    $image_count = preg_match_all('/!\[.*?\]\(.*?\)/', $content, $matches);
    // Remove images from content before counting words
    $clean_content = preg_replace('/!\[.*?\]\(.*?\)/', '', $clean_content);
    
    // Count YouTube embeds like [youtube:ID]
    $video_count = preg_match_all('/\[youtube:[^\]]+\]/', $content, $matches);
    // Remove video embeds from content before counting words
    $clean_content = preg_replace('/\[youtube:[^\]]+\]/', '', $clean_content);
    
    // Split by any sequence of whitespace characters (handles UTF-8 and punctuation correctly)
    $words = preg_split('/\s+/', trim($clean_content));
    $word_count = empty($words[0]) ? 0 : count($words);
    
    // Reading speed: 180 words per minute
    $wpm = 180;
    $time = $word_count / $wpm;
    
    // Add time for images (Medium algorithm: 12s for 1st, 11s for 2nd, etc. down to 3s)
    $image_time = 0;
    if ($image_count > 0) {
        $first_image_time = 12;
        for ($i = 0; $i < $image_count; $i++) {
            $image_time += max(3, $first_image_time - $i) / 60; // in minutes
        }
    }
    
    // Add time for videos (60s per video embed)
    $video_time = $video_count * 1.0; // 1 minute per video
    
    $total_time = ceil($time + $image_time + $video_time);
    $reading_time = max(1, (int)$total_time);
}

// Gender-specific color gradient fallback for avatars
$avatar_gradient = 'from-cyan-500 to-blue-600';
if ($post) {
    $gender = strtolower(trim($post['gender'] ?? ''));
    if ($gender === 'female') {
        $avatar_gradient = 'from-pink-500 to-rose-600';
    } else if ($gender === 'trans') {
        $avatar_gradient = 'from-purple-500 to-indigo-600';
    }
}

// XSS Sanitizer for rendering raw HTML body safely
function sanitize_html($content) {
    // Remove scripts
    $content = preg_replace('/<script\b[^>]*>(.*?)<\/script>/is', '', $content);
    // Remove inline events
    $content = preg_replace('/on\w+\s*=\s*(["\'])(.*?)\1/is', '', $content);
    // Remove javascript: links
    $content = preg_replace('/href\s*=\s*(["\'])\s*javascript:(.*?)\1/is', 'href="#"', $content);
    return $content;
}

// clean buffering
ob_end_clean();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Title & SEO Metadata -->
    <title><?php echo $title; ?> | ReadXHub</title>
    <meta name="description" content="<?php echo $meta_desc; ?>">
    <meta name="keywords" content="<?php echo $meta_keywords; ?>">
    <meta name="author" content="<?php echo $author_name; ?>">
    
    <!-- Open Graph tags for Social Sharing -->
    <meta property="og:title" content="<?php echo $title; ?> | ReadXHub">
    <meta property="og:description" content="<?php echo $meta_desc; ?>">
    <meta property="og:type" content="article">
    <meta property="og:url" content="<?php echo $slug_url; ?>">
    <meta property="og:site_name" content="ReadXHub">
    <?php if (!empty($post['featured_image_large']) || !empty($post['featured_image'])): ?>
    <meta property="og:image" content="https://blogs.readxhub.in/<?php echo htmlspecialchars($post['featured_image_large'] ?? $post['featured_image']); ?>">
    <?php endif; ?>
    
    <!-- Twitter Cards -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="<?php echo $title; ?> | ReadXHub">
    <meta name="twitter:description" content="<?php echo $meta_desc; ?>">
    <?php if (!empty($post['featured_image_large']) || !empty($post['featured_image'])): ?>
    <meta name="twitter:image" content="https://blogs.readxhub.in/<?php echo htmlspecialchars($post['featured_image_large'] ?? $post['featured_image']); ?>">
    <?php endif; ?>

    <!-- Canonical URL -->
    <link rel="canonical" href="<?php echo $slug_url; ?>">
    
    <!-- Fonts & Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Outfit:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Tailwind CSS CDN & Config -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        slate: {
                            950: '#030712',
                            850: '#111827',
                            350: '#cbd5e1'
                        }
                    },
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                        outfit: ['Outfit', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    
    <!-- PrismJS Syntax Highlighting Theme (Tomorrow Night) -->
    <link href="https://cdn.jsdelivr.net/npm/prismjs@1.29.0/themes/prism-tomorrow.min.css" rel="stylesheet">

    <!-- Premium Custom Styles -->
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #030712;
            color: #f1f5f9;
        }
        
        /* Reading Scroll Progress bar */
        #progress-bar {
            position: fixed;
            top: 0;
            left: 0;
            height: 3px;
            background: linear-gradient(to right, #06b6d4, #3b82f6);
            width: 0%;
            z-index: 100;
            transition: width 0.1s ease-out;
        }

        /* Markdown / Post Body Styling */
        .custom-markdown-styles {
            line-height: 1.8;
            color: #cbd5e1;
        }

        .custom-markdown-styles h1 {
            font-size: 2rem;
            font-weight: 800;
            color: #ffffff;
            margin-top: 2rem;
            margin-bottom: 1rem;
            letter-spacing: -0.025em;
            font-family: 'Outfit', sans-serif;
        }

        .custom-markdown-styles h2 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #ffffff;
            margin-top: 1.75rem;
            margin-bottom: 0.75rem;
            letter-spacing: -0.02em;
            font-family: 'Outfit', sans-serif;
        }

        .custom-markdown-styles h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: #ffffff;
            margin-top: 1.5rem;
            margin-bottom: 0.5rem;
            font-family: 'Outfit', sans-serif;
        }

        .custom-markdown-styles p {
            margin-top: 0;
            margin-bottom: 1.25rem;
        }

        .custom-markdown-styles a {
            color: #06b6d4;
            text-decoration: none;
            font-weight: 500;
            border-bottom: 1px solid transparent;
            transition: border-color 0.2s;
        }

        .custom-markdown-styles a:hover {
            border-color: #06b6d4;
        }

        .custom-markdown-styles ul {
            list-style-type: disc;
            margin-top: 0;
            margin-bottom: 1.25rem;
            padding-left: 1.5rem;
        }

        .custom-markdown-styles ol {
            list-style-type: decimal;
            margin-top: 0;
            margin-bottom: 1.25rem;
            padding-left: 1.5rem;
        }

        .custom-markdown-styles li {
            margin-top: 0.25rem;
            margin-bottom: 0.25rem;
        }

        .custom-markdown-styles blockquote {
            margin: 1.5rem 0;
            padding-left: 1.25rem;
            border-left: 4px solid #06b6d4;
            color: #94a3b8;
            font-style: italic;
        }

        .custom-markdown-styles pre {
            background-color: #0f172a;
            border: 1px solid #1e293b;
            border-radius: 12px;
            padding: 1rem;
            overflow-x: auto;
            margin: 1.5rem 0;
        }

        .custom-markdown-styles code {
            font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
            font-size: 0.9em;
            background-color: #1e293b;
            color: #e2e8f0;
            padding: 0.2rem 0.4rem;
            border-radius: 6px;
        }

        .custom-markdown-styles pre code {
            background-color: transparent;
            color: inherit;
            padding: 0;
            border-radius: 0;
        }
    </style>
</head>
<body class="min-h-screen flex flex-col justify-between selection:bg-cyan-500/30 selection:text-cyan-400">

    <!-- Scroll Progress Indicator -->
    <div id="progress-bar"></div>

    <!-- Header Navigation -->
    <nav class="sticky top-0 z-50 bg-[#030712]/80 backdrop-blur-md border-b border-slate-800/80 shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                
                <!-- Brand Logo -->
                <div class="flex-shrink-0">
                    <a href="./" class="flex items-center gap-2 group">
                        <div class="w-9 h-9 rounded-xl bg-gradient-to-tr from-cyan-500 to-blue-600 flex items-center justify-center text-white shadow-md shadow-cyan-500/20 group-hover:scale-105 transition-transform duration-300">
                            <i class="fa-solid fa-globe text-base"></i>
                        </div>
                        <span class="text-xl font-extrabold tracking-tight bg-gradient-to-r from-white via-slate-100 to-slate-300 bg-clip-text text-transparent font-outfit">
                            ReadXHub
                        </span>
                    </a>
                </div>

                <!-- Navigation Controls -->
                <div class="flex items-center gap-4">
                    <a href="./" class="flex items-center gap-1.5 px-3.5 py-2 rounded-xl text-xs font-semibold text-slate-400 hover:text-white hover:bg-slate-900/50 transition-all">
                        <i class="fa-solid fa-house"></i> Home
                    </a>

                    <!-- User authentication indicator / dynamic navigation -->
                    <?php if ($logged_in_user): ?>
                        <div class="relative flex items-center gap-3 pl-3 border-l border-slate-800">
                            <?php if (!empty($logged_in_user['profile_picture'])): ?>
                                <img src="<?php echo htmlspecialchars($logged_in_user['profile_picture']); ?>" alt="User Avatar" class="w-8 h-8 rounded-full object-cover border border-slate-700" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                            <?php endif; ?>
                            <div class="<?php echo !empty($logged_in_user['profile_picture']) ? 'hidden' : 'flex'; ?> w-8 h-8 rounded-full bg-slate-800 border border-slate-700 items-center justify-center text-slate-350 font-bold text-xs uppercase shadow-inner">
                                <?php echo strtoupper(substr($logged_in_user['name'], 0, 1)); ?>
                            </div>
                            <span class="hidden md:inline text-xs font-medium text-slate-300">
                                <?php echo htmlspecialchars($logged_in_user['name']); ?>
                            </span>
                            <a href="?logout=1&slug=<?php echo urlencode($slug ?? ''); ?>" title="Logout" class="text-slate-500 hover:text-red-400 transition-colors text-xs pl-1">
                                <i class="fa-solid fa-sign-out-alt"></i>
                            </a>
                        </div>
                    <?php else: ?>
                        <a href="./#/login" class="flex items-center gap-1.5 px-3.5 py-2 rounded-xl text-xs font-semibold text-cyan-400 border border-cyan-500/20 hover:border-cyan-500/40 hover:bg-cyan-500/5 transition-all">
                            <i class="fa-solid fa-sign-in-alt"></i> Login
                        </a>
                    <?php endif; ?>
                </div>

            </div>
        </div>
    </nav>

    <!-- Main Content Panel -->
    <?php if ($post): ?>
        <main class="flex-grow max-w-4xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-10 relative">
            
            <!-- Glow aesthetic backgrounds -->
            <div class="absolute top-20 left-1/4 w-96 h-96 bg-cyan-500/5 rounded-full blur-3xl -z-10 pointer-events-none"></div>
            <div class="absolute bottom-40 right-1/4 w-96 h-96 bg-blue-500/5 rounded-full blur-3xl -z-10 pointer-events-none"></div>
            
            <!-- Back navigation link -->
            <a href="./" class="inline-flex items-center gap-1.5 text-xs text-slate-500 hover:text-cyan-400 transition-colors mb-6 font-semibold">
                <i class="fa-solid fa-arrow-left"></i> Back to feed
            </a>

            <!-- Google AdSense Top Ad slot -->
            <div class="bg-slate-900/20 border border-dashed border-slate-800/80 rounded-2xl py-4 mb-8 text-center text-[10px] text-slate-500 uppercase tracking-widest font-bold shadow-inner pointer-events-none select-none">
                Advertisement: Top Banner Ad Slot
            </div>

            <!-- Blog Post Container -->
            <article class="bg-slate-900/40 border border-slate-800/80 rounded-3xl p-6 md:p-10 shadow-2xl backdrop-blur-sm">
                
                <header class="space-y-6">
                    <!-- Badges -->
                    <?php if (!empty($post['keywords'])): ?>
                        <div class="flex flex-wrap gap-2">
                            <?php 
                            $tags = explode(',', $post['keywords']);
                            foreach ($tags as $tag): 
                                $tag = trim($tag);
                                if (!empty($tag)):
                            ?>
                                <span class="border border-cyan-500/20 text-cyan-400 text-[10px] uppercase font-bold tracking-wider px-2.5 py-1 rounded-lg bg-cyan-500/5">
                                    <?php echo htmlspecialchars($tag); ?>
                                </span>
                            <?php 
                                endif;
                            endforeach; 
                            ?>
                        </div>
                    <?php endif; ?>

                    <!-- Title -->
                    <h1 class="text-3xl md:text-4xl font-extrabold text-white tracking-tight leading-tight font-outfit">
                        <?php echo htmlspecialchars($post['title']); ?>
                    </h1>

                    <!-- Description/Subtitle -->
                    <?php if (!empty($post['description'])): ?>
                        <p class="text-slate-400 text-sm md:text-base font-medium leading-relaxed max-w-3xl">
                            <?php echo htmlspecialchars($post['description']); ?>
                        </p>
                    <?php endif; ?>

                    <!-- Author and Metadata -->
                    <div class="flex flex-wrap gap-6 items-center text-xs text-slate-500 border-t border-b border-slate-800/60 py-4">
                        
                        <!-- Profile Card -->
                        <div class="flex items-center gap-3">
                            <?php if (!empty($post['profile_picture'])): ?>
                                <div class="relative w-10 h-10 flex-shrink-0">
                                    <img src="<?php echo htmlspecialchars($post['profile_picture']); ?>" alt="<?php echo $author_name; ?>" class="w-10 h-10 rounded-full object-cover border border-slate-700 shadow-md" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                    <div class="hidden w-10 h-10 rounded-full bg-gradient-to-tr <?php echo $avatar_gradient; ?> items-center justify-center text-white font-bold text-sm border border-slate-700 shadow-md flex-shrink-0">
                                        <?php echo strtoupper(substr($author_name, 0, 1)); ?>
                                    </div>
                                </div>
                            <?php else: ?>
                                <div class="w-10 h-10 rounded-full bg-gradient-to-tr <?php echo $avatar_gradient; ?> flex items-center justify-center text-white font-bold text-sm border border-slate-700 shadow-md flex-shrink-0">
                                    <?php echo strtoupper(substr($author_name, 0, 1)); ?>
                                </div>
                            <?php endif; ?>

                            <div class="flex flex-col">
                                <span class="text-slate-400 text-[10px] uppercase font-bold tracking-wider">Written by</span>
                                <a href="./#/author/<?php echo urlencode($post['username'] ?? $post['email']); ?>" class="text-slate-200 hover:text-cyan-400 hover:underline font-bold transition-colors">
                                    <?php echo $author_name; ?>
                                </a>
                            </div>
                        </div>

                        <!-- Date & Time -->
                        <div class="flex items-center gap-2">
                            <i class="fa-regular fa-calendar text-cyan-500"></i>
                            <span><?php echo $created_at; ?></span>
                        </div>

                        <!-- Reading Time -->
                        <div class="flex items-center gap-2">
                            <i class="fa-regular fa-clock text-cyan-500"></i>
                            <span><?php echo $reading_time; ?> min read</span>
                        </div>

                        <!-- Views -->
                        <div class="flex items-center gap-2">
                            <i class="fa-regular fa-eye text-cyan-500"></i>
                            <span><?php echo number_format($views); ?> views</span>
                        </div>
                    </div>
                </header>

                <!-- Featured Image -->
                <?php if (!empty($post['featured_image_large']) || !empty($post['featured_image'])): ?>
                    <figure class="my-8 w-full rounded-2xl overflow-hidden shadow-2xl border border-slate-800 bg-slate-900/50">
                        <img src="/<?php echo htmlspecialchars($post['featured_image_large'] ?? $post['featured_image']); ?>" alt="<?php echo htmlspecialchars($post['image_alt'] ?? $post['title']); ?>" class="w-full h-auto object-cover max-h-[600px]" />
                        <?php if (!empty($post['image_caption'])): ?>
                            <figcaption class="text-center text-xs text-slate-500 mt-3 pb-3 italic">
                                <?php echo htmlspecialchars($post['image_caption']); ?>
                                <?php if (!empty($post['image_credit'])): ?>
                                    <span class="block text-[10px] text-slate-600 mt-1">Credit: <?php echo htmlspecialchars($post['image_credit']); ?></span>
                                <?php endif; ?>
                            </figcaption>
                        <?php endif; ?>
                    </figure>
                <?php endif; ?>

                <!-- Social Sharing Horizontal Widget -->
                <div class="flex items-center gap-3 my-6">
                    <span class="text-slate-500 text-[10px] uppercase font-bold tracking-wider mr-2">Share:</span>
                    <a href="https://twitter.com/intent/tweet?text=<?php echo urlencode($post['title']); ?>&url=<?php echo urlencode($slug_url); ?>" target="_blank" title="Share on Twitter / X" class="w-8 h-8 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 hover:text-white flex items-center justify-center transition-colors">
                        <i class="fa-brands fa-x-twitter text-sm"></i>
                    </a>
                    <a href="https://www.linkedin.com/sharing/share-offsite/?url=<?php echo urlencode($slug_url); ?>" target="_blank" title="Share on LinkedIn" class="w-8 h-8 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 hover:text-white flex items-center justify-center transition-colors">
                        <i class="fa-brands fa-linkedin-in text-sm"></i>
                    </a>
                    <a href="https://api.whatsapp.com/send?text=<?php echo urlencode($post['title'] . ' - ' . $slug_url); ?>" target="_blank" title="Share on WhatsApp" class="w-8 h-8 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 hover:text-white flex items-center justify-center transition-colors">
                        <i class="fa-brands fa-whatsapp text-sm"></i>
                    </a>
                    <button onclick="copyToClipboard(this, '<?php echo $slug_url; ?>')" title="Copy link" class="w-8 h-8 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 hover:text-white flex items-center justify-center transition-colors relative">
                        <i class="fa-regular fa-copy text-sm"></i>
                    </button>
                </div>

                <!-- Main Post Content Body -->
                <div id="markdown-content" class="custom-markdown-styles text-slate-350 leading-relaxed text-sm md:text-base space-y-6 pt-6 border-t border-slate-800/40 hidden">
                    <?php echo sanitize_html($post['content']); ?>
                </div>
                <div id="parsed-content" class="custom-markdown-styles text-slate-350 leading-relaxed text-sm md:text-base space-y-6 pt-6 border-t border-slate-800/40"></div>

                <!-- Google AdSense Bottom Ad slot -->
                <div class="bg-slate-900/20 border border-dashed border-slate-800/80 rounded-2xl py-4 mt-10 mb-6 text-center text-[10px] text-slate-500 uppercase tracking-widest font-bold shadow-inner pointer-events-none select-none">
                    Advertisement: Footer Banner Ad Slot
                </div>

                <!-- Subscription newsletter sign-up card -->
                <div class="mt-12 bg-gradient-to-tr from-slate-900/80 to-slate-950/80 border border-slate-800/80 rounded-2xl p-6 md:p-8 relative overflow-hidden shadow-xl">
                    <div class="absolute -right-10 -bottom-10 w-40 h-40 bg-cyan-500/10 rounded-full blur-3xl pointer-events-none"></div>
                    <div class="relative space-y-4">
                        <div class="space-y-1.5">
                            <h3 class="text-xl font-bold text-white font-outfit">Subscribe to <?php echo $author_name; ?>'s newsletter</h3>
                            <p class="text-slate-400 text-xs md:text-sm">Get high-quality technology articles, guides, and updates delivered straight to your inbox.</p>
                        </div>
                        
                        <?php if ($logged_in_user && strcasecmp($logged_in_user['email'], $post['email']) === 0): ?>
                            <!-- Creator view of their own subscribe block -->
                            <div class="inline-flex items-center gap-2 bg-slate-950/40 border border-slate-800 rounded-xl px-4 py-2 text-xs text-slate-500 font-semibold cursor-default">
                                <i class="fa-solid fa-info-circle text-cyan-400"></i> You are viewing your own publication card.
                            </div>
                        <?php else: ?>
                            <!-- Subscription Action Form -->
                            <form onsubmit="handleSubscribe(event, '<?php echo htmlspecialchars($post['email']); ?>')" class="flex flex-col sm:flex-row gap-3">
                                <?php if ($logged_in_user): ?>
                                    <button type="submit" class="px-6 py-2.5 bg-gradient-to-tr from-cyan-500 to-blue-600 hover:scale-[1.02] active:scale-[0.98] text-white rounded-xl text-xs md:text-sm font-semibold shadow-md transition-transform flex items-center justify-center gap-1.5">
                                        <i class="fa-solid fa-paper-plane"></i> Subscribe with 1-Click as <?php echo htmlspecialchars($logged_in_user['email']); ?>
                                    </button>
                                <?php else: ?>
                                    <input 
                                        type="email" 
                                        name="email" 
                                        required 
                                        placeholder="Enter your email address" 
                                        class="flex-grow bg-slate-950/60 border border-slate-800 rounded-xl px-4 py-2.5 text-xs md:text-sm text-slate-200 placeholder-slate-650 focus:border-cyan-500/40 focus:outline-none transition-colors"
                                    />
                                    <button type="submit" class="px-6 py-2.5 bg-gradient-to-tr from-cyan-500 to-blue-600 hover:scale-[1.02] active:scale-[0.98] text-white rounded-xl text-xs md:text-sm font-semibold shadow-md transition-transform flex items-center justify-center gap-1">
                                        Subscribe
                                    </button>
                                <?php endif; ?>
                            </form>
                            <div id="subscribe-status" class="mt-3 text-xs hidden"></div>
                        <?php endif; ?>
                    </div>
                </div>

                <!-- Discussion & Comments Section -->
                <div class="mt-12 pt-10 border-t border-slate-800/60 space-y-8">
                    <h3 class="text-xl font-bold text-white font-outfit flex items-center gap-2">
                        <i class="fa-regular fa-comments text-cyan-500"></i> Discussion 
                        <span class="text-xs bg-slate-800 text-slate-400 font-semibold px-2 py-0.5 rounded-full"><?php echo count($comments); ?></span>
                    </h3>

                    <!-- Add Comment form block -->
                    <div class="bg-slate-950/40 border border-slate-900 rounded-2xl p-5 space-y-4">
                        <span class="text-xs font-bold text-slate-400 uppercase tracking-wider">Join the conversation</span>
                        <form onsubmit="handleCommentSubmit(event, <?php echo $post['id']; ?>)" class="space-y-4">
                            <?php if (!$logged_in_user): ?>
                                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                                    <input type="text" name="name" required placeholder="Your Name" class="bg-slate-900/60 border border-slate-800/80 rounded-xl px-4 py-2 text-xs md:text-sm text-slate-200 focus:border-cyan-500/40 focus:outline-none placeholder-slate-650 transition-colors" />
                                    <input type="email" name="email" required placeholder="Your Email" class="bg-slate-900/60 border border-slate-800/80 rounded-xl px-4 py-2 text-xs md:text-sm text-slate-200 focus:border-cyan-500/40 focus:outline-none placeholder-slate-650 transition-colors" />
                                </div>
                            <?php else: ?>
                                <div class="text-xs text-slate-500 font-semibold flex items-center gap-1.5">
                                    <i class="fa-solid fa-user-circle text-cyan-400"></i> Commenting as <span class="text-slate-350"><?php echo htmlspecialchars($logged_in_user['name']); ?> (<?php echo htmlspecialchars($logged_in_user['email']); ?>)</span>
                                </div>
                            <?php endif; ?>

                            <textarea name="comment" required placeholder="Write a thoughtful comment..." rows="3" class="w-full bg-slate-900/60 border border-slate-800/80 rounded-xl p-4 text-xs md:text-sm text-slate-200 placeholder-slate-650 focus:border-cyan-500/40 focus:outline-none transition-colors"></textarea>
                            <div class="flex justify-end">
                                <button type="submit" class="px-5 py-2 bg-slate-800 hover:bg-slate-700 text-slate-200 rounded-xl text-xs md:text-sm font-semibold transition-colors flex items-center gap-1">
                                    Post Comment
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Comments Thread List -->
                    <div class="space-y-6">
                        <?php if (empty($comment_tree)): ?>
                            <div class="text-center py-8 text-slate-550 border border-dashed border-slate-850 rounded-2xl space-y-1.5 select-none">
                                <i class="fa-regular fa-comment-dots text-2xl text-slate-600"></i>
                                <p class="text-xs text-slate-500 font-semibold">No comments yet. Be the first to start the discussion!</p>
                            </div>
                        <?php else: ?>
                            <?php foreach ($comment_tree as $commentId => $c): 
                                $c_author = htmlspecialchars($c['user_name']);
                                $c_text = nl2br(htmlspecialchars($c['text']));
                                $c_date = date("M d, Y • h:i A", strtotime($c['created_at']));
                                $c_avatar = htmlspecialchars($c['profile_picture_url']);
                            ?>
                                <!-- Parent Comment Item -->
                                <div class="bg-slate-900/20 border border-slate-850/60 rounded-2xl p-5 space-y-3 shadow-inner">
                                    <div class="flex justify-between items-center">
                                        <div class="flex items-center gap-3">
                                            <?php if (!empty($c_avatar)): ?>
                                                <img src="<?php echo $c_avatar; ?>" alt="Commenter Avatar" class="w-8 h-8 rounded-full object-cover border border-slate-800" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                            <?php endif; ?>
                                            <div class="<?php echo !empty($c_avatar) ? 'hidden' : 'flex'; ?> w-8 h-8 rounded-full bg-slate-800 border border-slate-700 items-center justify-center text-slate-350 font-bold text-xs uppercase shadow-sm">
                                                <?php echo strtoupper(substr($c_author, 0, 1)); ?>
                                            </div>
                                            <div class="flex flex-col">
                                                <span class="text-xs font-semibold text-slate-200"><?php echo $c_author; ?></span>
                                                <span class="text-[10px] text-slate-500"><?php echo $c_date; ?></span>
                                            </div>
                                        </div>
                                        <button onclick="toggleReplyForm(<?php echo $commentId; ?>)" class="text-slate-500 hover:text-cyan-400 transition-colors text-xs font-semibold flex items-center gap-1">
                                            <i class="fa-solid fa-reply"></i> Reply
                                        </button>
                                    </div>
                                    <p class="text-xs md:text-sm text-slate-300 leading-relaxed pl-11">
                                        <?php echo $c_text; ?>
                                    </p>

                                    <!-- Reply box form (toggled) -->
                                    <div id="reply-form-<?php echo $commentId; ?>" class="hidden ml-11 pt-3 bg-slate-950/20 border-t border-slate-850/40 mt-3">
                                        <form onsubmit="handleCommentSubmit(event, <?php echo $post['id']; ?>, <?php echo $commentId; ?>)" class="space-y-3">
                                            <?php if (!$logged_in_user): ?>
                                                <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                                                    <input type="text" name="name" required placeholder="Name" class="bg-slate-900/60 border border-slate-800/80 rounded-lg px-3 py-1.5 text-xs text-slate-200 placeholder-slate-650 focus:border-cyan-500/40 focus:outline-none transition-colors" />
                                                    <input type="email" name="email" required placeholder="Email" class="bg-slate-900/60 border border-slate-800/80 rounded-lg px-3 py-1.5 text-xs text-slate-200 placeholder-slate-650 focus:border-cyan-500/40 focus:outline-none transition-colors" />
                                                </div>
                                            <?php endif; ?>
                                            <textarea name="comment" required placeholder="Write a reply..." rows="2" class="w-full bg-slate-900/60 border border-slate-800/80 rounded-lg p-3 text-xs text-slate-200 placeholder-slate-650 focus:border-cyan-500/40 focus:outline-none transition-colors"></textarea>
                                            <div class="flex justify-end gap-2">
                                                <button type="button" onclick="toggleReplyForm(<?php echo $commentId; ?>)" class="px-3.5 py-1.5 bg-slate-900 hover:bg-slate-850 text-slate-400 rounded-lg text-xs font-semibold transition-colors">
                                                    Cancel
                                                </button>
                                                <button type="submit" class="px-4 py-1.5 bg-slate-800 hover:bg-slate-700 text-slate-200 rounded-lg text-xs font-semibold transition-colors">
                                                    Submit Reply
                                                </button>
                                            </div>
                                        </form>
                                    </div>

                                    <!-- Render nested replies -->
                                    <?php if (!empty($c['replies'])): ?>
                                        <div class="space-y-4 pl-6 border-l-2 border-slate-800/60 ml-4 mt-4">
                                            <?php foreach ($c['replies'] as $rep): 
                                                $r_author = htmlspecialchars($rep['user_name']);
                                                $r_text = nl2br(htmlspecialchars($rep['text']));
                                                $r_date = date("M d, Y • h:i A", strtotime($rep['created_at']));
                                                $r_avatar = htmlspecialchars($rep['profile_picture_url']);
                                            ?>
                                                <div class="space-y-2">
                                                    <div class="flex items-center gap-3">
                                                        <?php if (!empty($r_avatar)): ?>
                                                            <img src="<?php echo $r_avatar; ?>" alt="Replier Avatar" class="w-7 h-7 rounded-full object-cover border border-slate-800" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                                        <?php endif; ?>
                                                        <div class="<?php echo !empty($r_avatar) ? 'hidden' : 'flex'; ?> w-7 h-7 rounded-full bg-slate-850 border border-slate-700 items-center justify-center text-slate-400 font-bold text-[10px] uppercase shadow-sm">
                                                            <?php echo strtoupper(substr($r_author, 0, 1)); ?>
                                                        </div>
                                                        <div class="flex flex-col">
                                                            <span class="text-xs font-semibold text-slate-300"><?php echo $r_author; ?></span>
                                                            <span class="text-[9px] text-slate-500"><?php echo $r_date; ?></span>
                                                        </div>
                                                    </div>
                                                    <p class="text-xs text-slate-355 leading-relaxed pl-10">
                                                        <?php echo $r_text; ?>
                                                    </p>
                                                </div>
                                            <?php endforeach; ?>
                                        </div>
                                    <?php endif; ?>

                                </div>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </div>

                </div>

            </article>

        </main>
    <?php else: ?>
        <!-- Beautifully Styled 404 block for missing slug/article -->
        <main class="flex-grow flex items-center justify-center px-4 py-20 relative">
            <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-80 h-80 bg-cyan-500/5 rounded-full blur-3xl pointer-events-none"></div>
            
            <div class="max-w-md w-full text-center space-y-6 bg-slate-900/40 border border-slate-800/80 rounded-3xl p-8 backdrop-blur-md shadow-2xl relative overflow-hidden">
                <div class="w-16 h-16 bg-red-500/10 border border-red-500/20 rounded-2xl flex items-center justify-center mx-auto text-red-400 text-2xl animate-bounce">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                </div>
                
                <div class="space-y-2">
                    <h1 class="text-2xl md:text-3xl font-extrabold text-white font-outfit tracking-tight">Article Not Found</h1>
                    <p class="text-slate-400 text-xs md:text-sm">The article slug provided could not be loaded. It may have been deleted, renamed, or is temporarily offline.</p>
                </div>
                
                <div class="pt-4 flex flex-col sm:flex-row gap-3 justify-center">
                    <a href="./" class="px-5 py-2.5 bg-gradient-to-tr from-cyan-500 to-blue-600 text-white rounded-xl text-xs md:text-sm font-semibold shadow-md shadow-cyan-500/15 hover:scale-[1.02] active:scale-[0.98] transition-all flex items-center justify-center gap-1.5">
                        <i class="fa-solid fa-arrow-left"></i> Back to Homepage
                    </a>
                </div>
            </div>
        </main>
    <?php endif; ?>

    <!-- Rebranded premium footer -->
    <footer class="border-t border-slate-900/80 bg-[#070b16] py-8 text-center text-xs text-slate-500 select-none">
        <div class="max-w-7xl mx-auto px-4 space-y-3">
            <p>&copy; 2026 <span class="text-slate-400 font-bold">ReadXHub</span>. All rights reserved.</p>
            <p class="text-[10px] text-slate-600">A premium technology publication, knowledge hub, and article sharing platform.</p>
        </div>
    </footer>

    <!-- PrismJS script packages for high contrast syntax rendering -->
    <script src="https://cdn.jsdelivr.net/npm/prismjs@1.29.0/prism.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/prismjs@1.29.0/components/prism-markup-templating.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/prismjs@1.29.0/components/prism-php.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
    
    <script>
        // Parse Markdown
        document.addEventListener("DOMContentLoaded", () => {
            const rawMarkdown = document.getElementById('markdown-content').innerHTML;
            const parsedHtml = marked.parse(rawMarkdown);
            document.getElementById('parsed-content').innerHTML = parsedHtml;
            // Apply syntax highlighting
            Prism.highlightAll();
        });

        // Reading scroll tracker indicator logic
        window.addEventListener('scroll', () => {
            const winScroll = document.body.scrollTop || document.documentElement.scrollTop;
            const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
            const scrolled = height > 0 ? (winScroll / height) * 100 : 0;
            document.getElementById('progress-bar').style.width = scrolled + '%';
        });

        // Copy link to clipboards trigger
        function copyToClipboard(button, text) {
            navigator.clipboard.writeText(text).then(() => {
                const originalHtml = button.innerHTML;
                button.innerHTML = '<i class="fa-solid fa-check text-emerald-400"></i>';
                
                const tooltip = document.createElement('span');
                tooltip.className = "absolute -top-9 left-1/2 -translate-x-1/2 bg-slate-800 text-slate-200 text-[10px] px-2.5 py-1 rounded-lg shadow-lg font-bold border border-slate-700 pointer-events-none transition-opacity";
                tooltip.innerText = "Copied!";
                button.style.position = "relative";
                button.appendChild(tooltip);
                
                setTimeout(() => {
                    button.innerHTML = originalHtml;
                    tooltip.remove();
                }, 2000);
            }).catch(err => {
                console.error('Failed to copy: ', err);
            });
        }

        // Newsletter sign up AJAX pipeline
        async function handleSubscribe(event, creatorEmail) {
            event.preventDefault();
            const form = event.target;
            const emailInput = form.querySelector('input[name="email"]');
            const email = emailInput ? emailInput.value.trim() : '<?php echo $logged_in_user ? htmlspecialchars($logged_in_user['email']) : ""; ?>';
            const statusDiv = document.getElementById('subscribe-status');
            const submitBtn = form.querySelector('button[type="submit"]');

            if (!email) return;

            submitBtn.disabled = true;
            const originalBtnHtml = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin mr-1.5"></i> Subscribing...';
            statusDiv.className = "mt-3 text-xs hidden";

            try {
                const response = await fetch('subscribe.php', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        action: 'subscribe',
                        creator_identifier: creatorEmail,
                        subscriber_email: email
                    })
                });
                
                const data = await response.json();
                
                if (response.ok && data.success) {
                    statusDiv.innerHTML = '<span class="text-emerald-400 font-semibold"><i class="fa-solid fa-circle-check mr-1.5"></i> ' + (data.message || 'Subscribed successfully!') + '</span>';
                    statusDiv.classList.remove('hidden');
                    if (emailInput) emailInput.value = '';
                    
                    submitBtn.innerHTML = '<i class="fa-solid fa-check mr-1"></i> Subscribed!';
                    submitBtn.className = "px-6 py-2.5 bg-emerald-600 text-white rounded-xl text-xs md:text-sm font-semibold shadow-md cursor-default";
                } else {
                    statusDiv.innerHTML = '<span class="text-rose-400 font-semibold"><i class="fa-solid fa-circle-xmark mr-1.5"></i> ' + (data.error || 'Failed to subscribe.') + '</span>';
                    statusDiv.classList.remove('hidden');
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = originalBtnHtml;
                }
            } catch (err) {
                statusDiv.innerHTML = '<span class="text-rose-400 font-semibold"><i class="fa-solid fa-circle-xmark mr-1.5"></i> Network error. Try again.</span>';
                statusDiv.classList.remove('hidden');
                submitBtn.disabled = false;
                submitBtn.innerHTML = originalBtnHtml;
            }
        }

        // Nested comments reply block toggler
        function toggleReplyForm(commentId) {
            const form = document.getElementById('reply-form-' + commentId);
            if (form.classList.contains('hidden')) {
                form.classList.remove('hidden');
                form.querySelector('textarea').focus();
            } else {
                form.classList.add('hidden');
            }
        }

        // Add Comment/Reply AJAX pipelines
        async function handleCommentSubmit(event, blogId, parentId = null) {
            event.preventDefault();
            const form = event.target;
            const textEl = form.querySelector('textarea');
            const text = textEl.value.trim();
            if (!text) return;

            const nameEl = form.querySelector('input[name="name"]');
            const emailEl = form.querySelector('input[name="email"]');
            
            const user_name = nameEl ? nameEl.value.trim() : <?php echo json_encode($logged_in_user['name'] ?? ''); ?>;
            const user_email = emailEl ? emailEl.value.trim() : <?php echo json_encode($logged_in_user['email'] ?? ''); ?>;
            const profile_picture_url = <?php echo json_encode($logged_in_user['profile_picture'] ?? ''); ?>;

            if (!user_name || !user_email) {
                alert("Please provide your name and email to comment.");
                return;
            }

            const submitBtn = form.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin mr-1"></i> Posting...';

            try {
                const response = await fetch('blogcomment_api.php', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        blog_id: blogId,
                        text: text,
                        user_email: user_email,
                        user_name: user_name,
                        profile_picture_url: profile_picture_url,
                        parent_id: parentId
                    })
                });
                
                const data = await response.json();
                
                if (response.ok && data.status === "success") {
                    // Refresh is the most robust way to draw the comment in proper thread tree
                    window.location.reload();
                } else {
                    alert(data.error || "Failed to post comment.");
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = originalText;
                }
            } catch (err) {
                alert("Network error. Please try again.");
                submitBtn.disabled = false;
                submitBtn.innerHTML = originalText;
            }
        }
    </script>

</body>
</html>
