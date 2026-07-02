import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { FaUser, FaCalendarAlt, FaArrowLeft, FaSpinner, FaEye } from "react-icons/fa";
import CommentBox from "../components/CommentBox";
import { getApiUrl } from "../utils/api.js";
import { marked } from "marked";
import DOMPurify from "dompurify";
import AdSlot from "../components/AdSlot";

const Post = () => {
  const [post, setPost] = useState(null);
  const [notFound, setNotFound] = useState(false);

  // Get slug from URL (existing business logic)
  const slug = window.location.pathname.split("/").pop();

  useEffect(() => {
    const fetchPost = async () => {
      try {
        const res = await fetch(
          getApiUrl(`fetch_single_blog.php?id=${slug}`)
        );
        const data = await res.json();
        if (!data || data.error) {
          setNotFound(true);
        } else {
          setPost({
            title: data.title,
            author: data.author,
            date: new Date(data.created_at).toDateString(),
            content: data.content,
            email: data.email,
            username: data.username,
            views: data.views,
          });
        }
      } catch {
        setNotFound(true);
      }
    };
    fetchPost();
    // eslint-disable-next-line
  }, [slug]);

  if (notFound) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-[var(--paper)] p-6 text-center">
        <div className="bg-red-500/10 border border-red-500/20 p-6 rounded-2xl max-w-sm">
          <p className="text-red-400 font-bold text-lg">Post Not Found</p>
          <p className="text-[var(--ink-soft)] text-xs mt-1.5">The article you are searching for does not exist in ReadXHub.</p>
          <Link to="/" className="mt-4 inline-flex items-center gap-1.5 text-xs text-[var(--link)] font-semibold hover:underline">
            <FaArrowLeft /> Back to home
          </Link>
        </div>
      </div>
    );
  }

  if (!post) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-[var(--paper)]">
        <FaSpinner className="animate-spin text-[var(--link)] text-3xl" />
      </div>
    );
  }

  return (
    <main className="min-h-screen bg-[var(--paper)] text-[var(--ink)] selection:bg-[var(--stamp)]/30 selection:text-[var(--link)] py-12 px-6">
      <div className="max-w-3xl mx-auto space-y-6">
        
        {/* Back navigation */}
        <Link 
          to="/" 
          className="inline-flex items-center gap-1.5 text-xs text-[var(--ink-soft)] hover:text-cyan-405 transition-colors mb-4 font-medium"
        >
          <FaArrowLeft /> Back to home
        </Link>

        {/* Google AdSense TOP BANNER Placement */}
        <div className="my-4">
          <AdSlot name="top_banner" placeholder="Top Banner Ad Slot" />
        </div>

        {/* Publication Card Wrapper */}
        <article className="bg-[var(--paper-raised)]/40 border border-[var(--rule)] rounded-2xl p-6 md:p-8 shadow-xl">
          <header className="mb-6">
            <h1 className="text-2xl md:text-3xl font-extrabold text-[var(--ink)] tracking-tight leading-tight">
              {post.title}
            </h1>
            
            <div className="mt-4 flex flex-wrap gap-4 items-center text-xs text-[var(--ink-soft)]">
              <span className="flex items-center gap-1.5">
                <FaUser className="text-[var(--stamp)]" />
                <span className="font-medium text-[var(--ink-soft)]">
                  By: {post.email ? (
                    <Link to={`/author/${post.username || post.email}`} className="text-[var(--ink-soft)] hover:text-[var(--link)] hover:underline">{post.author}</Link>
                  ) : (
                    post.author
                  )}
                </span>
              </span>
              <span className="text-[var(--ink-soft)]">•</span>
              <span className="flex items-center gap-1.5">
                <FaCalendarAlt className="text-[var(--stamp)]" />
                <span>{post.date}</span>
              </span>
              <span className="text-[var(--ink-soft)]">•</span>
              <span className="flex items-center gap-1.5">
                <FaEye className="text-[var(--stamp)]" />
                <span>{post.views || 0} views</span>
              </span>
            </div>
          </header>

          <hr className="border-[var(--rule)] mb-6" />

          {/* Rendered Body Content */}
          <div
            className="custom-markdown-styles text-slate-350 leading-relaxed text-sm md:text-base space-y-4"
            dangerouslySetInnerHTML={{ __html: post.content ? DOMPurify.sanitize(marked.parse(post.content)) : "" }}
          />

          {/* Google AdSense FOOTER Placement */}
          <div className="mt-8">
            <AdSlot name="footer_banner" placeholder="Footer Banner Ad Slot" />
          </div>

          {/* Discussion Box */}
          <div className="mt-12 pt-8 border-t border-[var(--rule)]">
            <CommentBox postId={slug} />
          </div>
        </article>

      </div>
    </main>
  );
};

export default Post;