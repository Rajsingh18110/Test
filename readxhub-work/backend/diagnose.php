<?php
header("Content-Type: text/html; charset=UTF-8");
error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "<!DOCTYPE html>
<html>
<head>
    <title>Server Diagnostics - ReadXHub</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #0b0f19; color: #cbd5e1; padding: 30px; margin: 0; }
        .card { background-color: #1e293b; border: 1px solid #334155; border-radius: 12px; padding: 24px; max-width: 800px; margin: 0 auto 20px auto; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); }
        h1 { color: #f8fafc; font-size: 24px; margin-top: 0; border-bottom: 1px solid #334155; padding-bottom: 12px; }
        h2 { color: #38bdf8; font-size: 18px; margin-top: 20px; }
        .success { color: #4ade80; font-weight: bold; }
        .warning { color: #fbbf24; font-weight: bold; }
        .danger { color: #f87171; font-weight: bold; }
        pre { background-color: #0f172a; padding: 12px; border-radius: 6px; overflow-x: auto; font-family: Consolas, monospace; border: 1px solid #1e293b; color: #94a3b8; }
        ul { padding-left: 20px; }
        li { margin-bottom: 8px; }
    </style>
</head>
<body>

<div class='card'>
    <h1>Server Diagnostic Report</h1>
    
    <h2>1. Script Location Info</h2>
    <ul>
        <li>Current Script Directory: <code>" . htmlspecialchars(__DIR__) . "</code></li>
        <li>Subdomain/Domain Document Root (from Server): <code>" . htmlspecialchars($_SERVER['DOCUMENT_ROOT']) . "</code></li>
    </ul>

    <h2>2. Directory Structure Check</h2>
    <p>Let's check where your build files are located relative to the root:</p>
    <ul>";

// Check subdomain root folder
$currentDir = __DIR__;
if (basename($currentDir) === 'backend') {
    $parentDir = dirname($currentDir);
} else {
    $parentDir = $currentDir;
}
echo "<li>Subdomain Root Directory: <code>" . htmlspecialchars($parentDir) . "</code>";

if (file_exists($parentDir . '/index.html')) {
    echo " <span class='success'>[FOUND index.html]</span> - Build files are uploaded directly to the root (Correct).";
} else {
    echo " <span class='warning'>[NO index.html]</span> - No index.html found directly at the root.";
}
echo "</li>";

// Check for nested blogs folder
$nestedBlogs = $parentDir . '/blogs';
echo "<li>Nested '/blogs' Directory: ";
if (is_dir($nestedBlogs)) {
    echo "<code>" . htmlspecialchars($nestedBlogs) . "</code> <span class='warning'>[FOUND /blogs directory]</span>";
    if (file_exists($nestedBlogs . '/index.html')) {
        echo " <span class='danger'>[WARNING: index.html is nested inside /blogs]</span><br/>
        <p class='danger'><b>Conflict Found:</b> You have uploaded the entire <code>blogs</code> folder inside your subdomain root instead of uploading just its contents. 
        Your website files are located at <code>https://blogs.readxhub.in/blogs/index.html</code>, but the browser is trying to load them from the root <code>https://blogs.readxhub.in/index.html</code>. 
        Because the root index.html is missing or is an old file, the server returns a 404 page (HTML) for JavaScript requests, leading to the <i>SyntaxError</i>.</p>";
    } else {
        echo " (Empty or no index.html inside).";
    }
} else {
    echo "<span class='success'>[OK: No nested /blogs directory]</span>";
}
echo "</li>";

echo "</ul>

    <h2>3. HTACCESS Configurations</h2>";

$htaccessFile = $parentDir . '/.htaccess';
if (file_exists($htaccessFile)) {
    echo "<p class='warning'>Found an .htaccess file in subdomain root. Here are its contents (check if it rewrites JS/CSS assets to index.html):</p>";
    echo "<pre>" . htmlspecialchars(file_get_contents($htaccessFile)) . "</pre>";
} else {
    echo "<p class='success'>No .htaccess file found in subdomain root.</p>";
}

echo "
    <h2>4. Actionable Steps to Fix</h2>
    <ul>
        <li><b>Step 1: Check how you upload.</b> Open your FTP client (like FileZilla) or Hostinger File Manager.</li>
        <li><b>Step 2: Clean the root folder.</b> Go into the directory for <code>blogs.readxhub.in</code> (usually a folder named <code>blogs.readxhub.in</code> or <code>public_html/blogs</code>). Delete any old folders/files there.</li>
        <li><b>Step 3: Upload files correctly.</b> Drag and drop the <b>contents</b> of your local <code>blogs</code> folder (the files: <code>index.html</code>, <code>favicon.ico</code>, <code>manifest.json</code> and the <code>assets</code> folder) AND the <b>contents</b> of your local <code>backend</code> folder (all the PHP files) directly into the root folder on the server. Do <b>NOT</b> upload the parent <code>blogs</code> or <code>backend</code> folders themselves. Everything should live in the same root folder.</li>
    </ul>
</div>

</body>
</html>";
?>
