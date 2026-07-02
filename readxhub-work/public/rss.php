<?php
header('Content-Type: application/rss+xml; charset=utf-8');

$CANONICAL_HOST = 'readxhub.in';
$BACKEND_HOST = 'blogs.readxhub.in';
$API_BASE_URL = 'https://' . $BACKEND_HOST;
$SITE_NAME = 'ReadXHub';
$SITE_DESCRIPTION = 'Technical articles, secure coding guides, AI notes, web development tutorials, and practical engineering resources.';

function rss_escape($value) {
    return htmlspecialchars((string) $value, ENT_XML1 | ENT_QUOTES, 'UTF-8');
}

function rss_excerpt($html, $length = 220) {
    $text = trim(preg_replace('/\s+/', ' ', html_entity_decode(strip_tags((string) $html), ENT_QUOTES, 'UTF-8')));
    if (function_exists('mb_substr')) {
        return mb_strlen($text) > $length ? mb_substr($text, 0, $length - 3) . '...' : $text;
    }
    return strlen($text) > $length ? substr($text, 0, $length - 3) . '...' : $text;
}

function fetch_posts($url) {
    $response = false;
    if (ini_get('allow_url_fopen')) {
        $context = stream_context_create([
            'http' => [
                'method' => 'GET',
                'header' => "User-Agent: ReadXHub-RSS/2.0\r\nAccept: application/json\r\n",
                'timeout' => 8,
            ],
        ]);
        $response = @file_get_contents($url, false, $context);
    }

    if ($response === false && function_exists('curl_init')) {
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_USERAGENT, 'ReadXHub-RSS/2.0');
        curl_setopt($ch, CURLOPT_TIMEOUT, 8);
        $response = curl_exec($ch);
        curl_close($ch);
    }

    $data = $response ? json_decode($response, true) : [];
    return is_array($data) ? $data : [];
}

$posts = fetch_posts($API_BASE_URL . '/fetch_new_blogs.php?limit=50');

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
echo '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:media="http://search.yahoo.com/mrss/">' . "\n";
echo "  <channel>\n";
echo '    <title>' . rss_escape($SITE_NAME) . "</title>\n";
echo '    <link>https://' . $CANONICAL_HOST . "/</link>\n";
echo '    <description>' . rss_escape($SITE_DESCRIPTION) . "</description>\n";
echo "    <language>en-us</language>\n";
echo '    <lastBuildDate>' . date(DATE_RSS) . "</lastBuildDate>\n";
echo '    <atom:link href="https://' . $CANONICAL_HOST . '/rss.xml" rel="self" type="application/rss+xml" />' . "\n";

foreach ($posts as $post) {
    if (($post['status'] ?? 'published') !== 'published') continue;
    if (empty($post['slug'])) continue;

    $title = $post['seo_title'] ?: ($post['title'] ?? 'ReadXHub Article');
    $link = 'https://' . $CANONICAL_HOST . '/blog/' . $post['slug'];
    $description = $post['seo_description'] ?: ($post['description'] ?: rss_excerpt($post['content'] ?? ''));
    $dateSource = $post['publish_date'] ?? ($post['created_at'] ?? 'now');
    $author = $post['author_name'] ?? ($post['author'] ?? $SITE_NAME);
    $image = $post['featured_image_large'] ?? ($post['featured_image'] ?? '');
    $imageUrl = '';
    if ($image) {
        $imageUrl = preg_match('#^https?://#i', $image) ? $image : $API_BASE_URL . '/' . ltrim($image, '/');
    }

    echo "    <item>\n";
    echo '      <title>' . rss_escape($title) . "</title>\n";
    echo '      <link>' . rss_escape($link) . "</link>\n";
    echo '      <guid isPermaLink="true">' . rss_escape($link) . "</guid>\n";
    echo '      <description>' . rss_escape($description) . "</description>\n";
    echo '      <pubDate>' . date(DATE_RSS, strtotime($dateSource)) . "</pubDate>\n";
    echo '      <author>noreply@readxhub.in (' . rss_escape($author) . ")</author>\n";
    if ($imageUrl) {
        echo '      <media:content url="' . rss_escape($imageUrl) . "\" medium=\"image\" />\n";
    }
    echo "    </item>\n";
}

echo "  </channel>\n";
echo '</rss>';
