import React from 'react';
import { Helmet } from 'react-helmet-async';

const SEO = ({
  title,
  description,
  keywords,
  type = 'website',
  image = '',
  canonicalUrl = '',
  author = 'ReadXHub',
  publishedTime,
  modifiedTime,
  noindex = false
}) => {
  const canonicalOrigin = 'https://readxhub.in';
  const origin = window.location.origin || canonicalOrigin;
  const normalizePublicUrl = (value) => {
    if (!value) return `${canonicalOrigin}${window.location.pathname}`;
    if (!value.startsWith('http')) {
      return `${canonicalOrigin}${value.startsWith('/') ? '' : '/'}${value}`;
    }
    try {
      const parsed = new URL(value);
      return `${canonicalOrigin}${parsed.pathname}${parsed.search}`;
    } catch {
      return `${canonicalOrigin}${window.location.pathname}`;
    }
  };

  const url = canonicalUrl
    ? normalizePublicUrl(canonicalUrl)
    : `${canonicalOrigin}${window.location.pathname}`;
  const defaultImage = `${canonicalOrigin}/logo.png`;
  const finalImage = image || defaultImage;
  // Ensure image is absolute
  const absoluteImage = finalImage.startsWith('http') ? finalImage : `${origin}${finalImage.startsWith('/') ? '' : '/'}${finalImage}`;

  const robotsContent = noindex ? 'noindex,nofollow' : 'index,follow,max-image-preview:large';

  return (
    <Helmet>
      <title>{title}</title>
      <meta name="description" content={description} />
      {keywords && <meta name="keywords" content={keywords} />}
      <link rel="canonical" href={url} />
      <link rel="alternate" type="application/rss+xml" title="ReadXHub RSS" href={`${canonicalOrigin}/rss.xml`} />
      
      <meta name="robots" content={robotsContent} />
      <meta name="googlebot" content={robotsContent} />

      <meta property="og:type" content={type} />
      <meta property="og:title" content={title} />
      <meta property="og:description" content={description} />
      <meta property="og:url" content={url} />
      <meta property="og:image" content={absoluteImage} />
      <meta property="og:site_name" content="ReadXHub" />

      <meta name="twitter:card" content="summary_large_image" />
      <meta name="twitter:title" content={title} />
      <meta name="twitter:description" content={description} />
      <meta name="twitter:image" content={absoluteImage} />

      {type === 'article' && author && (
        <meta property="article:author" content={author} />
      )}
      {type === 'article' && publishedTime && (
        <meta property="article:published_time" content={publishedTime} />
      )}
      {type === 'article' && modifiedTime && (
        <meta property="article:modified_time" content={modifiedTime} />
      )}
    </Helmet>
  );
};

export default SEO;
