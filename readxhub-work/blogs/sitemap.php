<?php
header('Content-Type: application/xml; charset=utf-8');

$CANONICAL_HOST = 'readxhub.in';
$BACKEND_HOST = 'blogs.readxhub.in';
$API_BASE_URL = 'https://' . $BACKEND_HOST;

function xml_escape($value) {
    return htmlspecialchars((string) $value, ENT_XML1 | ENT_QUOTES, 'UTF-8');
}

function fetch_posts($url) {
    $response = false;
    if (ini_get('allow_url_fopen')) {
        $context = stream_context_create([
            'http' => [
                'method' => 'GET',
                'header' => "User-Agent: ReadXHub-Sitemap/2.0\r\nAccept: application/json\r\n",
                'timeout' => 8,
            ],
        ]);
        $response = @file_get_contents($url, false, $context);
    }

    if ($response === false && function_exists('curl_init')) {
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_USERAGENT, 'ReadXHub-Sitemap/2.0');
        curl_setopt($ch, CURLOPT_TIMEOUT, 8);
        $response = curl_exec($ch);
        curl_close($ch);
    }

    $data = $response ? json_decode($response, true) : [];
    return is_array($data) ? $data : [];
}

$posts = fetch_posts($API_BASE_URL . '/fetch_new_blogs.php?limit=1000');

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">' . "\n";

echo "  <url>\n";
echo '    <loc>https://' . $CANONICAL_HOST . "/</loc>\n";
echo '    <lastmod>' . date('Y-m-d') . "</lastmod>\n";
echo "    <changefreq>daily</changefreq>\n";
echo "    <priority>1.0</priority>\n";
echo "  </url>\n";

$staticPaths = ['/subscriptions', '/markdown-tutorial', '/about', '/contact', '/privacy-policy', '/terms-and-conditions'];
foreach ($staticPaths as $staticPath) {
    echo "  <url>\n";
    echo '    <loc>https://' . $CANONICAL_HOST . xml_escape($staticPath) . "</loc>\n";
    echo '    <lastmod>' . date('Y-m-d') . "</lastmod>\n";
    echo "    <changefreq>monthly</changefreq>\n";
    echo "    <priority>0.5</priority>\n";
    echo "  </url>\n";
}

foreach ($posts as $post) {
    if (($post['status'] ?? 'published') !== 'published') continue;
    if (empty($post['slug'])) continue;

    $dateSource = $post['updated_at'] ?? ($post['publish_date'] ?? ($post['created_at'] ?? 'now'));
    $lastmod = date('Y-m-d', strtotime($dateSource));
    $image = $post['featured_image_large'] ?? ($post['featured_image'] ?? '');
    $imageUrl = '';
    if ($image) {
        $imageUrl = preg_match('#^https?://#i', $image) ? $image : $API_BASE_URL . '/' . ltrim($image, '/');
    }

    echo "  <url>\n";
    echo '    <loc>https://' . $CANONICAL_HOST . '/blog/' . xml_escape($post['slug']) . "</loc>\n";
    echo '    <lastmod>' . xml_escape($lastmod) . "</lastmod>\n";
    echo "    <changefreq>weekly</changefreq>\n";
    echo "    <priority>0.8</priority>\n";
    if ($imageUrl) {
        echo "    <image:image>\n";
        echo '      <image:loc>' . xml_escape($imageUrl) . "</image:loc>\n";
        echo '      <image:title>' . xml_escape($post['image_alt'] ?? ($post['title'] ?? 'Article image')) . "</image:title>\n";
        echo "    </image:image>\n";
    }
    echo "  </url>\n";
}

echo '</urlset>';
