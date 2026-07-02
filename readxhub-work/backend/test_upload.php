<?php
$uploadDir = __DIR__ . '/uploads/media/';
echo "Dir: " . $uploadDir . "\n";
echo "Exists: " . (is_dir($uploadDir) ? "Yes" : "No") . "\n";
