import React, { useState, useRef, useCallback, useEffect } from 'react';
import { FaUpload, FaImage, FaTrash, FaCheckCircle, FaSpinner } from 'react-icons/fa';
import { getApiUrl } from '../utils/api';

const FeaturedImageUploader = ({ onUploadSuccess, currentImage }) => {
  const [isDragging, setIsDragging] = useState(false);
  const [isUploading, setIsUploading] = useState(false);
  const [preview, setPreview] = useState(currentImage || null);
  const [error, setError] = useState(null);
  
  const fileInputRef = useRef(null);

  useEffect(() => {
    if (currentImage && currentImage !== preview && !currentImage.startsWith('blob:')) {
      let fullUrl = currentImage;
      if (!currentImage.startsWith('http') && !currentImage.startsWith('data:')) {
        fullUrl = getApiUrl(currentImage.startsWith('/') ? currentImage.slice(1) : currentImage);
      }
      setPreview(fullUrl);
    }
  }, [currentImage]);

  const handleDragOver = useCallback((e) => {
    e.preventDefault();
    setIsDragging(true);
  }, []);

  const handleDragLeave = useCallback((e) => {
    e.preventDefault();
    setIsDragging(false);
  }, []);

  const handleDrop = useCallback((e) => {
    e.preventDefault();
    setIsDragging(false);
    
    if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
      uploadFile(e.dataTransfer.files[0]);
    }
  }, []);

  const handlePaste = useCallback((e) => {
    const items = e.clipboardData.items;
    for (let i = 0; i < items.length; i++) {
      if (items[i].type.indexOf('image') !== -1) {
        const file = items[i].getAsFile();
        uploadFile(file);
        break;
      }
    }
  }, []);

  const handleFileChange = (e) => {
    if (e.target.files && e.target.files.length > 0) {
      uploadFile(e.target.files[0]);
    }
  };

  const uploadFile = async (file) => {
    setError(null);
    if (!file.type.startsWith('image/')) {
      setError('Please upload an image file (JPG, PNG, WEBP, AVIF).');
      return;
    }
    
    if (file.size > 5 * 1024 * 1024) {
      setError('File is too large. Maximum size is 5MB.');
      return;
    }

    // Local preview immediately
    const reader = new FileReader();
    reader.onload = (e) => setPreview(e.target.result);
    reader.readAsDataURL(file);

    setIsUploading(true);

    const formData = new FormData();
    formData.append('file', file);
    
    // Auth context (mocked for this component; usually passed or from context)
    const emailCookie = document.cookie.split('; ').find(row => row.startsWith('auth_token='));
    const email = emailCookie ? emailCookie.split('=')[1] : '';
    formData.append('email', email);

    try {
      const response = await fetch(getApiUrl('upload_media.php'), {
        method: 'POST',
        body: formData
      });
      
      const result = await response.json();
      
      if (result.status === 'success') {
        const imagePath = result.data.large || result.data.original;
        
        // If imagePath already starts with http, use it directly.
        // Otherwise, construct the URL based on the API base.
        let fullUrl = imagePath;
        if (!imagePath.startsWith('http')) {
             // getApiUrl will prepend https://blogs.readxhub.in/ automatically in most cases
             fullUrl = getApiUrl(imagePath.startsWith('/') ? imagePath.slice(1) : imagePath);
        }
        
        setPreview(fullUrl);
        if (onUploadSuccess) {
          onUploadSuccess(result.data);
        }
      } else {
        setError(result.message || 'Upload failed');
        setPreview(currentImage || null);
      }
    } catch (err) {
      setError('Network error during upload');
      setPreview(currentImage || null);
    } finally {
      setIsUploading(false);
    }
  };

  return (
    <div 
      className="mb-6 focus:outline-none"
      onPaste={handlePaste}
      tabIndex={0}
    >
      <label className="block text-sm font-medium text-[var(--ink-soft)] mb-2">Featured Image</label>
      <div 
        className={`relative border-2 border-dashed rounded-xl p-8 flex flex-col items-center justify-center transition-all cursor-pointer
          ${isDragging ? 'border-[var(--stamp)] bg-cyan-900/20' : 'border-[var(--rule-strong)] bg-[#0a0f1c] hover:border-slate-500'}
          ${error ? 'border-red-500' : ''}
        `}
        onDragOver={handleDragOver}
        onDragLeave={handleDragLeave}
        onDrop={handleDrop}
        onClick={() => fileInputRef.current?.click()}
      >
        <input 
          type="file" 
          ref={fileInputRef} 
          className="hidden" 
          accept="image/jpeg,image/png,image/webp,image/gif,image/avif,image/svg+xml"
          onChange={handleFileChange}
        />

        {isUploading ? (
          <div className="flex flex-col items-center space-y-3 text-[var(--link)]">
            <FaSpinner className="animate-spin text-3xl" />
            <span>Optimizing Image...</span>
          </div>
        ) : preview ? (
          <div className="w-full relative group">
            <img 
              src={preview} 
              alt="Preview" 
              className="max-h-64 w-full object-cover rounded-lg"
            />
            <div className="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center rounded-lg">
               <span className="text-[var(--ink)] bg-black/60 px-4 py-2 rounded shadow backdrop-blur-sm">Click to Change</span>
            </div>
            <button 
              onClick={(e) => {
                e.stopPropagation();
                setPreview(null);
                if(onUploadSuccess) onUploadSuccess(null);
              }}
              className="absolute top-2 right-2 bg-red-500 hover:bg-red-600 text-[var(--ink)] p-2 rounded-full shadow-lg"
              title="Remove Image"
            >
              <FaTrash size={12} />
            </button>
          </div>
        ) : (
          <div className="flex flex-col items-center space-y-3 text-[var(--ink-soft)] pointer-events-none">
            <FaUpload className="text-4xl text-[var(--ink-soft)]" />
            <p className="font-semibold text-[var(--ink-soft)]">Click or drag image to upload</p>
            <p className="text-xs">Supports JPG, PNG, WEBP, AVIF. Max 5MB.</p>
            <p className="text-xs italic mt-2 opacity-50">Tip: You can also paste an image from your clipboard (Ctrl+V)</p>
          </div>
        )}
      </div>

      {error && <p className="text-red-400 text-sm mt-2">{error}</p>}
    </div>
  );
};

export default FeaturedImageUploader;
