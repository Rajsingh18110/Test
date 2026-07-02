import React, { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import DOMPurify from "dompurify";
import { FaUser, FaCalendarAlt, FaArrowLeft, FaWhatsapp, FaFacebookF, FaTwitter, FaLinkedinIn, FaRedditAlien, FaCopy, FaCheck, FaBookOpen, FaClock, FaChevronRight, FaEye } from "react-icons/fa";
import CommentBox from "../components/CommentBox";
import { getApiUrl } from "../utils/api.js";
import { marked } from "marked";
import AdSlot from "../components/AdSlot";

const ViewMore = () => {
  const { id } = useParams(); // Get ID from URL (existing business logic)
  const [blog, setBlog] = useState(null);
  const [copied, setCopied] = useState(false);
  const [scrollProgress, setScrollProgress] = useState(0);
  const [relatedBlogs, setRelatedBlogs] = useState([]);

  useEffect(() => {
    fetch(getApiUrl(`fetch_single_new_blog.php?id=${id}`))
      .then((response) => response.json())
      .then((data) => {
        setBlog(data);
      })
      .catch((error) => console.error("Error fetching blog details:", error));
  }, [id]);

  useEffect(() => {
    const handleScroll = () => {
      const totalHeight = document.documentElement.scrollHeight - window.innerHeight;
      if (totalHeight > 0) {
        const scrolled = (window.scrollY / totalHeight) * 100;
        setScrollProgress(scrolled);
      }
    };
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  /* ---------- Fetch Related Articles ---------- */
  useEffect(() => {
    if (!blog) return;
    fetch(getApiUrl("fetch_new_blogs.php?limit=6"))
      .then(res => res.json())
      .then(data => {
        if (Array.isArray(data)) {
          const filtered = data.filter(item => item.id !== blog.id).slice(0, 3);
          setRelatedBlogs(filtered);
        }
      })
      .catch(() => {});
  }, [blog]);

  const copyToClipboard = () => {
    navigator.clipboard.writeText(window.location.href);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  const getReadingTime = (text) => {
    const words = text ? text.split(" ").length : 65;
    const time = Math.max(1, Math.round(words / 200));
    return `${time} min read`;
  };

  if (!blog) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-[var(--paper)]">
        <div className="w-full max-w-3xl px-6 space-y-6">
          <div className="h-8 w-2/3 skeleton-box rounded-lg" />
          <div className="h-4 w-1/3 skeleton-box rounded-lg" />
          <div className="h-96 w-full skeleton-box rounded-2xl" />
        </div>
      </div>
    );
  }

  const shareUrl = window.location.href;
  const encodedTitle = encodeURIComponent(blog.title);

  return (
    <main className="min-h-screen bg-[var(--paper)] text-[var(--ink)] selection:bg-[var(--stamp)]/30 selection:text-[var(--link)] pb-24">
      
      {/* Reading Progress Line */}
      <div 
        className="fixed top-16 left-0 h-[3px] bg-[var(--stamp)] z-50 transition-all duration-75"
        style={{ width: `${scrollProgress}%` }}
      />

      {/* Google AdSense TOP BANNER Placement */}
      <section className="max-w-4xl mx-auto px-6 pt-6">
        <AdSlot name="top_banner" placeholder="Top Banner Ad Slot" />
      </section>

      <div className="max-w-4xl mx-auto px-6 pt-6">
        
        {/* Back Link */}
        <Link 
          to="/" 
          className="inline-flex items-center gap-1.5 text-xs text-[var(--ink-soft)] hover:text-[var(--link)] transition-colors mb-6 font-medium"
        >
          <FaArrowLeft /> Back to home
        </Link>

        {/* Article Card */}
        <article className="bg-[var(--paper-raised)]/40 border border-[var(--rule)] rounded-2xl p-6 md:p-10 shadow-xl">
          <header className="mb-8">
            <h1 className="text-2xl md:text-4xl font-extrabold text-[var(--ink)] tracking-tight leading-tight">
              {blog.title}
            </h1>

            <div className="mt-6 flex flex-wrap gap-4 items-center text-xs text-[var(--ink-soft)]">
              <span className="flex items-center gap-1.5">
                <span className="w-5 h-5 rounded-full bg-[var(--stamp-bg)] flex items-center justify-center text-[var(--ink-soft)] border border-[var(--rule-strong)]">
                  <FaUser className="text-[10px]" />
                </span>
                <span className="font-semibold text-[var(--ink-soft)]">
                  {blog.email ? (
                    <Link to={`/author/${blog.username || blog.email}`} className="text-[var(--ink-soft)] hover:text-[var(--link)] hover:underline">{blog.author}</Link>
                  ) : (
                    blog.author
                  )}
                </span>
              </span>
              <span className="text-[var(--ink-soft)]">•</span>
              <span className="flex items-center gap-1.5">
                <FaCalendarAlt className="text-[var(--stamp)]" />
                <span>{new Date(blog.created_at).toDateString()}</span>
              </span>
              <span className="text-slate-655">•</span>
              <span className="flex items-center gap-1.5">
                <FaEye className="text-[var(--stamp)]" />
                <span>{blog.views || 0} views</span>
              </span>
            </div>
          </header>

          <hr className="border-[var(--rule)] mb-8" />

          {/* Parsed content body */}
          <div
            className="custom-markdown-styles text-[var(--ink-soft)] leading-relaxed text-sm md:text-base space-y-4 mb-10"
            dangerouslySetInnerHTML={{ __html: blog.content ? DOMPurify.sanitize(marked.parse(blog.content)) : "" }}
          />

          {/* Premium Share Widget Bar */}
          <div className="bg-[var(--paper-raised)]/60 border border-[var(--rule)] p-4 rounded-xl flex flex-wrap items-center justify-between gap-4 mt-12 mb-10">
            <span className="text-xs font-bold uppercase tracking-wider text-[var(--ink-soft)]">Share this article:</span>
            <div className="flex flex-wrap gap-2">
              <a
                href={`https://wa.me/?text=${encodedTitle} - ${shareUrl}`}
                target="_blank"
                rel="noopener noreferrer"
                className="w-9 h-9 rounded-lg bg-[var(--paper-raised)] border border-[var(--rule)] flex items-center justify-center text-[var(--ink-soft)] hover:text-green-500 hover:border-green-500/20 transition-all"
                title="WhatsApp"
              >
                <FaWhatsapp className="text-sm" />
              </a>
              <a
                href={`https://www.facebook.com/sharer/sharer.php?u=${shareUrl}`}
                target="_blank"
                rel="noopener noreferrer"
                className="w-9 h-9 rounded-lg bg-[var(--paper-raised)] border border-[var(--rule)] flex items-center justify-center text-[var(--ink-soft)] hover:text-blue-500 hover:border-blue-500/20 transition-all"
                title="Facebook"
              >
                <FaFacebookF className="text-sm" />
              </a>
              <a
                href={`https://twitter.com/intent/tweet?url=${shareUrl}&text=${encodedTitle}`}
                target="_blank"
                rel="noopener noreferrer"
                className="w-9 h-9 rounded-lg bg-[var(--paper-raised)] border border-[var(--rule)] flex items-center justify-center text-[var(--ink-soft)] hover:text-[var(--link)] hover:border-[var(--stamp)]/20 transition-all"
                title="Twitter"
              >
                <FaTwitter className="text-sm" />
              </a>
              <a
                href={`https://www.linkedin.com/shareArticle?url=${shareUrl}&title=${encodedTitle}`}
                target="_blank"
                rel="noopener noreferrer"
                className="w-9 h-9 rounded-lg bg-[var(--paper-raised)] border border-[var(--rule)] flex items-center justify-center text-[var(--ink-soft)] hover:text-blue-400 hover:border-blue-400/20 transition-all"
                title="LinkedIn"
              >
                <FaLinkedinIn className="text-sm" />
              </a>
              <a
                href={`https://www.reddit.com/submit?url=${shareUrl}&title=${encodedTitle}`}
                target="_blank"
                rel="noopener noreferrer"
                className="w-9 h-9 rounded-lg bg-[var(--paper-raised)] border border-[var(--rule)] flex items-center justify-center text-[var(--ink-soft)] hover:text-orange-500 hover:border-orange-500/20 transition-all"
                title="Reddit"
              >
                <FaRedditAlien className="text-sm" />
              </a>
              <button
                onClick={copyToClipboard}
                className="w-9 h-9 rounded-lg bg-[var(--paper-raised)] border border-[var(--rule)] flex items-center justify-center text-[var(--ink-soft)] hover:text-[var(--link)] hover:border-[var(--stamp)]/20 transition-all cursor-pointer"
                title="Copy Link"
              >
                {copied ? <FaCheck className="text-sm text-[var(--link)]" /> : <FaCopy className="text-sm" />}
              </button>
            </div>
          </div>

          {/* RELATED ARTICLES RECOMMENDER SECTION */}
          {relatedBlogs.length > 0 && (
            <div className="border-t border-[var(--rule)] pt-8 mt-12 space-y-6">
              <h4 className="text-sm font-bold uppercase tracking-wider text-[var(--ink-soft)] flex items-center gap-2">
                <FaBookOpen className="text-[var(--stamp)]" /> Recommended Articles
              </h4>
              <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                {relatedBlogs.map(item => (
                  <div 
                    key={item.id} 
                    className="p-4 rounded-xl bg-[var(--paper-raised)]/20 border border-[var(--rule)] hover:border-[var(--rule-strong)]/60 transition-all flex flex-col justify-between"
                  >
                    <div className="space-y-2">
                      <span className="text-[10px] text-[var(--ink-soft)] flex items-center gap-1"><FaClock /> {item.reading_time || 1} min read</span>
                      <h5 className="text-xs font-bold text-[var(--ink)] line-clamp-2 leading-snug hover:text-[var(--link)] transition-colors">
                        <Link to={`/blog/${item.slug}`}>{item.title}</Link>
                      </h5>
                    </div>
                    <Link 
                      to={`/blog/${item.slug}`}
                      className="inline-flex items-center gap-1 text-[10px] text-[var(--link)] font-bold hover:underline mt-4"
                    >
                      Read Post <FaChevronRight className="text-[8px]" />
                    </Link>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* Google AdSense FOOTER Placement */}
          <div className="mt-10 mb-8">
            <AdSlot name="footer_banner" placeholder="Footer Banner Ad Slot" />
          </div>

          {/* Comment thread with matching blogId */}
          <div className="border-t border-[var(--rule)] pt-8 mt-10">
            <CommentBox blogId={id} />
          </div>
        </article>

      </div>
    </main>
  );
};

export default ViewMore;
