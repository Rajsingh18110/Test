<?php
$CANONICAL_HOST = 'readxhub.in';
$BACKEND_HOST = 'blogs.readxhub.in';
$SITE_NAME = 'ReadXHub';
$SITE_DESCRIPTION = 'Technical articles, secure coding guides, AI notes, web development tutorials, and practical engineering resources.';
$API_BASE_URL = 'https://' . $BACKEND_HOST;

$host = $_SERVER['HTTP_HOST'] ?? $CANONICAL_HOST;
$requestUri = $_SERVER['REQUEST_URI'] ?? '/';
$path = parse_url($requestUri, PHP_URL_PATH) ?: '/';
$query = parse_url($requestUri, PHP_URL_QUERY);
$canonicalPath = preg_replace('#^/blogs#', '', $path) ?: '/';
$canonicalUrl = 'https://' . $CANONICAL_HOST . $canonicalPath . ($query ? '?' . $query : '');

if (strcasecmp($host, $CANONICAL_HOST) !== 0 || $canonicalPath !== $path) {
    header('Location: ' . $canonicalUrl, true, 301);
    exit;
}

function e($value) {
    return htmlspecialchars((string) $value, ENT_QUOTES, 'UTF-8');
}

function absolute_url($path, $baseHost = 'blogs.readxhub.in') {
    if (!$path) return 'https://readxhub.in/logo.png';
    if (preg_match('#^https?://#i', $path)) return $path;
    return 'https://' . $baseHost . '/' . ltrim($path, '/');
}

function public_url_from_existing($url, $fallbackPath = '/') {
    $path = parse_url((string) $url, PHP_URL_PATH);
    $query = parse_url((string) $url, PHP_URL_QUERY);
    if (!$path) $path = $fallbackPath;
    return 'https://readxhub.in' . $path . ($query ? '?' . $query : '');
}

function plain_text($html) {
    $html = preg_replace('/\[youtube:[^\]]+\]/', ' ', (string) $html);
    $html = preg_replace('/!\[[^\]]*\]\([^)]+\)/', ' ', $html);
    return trim(preg_replace('/\s+/', ' ', html_entity_decode(strip_tags($html), ENT_QUOTES, 'UTF-8')));
}

function excerpt($html, $length = 160) {
    $text = plain_text($html);
    if (function_exists('mb_substr')) {
        return mb_strlen($text) > $length ? mb_substr($text, 0, $length - 3) . '...' : $text;
    }
    return strlen($text) > $length ? substr($text, 0, $length - 3) . '...' : $text;
}

function fetch_json($url, $userAgent, $timeout = 5) {
    $response = false;
    if (ini_get('allow_url_fopen')) {
        $context = stream_context_create([
            'http' => [
                'method' => 'GET',
                'header' => "User-Agent: $userAgent\r\nAccept: application/json\r\n",
                'timeout' => $timeout,
            ],
        ]);
        $response = @file_get_contents($url, false, $context);
    }

    if ($response === false && function_exists('curl_init')) {
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_USERAGENT, $userAgent);
        curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);
        $response = curl_exec($ch);
        curl_close($ch);
    }

    $data = $response ? json_decode($response, true) : null;
    return is_array($data) ? $data : null;
}

function render_article_body($content) {
    $content = (string) $content;
    $content = preg_replace('/\[youtube:([a-zA-Z0-9_-]{11})\]/', '<p><a href="https://www.youtube.com/watch?v=$1">Watch embedded video</a></p>', $content);
    $content = preg_replace('/!\[([^\]]*)\]\(([^)]+)\)/', '<p><img src="$2" alt="$1"></p>', $content);

    if (preg_match('/<\s*(p|h1|h2|h3|ul|ol|blockquote|pre|img|table)\b/i', $content)) {
        $allowed = '<p><br><h1><h2><h3><h4><h5><h6><ul><ol><li><strong><b><em><i><a><blockquote><code><pre><img><figure><figcaption><table><thead><tbody><tr><th><td>';
        return strip_tags($content, $allowed);
    }

    $lines = preg_split('/\R{2,}/', trim($content));
    $html = '';
    foreach ($lines as $line) {
        $line = trim($line);
        if ($line === '') continue;
        if (preg_match('/^###\s+(.+)/', $line, $m)) {
            $html .= '<h3>' . e($m[1]) . '</h3>';
        } elseif (preg_match('/^##\s+(.+)/', $line, $m)) {
            $html .= '<h2>' . e($m[1]) . '</h2>';
        } elseif (preg_match('/^#\s+(.+)/', $line, $m)) {
            $html .= '<h1>' . e($m[1]) . '</h1>';
        } else {
            $html .= '<p>' . nl2br(e($line)) . '</p>';
        }
    }
    return $html;
}

function normalize_slug($slug) {
    return str_replace('explaination', 'explanation', strtolower($slug));
}

$isBlogRoute = preg_match('#^(?:/blogs)?/blog/([^/?]+)#', $path, $matches);
if ($isBlogRoute) {
    $requestedSlug = $matches[1];
    $normalizedSlug = normalize_slug($requestedSlug);
    if ($normalizedSlug !== $requestedSlug) {
        header('Location: https://' . $CANONICAL_HOST . '/blog/' . rawurlencode($normalizedSlug), true, 301);
        exit;
    }
}

$html = file_get_contents(__DIR__ . '/index.html');
if ($html === false) {
    http_response_code(500);
    echo 'Application shell not found.';
    exit;
}

$title = $SITE_NAME . ' | Technology, Development, AI & Cybersecurity Articles';
$description = $SITE_DESCRIPTION;
$keywords = 'technology articles, cybersecurity articles, AI articles, web development tutorials, programming guides, developer resources';
$image = 'https://' . $CANONICAL_HOST . '/logo.png';
$type = 'website';
$author = $SITE_NAME;
$publishedTime = '';
$modifiedTime = '';
$robots = 'index,follow,max-image-preview:large';
$structuredData = [
    '@context' => 'https://schema.org',
    '@type' => 'WebSite',
    'name' => $SITE_NAME,
    'url' => 'https://' . $CANONICAL_HOST . '/',
    'description' => $SITE_DESCRIPTION,
];
$fallbackMarkup = '<section class="seo-fallback"><h1>' . e($SITE_NAME) . '</h1><p>' . e($SITE_DESCRIPTION) . '</p></section>';

if ($isBlogRoute) {
    $slug = $matches[1];
    $blog = fetch_json($API_BASE_URL . '/fetch_single_blog_by_slug.php?slug=' . rawurlencode($slug), 'ReadXHub-SSR/2.0');

    if (isset($blog['redirect'])) {
        header('Location: https://' . $CANONICAL_HOST . $blog['redirect'], true, 301);
        exit;
    }

    if ($blog && !isset($blog['error'])) {
        $blogSlug = $blog['slug'] ?? $slug;
        $canonicalUrl = !empty($blog['canonical_url'])
            ? public_url_from_existing($blog['canonical_url'], '/blog/' . $blogSlug)
            : 'https://' . $CANONICAL_HOST . '/blog/' . $blogSlug;
        $title = $blog['seo_title'] ?: (($blog['title'] ?? 'Article') . ' | ' . $SITE_NAME);
        $description = $blog['seo_description'] ?: ($blog['description'] ?: excerpt($blog['content'] ?? ''));
        $keywords = trim($blog['keywords'] ?? '') ?: trim($blog['focus_keyword'] ?? '');
        $imageField = $blog['social_image'] ?: ($blog['featured_image_large'] ?: ($blog['featured_image'] ?? ''));
        $image = absolute_url($imageField, $BACKEND_HOST);
        $type = 'article';
        $author = $blog['author_name'] ?? ($blog['author'] ?? $SITE_NAME);
        $publishedTime = $blog['publish_date'] ?? ($blog['created_at'] ?? '');
        $modifiedTime = $blog['updated_at'] ?? ($blog['created_at'] ?? $publishedTime);
        $robots = !empty($blog['robots_override']) ? $blog['robots_override'] : $robots;

        $articleText = plain_text($blog['content'] ?? '');
        $structuredData = [
            '@context' => 'https://schema.org',
            '@type' => 'TechArticle',
            'mainEntityOfPage' => ['@type' => 'WebPage', '@id' => $canonicalUrl],
            'headline' => $blog['title'] ?? $title,
            'description' => $description,
            'image' => [$image],
            'datePublished' => $publishedTime,
            'dateModified' => $modifiedTime,
            'author' => ['@type' => 'Person', 'name' => $author],
            'publisher' => [
                '@type' => 'Organization',
                'name' => $SITE_NAME,
                'logo' => ['@type' => 'ImageObject', 'url' => 'https://' . $CANONICAL_HOST . '/logo.png'],
            ],
            'wordCount' => str_word_count($articleText),
            'articleBody' => $articleText,
        ];

        $related = fetch_json($API_BASE_URL . '/fetch_new_blogs.php?limit=6', 'ReadXHub-Related/2.0') ?: [];
        $relatedLinks = '';
        foreach ($related as $item) {
            if (($item['slug'] ?? '') === $blogSlug) continue;
            $relatedLinks .= '<li><a href="/blog/' . e($item['slug'] ?? '') . '">' . e($item['title'] ?? 'Related article') . '</a></li>';
        }

        $fallbackMarkup = '<article class="seo-fallback">'
            . '<header><p><a href="/">ReadXHub</a></p><h1>' . e($blog['title'] ?? $title) . '</h1>'
            . '<p>By ' . e($author) . ($publishedTime ? ' on <time datetime="' . e($publishedTime) . '">' . e(date('F j, Y', strtotime($publishedTime))) . '</time>' : '') . '</p>'
            . '<p>' . e($description) . '</p></header>'
            . (!empty($imageField) ? '<figure><img src="' . e($image) . '" alt="' . e($blog['image_alt'] ?? ($blog['title'] ?? $title)) . '"></figure>' : '')
            . '<div>' . render_article_body($blog['content'] ?? '') . '</div>'
            . ($relatedLinks ? '<nav aria-label="Related articles"><h2>Related Articles</h2><ul>' . $relatedLinks . '</ul></nav>' : '')
            . '</article>';
    } else {
        http_response_code(404);
        $title = 'Article not found | ' . $SITE_NAME;
        $description = 'This article could not be found on ReadXHub.';
        $robots = 'noindex,follow';
        $fallbackMarkup = '<section class="seo-fallback"><h1>Article not found</h1><p><a href="/">Return to latest articles</a></p></section>';
    }
} else {
    $posts = fetch_json($API_BASE_URL . '/fetch_new_blogs.php?limit=12', 'ReadXHub-HomeSSR/2.0') ?: [];
    if ($posts) {
        $items = '';
        foreach ($posts as $post) {
            $items .= '<li><a href="/blog/' . e($post['slug'] ?? '') . '">' . e($post['title'] ?? 'Article') . '</a><p>' . e($post['description'] ?? '') . '</p></li>';
        }
        $fallbackMarkup = '<section class="seo-fallback"><h1>' . e($SITE_NAME) . '</h1><p>' . e($SITE_DESCRIPTION) . '</p><h2>Latest Articles</h2><ul>' . $items . '</ul></section>';
    }
}

$head = "\n"
    . '<title>' . e($title) . "</title>\n"
    . '<meta name="description" content="' . e($description) . "\">\n"
    . ($keywords ? '<meta name="keywords" content="' . e($keywords) . "\">\n" : '')
    . '<meta name="robots" content="' . e($robots) . "\">\n"
    . '<meta name="googlebot" content="' . e($robots) . "\">\n"
    . '<link rel="canonical" href="' . e($canonicalUrl) . "\">\n"
    . '<link rel="alternate" type="application/rss+xml" title="' . e($SITE_NAME) . ' RSS" href="https://' . $CANONICAL_HOST . "/rss.xml\">\n"
    . '<meta property="og:type" content="' . e($type) . "\">\n"
    . '<meta property="og:title" content="' . e($title) . "\">\n"
    . '<meta property="og:description" content="' . e($description) . "\">\n"
    . '<meta property="og:url" content="' . e($canonicalUrl) . "\">\n"
    . '<meta property="og:image" content="' . e($image) . "\">\n"
    . '<meta property="og:site_name" content="' . e($SITE_NAME) . "\">\n"
    . '<meta name="twitter:card" content="summary_large_image">' . "\n"
    . '<meta name="twitter:title" content="' . e($title) . "\">\n"
    . '<meta name="twitter:description" content="' . e($description) . "\">\n"
    . '<meta name="twitter:image" content="' . e($image) . "\">\n";

if ($type === 'article') {
    $head .= '<meta property="article:author" content="' . e($author) . "\">\n";
    if ($publishedTime) $head .= '<meta property="article:published_time" content="' . e($publishedTime) . "\">\n";
    if ($modifiedTime) $head .= '<meta property="article:modified_time" content="' . e($modifiedTime) . "\">\n";
}

$head .= '<script type="application/ld+json">' . json_encode($structuredData, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE) . "</script>\n";
$head .= '<style>.seo-fallback{max-width:900px;margin:0 auto;padding:24px;color:#e5e7eb;background:#030712}.seo-fallback a{color:#22d3ee}.seo-fallback img{max-width:100%;height:auto}.seo-fallback p,.seo-fallback li{line-height:1.7}</style>' . "\n";

$html = preg_replace('/<title>.*?<\/title>/is', '', $html);
$html = preg_replace('/<meta\s+name=["\']description["\'][^>]*>\s*/i', '', $html);
$html = preg_replace('/<meta\s+name=["\']keywords["\'][^>]*>\s*/i', '', $html);
$html = str_replace('</head>', $head . '</head>', $html);
$html = str_replace('<div id="root"></div>', '<div id="root">' . $fallbackMarkup . '</div>', $html);

echo $html;
