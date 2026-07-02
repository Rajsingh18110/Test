<?php
/**
 * Shared database bootstrap for backend endpoints.
 *
 * This file intentionally degrades gracefully when the database is unavailable
 * so the PHP endpoints return a structured error instead of crashing.
 */

$host = getenv('DB_HOST') ?: 'localhost';
$port = getenv('DB_PORT') ?: 3306;
$username = getenv('DB_USERNAME') ?: getenv('DB_USER') ?: '';
$password = getenv('DB_PASSWORD') ?: getenv('DB_PASS') ?: '';
$database = getenv('DB_NAME') ?: getenv('DB_DATABASE') ?: '';

$conn = null;

if (function_exists('mysqli_init')) {
    try {
        $conn = new mysqli($host, $username, $password, $database, (int) $port);
        if ($conn->connect_error) {
            error_log('Getdatabase connection failed: ' . $conn->connect_error);
            $conn = null;
        } else {
            $conn->set_charset('utf8mb4');
        }
    } catch (Throwable $e) {
        error_log('Getdatabase connection exception: ' . $e->getMessage());
        $conn = null;
    }
} else {
    error_log('Getdatabase: mysqli extension is not available.');
}
