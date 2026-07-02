<?php
// test.php - no require, just file checks
// Upload to blogs.readxhub.in root → visit blogs.readxhub.in/test.php
// DELETE after use!

ini_set('display_errors', 1);
error_reporting(E_ALL);
header("Content-Type: text/plain; charset=UTF-8");

echo "=== PHP INFO ===\n";
echo "PHP Version: " . PHP_VERSION . "\n";
echo "Script location: " . __FILE__ . "\n";
echo "Current dir: " . __DIR__ . "\n";
echo "Parent dir: " . dirname(__DIR__) . "\n\n";

echo "=== FILE EXISTS CHECKS ===\n";
$files = [
    '../cors-handler.php',
    '../Getdatabase.php',
    'db_init.php',
    'get_subscriptions.php',
    'debug_subs.php',
    'index.html',
];
foreach ($files as $f) {
    echo "$f → " . (file_exists($f) ? "EXISTS" : "MISSING") . "\n";
}

echo "\n=== FILES IN PARENT DIR (../) ===\n";
$parent = scandir('../');
foreach ($parent as $f) {
    if ($f === '.' || $f === '..') continue;
    $size = is_file('../' . $f) ? filesize('../' . $f) . ' bytes' : '[dir]';
    echo "  $f  $size\n";
}

echo "\n=== FILES IN CURRENT DIR (.) ===\n";
$cur = scandir('.');
foreach ($cur as $f) {
    if ($f === '.' || $f === '..') continue;
    $size = is_file($f) ? filesize($f) . ' bytes' : '[dir]';
    echo "  $f  $size\n";
}

echo "\n=== CORS-HANDLER CONTENT (first 20 lines) ===\n";
if (file_exists('../cors-handler.php')) {
    $lines = file('../cors-handler.php');
    foreach (array_slice($lines, 0, 20) as $i => $line) {
        echo ($i+1) . ": " . $line;
    }
} else {
    echo "FILE NOT FOUND at ../cors-handler.php\n";
}

echo "\n\n=== GET_SUBSCRIPTIONS.PHP (first 20 lines on server) ===\n";
if (file_exists('get_subscriptions.php')) {
    $lines = file('get_subscriptions.php');
    foreach (array_slice($lines, 0, 20) as $i => $line) {
        echo ($i+1) . ": " . $line;
    }
} else {
    echo "FILE NOT FOUND\n";
}
?>
