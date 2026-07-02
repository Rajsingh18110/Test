<?php
header('Content-Type: text/plain; charset=utf-8');

$host = 'readxhub.in';

echo "User-agent: *\n";
echo "Allow: /\n";
echo "Disallow: /dashboard\n";
echo "Disallow: /createapost\n";
echo "Disallow: /edit/\n";
echo "Disallow: /profile\n";
echo "Disallow: /*?*auth_token=\n\n";
echo "Sitemap: https://$host/sitemap.xml\n";
echo "Host: $host\n";
