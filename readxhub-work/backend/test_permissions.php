<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$dir = __DIR__ . '/../uploads/media/';
echo "Dir: " . $dir . "\n";
if (!is_dir($dir)) {
    echo "Creating dir...\n";
    if (!mkdir($dir, 0755, true)) {
        echo "Failed to create dir.\n";
    } else {
        echo "Created dir.\n";
    }
} else {
    echo "Dir exists.\n";
}

if (is_writable($dir)) {
    echo "Dir is writable.\n";
    $testFile = $dir . 'test.txt';
    if (file_put_contents($testFile, 'test')) {
        echo "Successfully wrote to dir.\n";
        unlink($testFile);
    } else {
        echo "Failed to write to dir.\n";
    }
} else {
    echo "Dir is NOT writable.\n";
}
