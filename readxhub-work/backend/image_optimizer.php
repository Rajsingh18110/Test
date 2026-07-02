<?php
/**
 * Image Optimizer Class
 * Handles secure upload, MIME validation, format conversion, and responsive sizing.
 */
class ImageOptimizer {
    private $uploadDir;
    private $allowedMimeTypes = ['image/jpeg', 'image/png', 'image/webp', 'image/gif', 'image/svg+xml', 'image/avif', 'image/bmp'];
    private $maxFileSize = 5242880; // 5MB
    
    public function __construct($uploadDir = __DIR__ . '/uploads/media/') {
        $this->uploadDir = rtrim($uploadDir, '/') . '/';
        if (!is_dir($this->uploadDir)) {
            mkdir($this->uploadDir, 0755, true);
        }
    }

    /**
     * Process an uploaded file from $_FILES
     */
    public function processUpload($fileArray) {
        if ($fileArray['error'] !== UPLOAD_ERR_OK) {
            throw new Exception("Upload error code: " . $fileArray['error']);
        }
        
        if ($fileArray['size'] > $this->maxFileSize) {
            throw new Exception("File too large. Max 5MB.");
        }

        $tmpPath = $fileArray['tmp_name'];
        $originalName = basename($fileArray['name']);
        
        // Secure MIME check using finfo
        $finfo = finfo_open(FILEINFO_MIME_TYPE);
        $mime = finfo_file($finfo, $tmpPath);
        finfo_close($finfo);
        
        if (!in_array($mime, $this->allowedMimeTypes)) {
            throw new Exception("Invalid file type: $mime");
        }

        // Generate unique hash
        $hash = md5_file($tmpPath) . '_' . time();
        $ext = $this->getExtensionFromMime($mime);
        
        // If SVG, just move it and return (no resizing needed)
        if ($mime === 'image/svg+xml') {
            $dest = $this->uploadDir . $hash . '.svg';
            if (!move_uploaded_file($tmpPath, $dest)) {
                throw new Exception("Failed to move uploaded SVG.");
            }
            return [
                'original' => $this->getRelativePath($dest),
                'large' => null,
                'medium' => null,
                'thumb' => null,
                'mime' => $mime,
                'hash' => $hash,
                'original_name' => $originalName
            ];
        }

        // Determine best modern format (AVIF > WEBP > Original)
        $outputFormat = 'webp';
        $outputExt = 'webp';
        
        if (extension_loaded('imagick')) {
            $imagick = new Imagick();
            if (in_array('AVIF', $imagick->queryFormats())) {
                $outputFormat = 'avif';
                $outputExt = 'avif';
            }
        }

        $originalPath = $this->uploadDir . $hash . '_original.' . $ext;
        if (!move_uploaded_file($tmpPath, $originalPath)) {
            $errorMsg = "Failed to move uploaded file from $tmpPath to $originalPath. ";
            $errorMsg .= "Upload dir exists: " . (is_dir($this->uploadDir) ? 'Yes' : 'No') . ". ";
            $errorMsg .= "Upload dir writable: " . (is_writable($this->uploadDir) ? 'Yes' : 'No') . ".";
            throw new Exception($errorMsg);
        }

        // Generate sizes - the user requested we disable multiple file generation to "fix" it
        // We will now only keep the original optimized file.
        /*
        try {
            $largePath = $this->resizeImage($originalPath, $hash . '_large', 1200, $outputFormat);
            $mediumPath = $this->resizeImage($originalPath, $hash . '_medium', 800, $outputFormat);
            $thumbPath = $this->resizeImage($originalPath, $hash . '_thumb', 300, $outputFormat);
        } catch (Exception $e) {
            @unlink($originalPath);
            throw $e;
        }
        */

        return [
            'original' => $this->getRelativePath($originalPath),
            'large' => null,
            'medium' => null,
            'thumb' => null,
            'mime' => $mime,
            'hash' => $hash,
            'original_name' => $originalName
        ];
    }

    private function resizeImage($sourcePath, $basename, $maxWidth, $outputFormat) {
        $destPath = $this->uploadDir . $basename . '.' . $outputFormat;
        
        if (extension_loaded('imagick')) {
            return $this->resizeWithImagick($sourcePath, $destPath, $maxWidth, $outputFormat);
        } else {
            return $this->resizeWithGD($sourcePath, $destPath, $maxWidth, $outputFormat);
        }
    }

    private function resizeWithImagick($source, $dest, $maxWidth, $format) {
        $image = new Imagick($source);
        $width = $image->getImageWidth();
        $height = $image->getImageHeight();
        
        if ($width > $maxWidth) {
            $image->thumbnailImage($maxWidth, 0, false);
        }
        
        $image->setImageFormat($format);
        if ($format === 'webp' || $format === 'avif') {
            $image->setImageCompressionQuality(80);
        }
        
        $image->writeImage($dest);
        $image->clear();
        $image->destroy();
        
        return $dest;
    }

    private function resizeWithGD($source, $dest, $maxWidth, $format) {
        $info = getimagesize($source);
        if (!$info) throw new Exception("Invalid image.");
        $width = $info[0];
        $height = $info[1];
        
        if ($width > $maxWidth) {
            $newWidth = $maxWidth;
            $newHeight = (int)(($height / $width) * $maxWidth);
        } else {
            $newWidth = $width;
            $newHeight = $height;
        }

        $newImage = imagecreatetruecolor($newWidth, $newHeight);
        
        // Preserve transparency
        imagealphablending($newImage, false);
        imagesavealpha($newImage, true);
        $transparent = imagecolorallocatealpha($newImage, 255, 255, 255, 127);
        imagefilledrectangle($newImage, 0, 0, $newWidth, $newHeight, $transparent);

        $sourceImage = null;
        switch ($info[2]) {
            case IMAGETYPE_JPEG: $sourceImage = imagecreatefromjpeg($source); break;
            case IMAGETYPE_PNG: $sourceImage = imagecreatefrompng($source); break;
            case IMAGETYPE_WEBP: $sourceImage = imagecreatefromwebp($source); break;
            case IMAGETYPE_GIF: $sourceImage = imagecreatefromgif($source); break;
        }

        if (!$sourceImage) throw new Exception("Unsupported image type for GD.");

        imagecopyresampled($newImage, $sourceImage, 0, 0, 0, 0, $newWidth, $newHeight, $width, $height);

        // GD does not support AVIF natively in older versions. Fallback to WebP.
        if (function_exists('imagewebp')) {
            $dest = preg_replace('/\.\w+$/', '.webp', $dest);
            imagewebp($newImage, $dest, 80);
        } else {
            // Fallback to JPEG if WebP isn't supported
            $dest = preg_replace('/\.\w+$/', '.jpg', $dest);
            imagejpeg($newImage, $dest, 80);
        }

        imagedestroy($newImage);
        imagedestroy($sourceImage);
        
        return $dest;
    }

    private function getExtensionFromMime($mime) {
        $map = [
            'image/jpeg' => 'jpg',
            'image/png' => 'png',
            'image/webp' => 'webp',
            'image/gif' => 'gif'
        ];
        return $map[$mime] ?? 'jpg';
    }

    private function getRelativePath($absPath) {
        // Return a path relative to the root URL
        // If the path contains '/uploads/media/', we extract from there
        $pos = strpos($absPath, '/uploads/media/');
        if ($pos !== false) {
            return substr($absPath, $pos + 1); // returns "uploads/media/xyz.webp"
        }
        // Fallback
        return 'uploads/media/' . basename($absPath);
    }
}
?>
