import React from 'react';
import { Helmet } from 'react-helmet-async';

const JsonLd = ({ data }) => {
  return (
    <Helmet>
      <script type="application/ld+json">
        {JSON.stringify(data)}
      </script>
    </Helmet>
  );
};

export default JsonLd;

// Helper to generate BlogPosting schema
export const generateBlogSchema = (blog, url, origin) => {
  const imagePath = blog.featured_image || blog.image;
  const image = imagePath
    ? (imagePath.startsWith('http') ? imagePath : `${origin}/${imagePath.replace(/^\/+/, '')}`)
    : `${origin}/logo.png`;

  return {
    "@context": "https://schema.org",
    "@type": "TechArticle",
    "mainEntityOfPage": {
      "@type": "WebPage",
      "@id": url
    },
    "headline": blog.seo_title || blog.title,
    "description": blog.seo_description || blog.content?.substring(0, 160),
    "image": [image],
    "author": {
      "@type": "Person",
      "name": blog.author_name || "ReadXHub Author",
      "url": `${origin}/author/${blog.author_id || ''}`
    },  
    "publisher": {
      "@type": "Organization",
      "name": "ReadXHub",
      "logo": {
        "@type": "ImageObject",
        "url": `${origin}/logo.png`
      }
    },
    "datePublished": blog.created_at || new Date().toISOString(),
    "dateModified": blog.updated_at || blog.created_at || new Date().toISOString()
  };
};

export const generateBreadcrumbSchema = (items) => {
  return {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": items.map((item, index) => ({
      "@type": "ListItem",
      "position": index + 1,
      "name": item.name,
      "item": item.url
    }))
  };
};

export const generateOrganizationSchema = (origin) => {
  return {
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "ReadXHub",
    "url": origin,
    "logo": `${origin}/logo.png`,
    "sameAs": [
      "https://facebook.com/readxhub",
      "https://twitter.com/readxhub",
      "https://linkedin.com/company/readxhub"
    ]
  };
};
