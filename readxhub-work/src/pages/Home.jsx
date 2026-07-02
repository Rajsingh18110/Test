import React, { useEffect, useState } from "react";
import { Link, useSearchParams } from "react-router-dom";
import { motion } from "framer-motion";
import { 
  FaUser, FaArrowRight, FaSearch, FaClock, FaBookOpen, FaFire, 
  FaEnvelope, FaChevronRight, FaBookmark, FaRegBookmark, FaExclamationCircle, FaSpinner, 
  FaThumbsUp, FaThumbsDown, FaEye 
} from "react-icons/fa";

import { useAuth0 } from "@auth0/auth0-react";
import { getApiUrl } from "../utils/api.js";
import { getOfflineAuthUser } from "../utils/auth.js";
import SEO from "../components/SEO";
import JsonLd, { generateOrganizationSchema } from "../components/JsonLd";
import AdSlot from "../components/AdSlot";
import VoteRail from "../components/VoteRail";

const LIMIT = 50;
const CATEGORIES = ["All", "Bookmarks", "Cyber Security", "Web Development", "AI & Data Science", "Cloud Architecture", "DevOps"];

export default function Blogs() {
  const { loginWithRedirect, isAuthenticated, user } = useAuth0();
  const offlineUser = getOfflineAuthUser();
  const effectiveUser = isAuthenticated && user?.email ? user : offlineUser;
  const effectiveAuthenticated = isAuthenticated || Boolean(offlineUser);
  const [searchParams] = useSearchParams();
  const getImageUrl = (path) => {
    if (!path) return "";
    if (path.startsWith("http")) return path;
    const cleanPath = path.startsWith("/") ? path.slice(1) : path;
    return getApiUrl(cleanPath);
  };
  const urlQuery = searchParams.get("q") || "";

  const [blogs, setBlogs] = useState([]);
  const [searchText, setSearchText] = useState(urlQuery);
  const [query, setQuery] = useState(urlQuery);
  const [page, setPage] = useState(0);
  const [loading, setLoading] = useState(false);
  const [hasMore, setHasMore] = useState(true);
  const [error, setError] = useState(null);
  
  const [matchingAuthors, setMatchingAuthors] = useState([]);
  const [loadingAuthors, setLoadingAuthors] = useState(false);

  const fetchMatchingAuthors = async (q) => {
    if (!q.trim()) {
      setMatchingAuthors([]);
      return;
    }
    setLoadingAuthors(true);
    try {
      const res = await fetch(getApiUrl(`search_authors.php?q=${encodeURIComponent(q.trim())}`));
      if (res.ok) {
        const data = await res.json();
        setMatchingAuthors(Array.isArray(data) ? data : []);
      }
    } catch (err) {
      console.error("Failed to fetch matching authors:", err);
      setMatchingAuthors([]);
    } finally {
      setLoadingAuthors(false);
    }
  };
  
  // Bookmarks Logic
  const [bookmarks, setBookmarks] = useState(() => {
    try {
      const saved = localStorage.getItem("readxhub_bookmarks");
      return saved ? JSON.parse(saved) : [];
    } catch {
      return [];
    }
  });

  // Newsletter state
  const [email, setEmail] = useState("");
  const [newsletterSubscribed, setNewsletterSubscribed] = useState(() => {
    return localStorage.getItem("readxhub_newsletter_subscribed") === "true";
  });

  useEffect(() => {
    if (isAuthenticated && user?.email) {
      setEmail(user.email);
    }
  }, [isAuthenticated, user]);

  const [activeCategory, setActiveCategory] = useState("All");

  // Fetch blogs logic
  const fetchBlogs = async (reset = false) => {
    if (loading) return;
    setLoading(true);

    const offset = reset ? 0 : page * LIMIT;

    const url = query.trim()
      ? getApiUrl(`fetch_new_blogs.php?q=${encodeURIComponent(query)}&limit=${LIMIT}&offset=${offset}`)
      : getApiUrl(`fetch_new_blogs.php?limit=${LIMIT}&offset=${offset}`);

    try {
      const res = await fetch(url);
      const data = await res.json();

      if (!Array.isArray(data)) {
        setHasMore(false);
        return;
      }

      setBlogs(prev => (reset ? data : [...prev, ...data]));
      setHasMore(data.length === LIMIT);
      setPage(prev => (reset ? 1 : prev + 1));
    } catch {
      setError("Failed to load articles. Please check your internet connection.");
    } finally {
      setLoading(false);
    }
  };

  // Initial load
  useEffect(() => {
    document.title = "ReadXHub | Technology, Development, AI & Cybersecurity Articles";
    fetchBlogs(true);
    // eslint-disable-next-line
  }, []);

  // Save Bookmarks to LocalStorage
  useEffect(() => {
    localStorage.setItem("readxhub_bookmarks", JSON.stringify(bookmarks));
  }, [bookmarks]);

  // Sync search states with URL parameters
  useEffect(() => {
    setSearchText(urlQuery);
    setQuery(urlQuery);
  }, [urlQuery]);

  // Debounce search input
  useEffect(() => {
    const delayDebounceFn = setTimeout(() => {
      setQuery(searchText);
    }, 350);

    return () => clearTimeout(delayDebounceFn);
  }, [searchText]);

  // Refetch when query changes
  useEffect(() => {
    setPage(0);
    setHasMore(true);
    fetchBlogs(true);
    fetchMatchingAuthors(query);
    // eslint-disable-next-line
  }, [query]);

  // Handle Category Filtering
  const handleCategoryClick = (category) => {
    setActiveCategory(category);
    if (category === "All" || category === "Bookmarks") {
      setSearchText("");
    } else {
      setSearchText(category);
    }
  };

  const toggleBookmark = (e, blogId) => {
    e.preventDefault();
    e.stopPropagation();
    setBookmarks(prev => 
      prev.includes(blogId) ? prev.filter(id => id !== blogId) : [...prev, blogId]
    );
  };

  // Handle like/dislike reactions
  const handleReaction = async (e, blogId, type) => {
    e.preventDefault();
    e.stopPropagation();
    if (!effectiveAuthenticated || !effectiveUser?.email) {
      alert("Please log in to react to this publication.");
      loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } });
      return;
    }
    try {
      const res = await fetch(getApiUrl('like_dislike.php'), {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({ blog_id: blogId, reaction: type, user_email: effectiveUser?.email })
      });
      if (res.status === 401) {
        alert("Session expired or unauthorized. Please log in again.");
        loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } });
        return;
      }
      const data = await res.json();
      // Update blogs state with new counts
      setBlogs(prev =>
        prev.map(b =>
          b.id === blogId ? { ...b, likes: data.likes, dislikes: data.dislikes, liked: type === 'like' } : b
        )
      );
    } catch (err) {
      console.error('Reaction error', err);
    }
  };

  const handleNewsletterSubmit = (e) => {
    e.preventDefault();
    if (email.trim()) {
      localStorage.setItem("readxhub_newsletter_subscribed", "true");
      setNewsletterSubscribed(true);
      setEmail("");
    }
  };

  // Calculate reading time
  const getReadingTime = (text) => {
    const words = text ? text.split(" ").length : 65;
    const time = Math.max(1, Math.round(words / 200));
    return `${time} min read`;
  };

  // Filter display list based on active tab
  const displayedBlogs = activeCategory === "Bookmarks"
    ? blogs.filter(b => bookmarks.includes(b.id))
    : blogs;

  // Separate blogs for landing layout structure
  const featuredBlog = displayedBlogs[0];
  const trendingBlogs = displayedBlogs.slice(1, 4);
  const feedBlogs = displayedBlogs.slice(4);

  if (error) {
    return (
      <main className="min-h-screen flex flex-col items-center justify-center bg-[var(--paper)] text-[var(--ink)] p-6">
        <div className="bg-red-500/10 border border-red-500/20 p-6 rounded-2xl max-w-md text-center shadow-lg">
          <p className="text-red-400 font-semibold text-lg">Error Loading Articles</p>
          <p className="text-[var(--ink-soft)] mt-2 text-sm">{error}</p>
          <button 
            onClick={() => { setError(null); fetchBlogs(true); }}
            className="mt-4 px-4 py-2 bg-red-500 text-[var(--ink)] rounded-xl text-sm font-semibold transition-all hover:bg-red-400"
          >
            Retry
          </button>
        </div>
      </main>
    );
  }

  return (
    <main className="min-h-screen bg-[var(--paper)] text-[var(--ink)] selection:bg-[var(--stamp)]/30 selection:text-[var(--link)] pb-20">
      <SEO 
        title="ReadXHub | Technology, Development, AI & Cybersecurity Articles"
        description="Technical articles, secure coding guides, AI notes, web development tutorials, and practical engineering resources."
        keywords="technology articles, cybersecurity articles, AI articles, web development tutorials, programming guides, developer resources"
        canonicalUrl="/"
        type="website"
      />
      <JsonLd data={generateOrganizationSchema("https://readxhub.in")} />
      
      {/* 1. HERO SECTION */}
      <section className="relative overflow-hidden pt-12 pb-16 md:py-24 border-b border-[var(--rule)] bg-gradient-to-b from-[var(--paper)] via-[var(--paper)] to-[var(--paper)]">
        <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_top,_var(--tw-gradient-stops))] from-[var(--stamp-bg)] via-transparent to-transparent pointer-events-none" />
        <div className="max-w-7xl mx-auto px-6 relative z-10 text-center">
          <motion.div 
            initial={{ opacity: 0, y: 12 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.4 }}
            className="inline-flex items-center gap-2 px-3.5 py-1 rounded-sm bg-[var(--stamp-bg)] border border-[var(--stamp)] text-[var(--ink)] text-[11px] font-mono uppercase tracking-widest mb-6"
            style={{ fontFamily: "var(--font-mono)" }}
          >
            Vol. I &middot; The community reference
          </motion.div>
          
          <motion.h1 
            initial={{ opacity: 0, y: 12 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.4, delay: 0.1 }}
            className="text-4xl sm:text-5xl md:text-6xl tracking-tight leading-[1.05] max-w-4xl mx-auto text-[var(--ink)]"
            style={{ fontFamily: "var(--font-display)", fontWeight: 600 }}
          >
            Written by engineers.<br className="hidden md:block" /> Ranked by readers.
          </motion.h1>

          <motion.p 
            initial={{ opacity: 0, y: 12 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.4, delay: 0.2 }}
            className="text-[var(--ink-soft)] text-sm sm:text-base md:text-lg max-w-2xl mx-auto mt-6 leading-relaxed"
          >
            Expert-authored articles, secure coding checklists, AI modules, and deep structural guides for engineers.
          </motion.p>

          {/* Search Box */}
          <motion.div 
            initial={{ opacity: 0, y: 12 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.4, delay: 0.3 }}
            className="mt-10 relative max-w-lg mx-auto bg-[var(--paper-raised)]/50 p-1.5 border border-[var(--rule)] rounded-2xl shadow-xl focus-within:border-[var(--stamp)]/40 focus-within:shadow-black/5 transition-all"
          >
            <div className="flex items-center">
              <FaSearch className="ml-3.5 text-[var(--ink-soft)]" />
              <input
                type="text"
                value={searchText}
                onChange={e => setSearchText(e.target.value)}
                placeholder="Search cybersecurity guides, AI structures, programming tutorials..."
                className="w-full bg-transparent border-0 outline-none text-[var(--ink)] placeholder-[var(--ink-soft)] text-xs md:text-sm py-2 px-3 focus:ring-0"
              />
              {searchText && (
                <button 
                  onClick={() => setSearchText("")} 
                  className="px-2 py-1 text-2xs text-[var(--ink-soft)] hover:text-[var(--ink-soft)] font-semibold"
                >
                  Clear
                </button>
              )}
            </div>
          </motion.div>
        </div>
      </section>

      {/* Assistant removed from homepage; retained only on blog detail pages */}

      {/* Google AdSense TOP BANNER Placement */}
      <section className="max-w-7xl mx-auto px-6 pt-6">
        <AdSlot name="top_banner" placeholder="Top Banner Ad Slot" />
      </section>

      {/* 2. CATEGORIES FILTER SECTION */}
      <section className="max-w-7xl mx-auto px-6 py-6 border-b border-[var(--rule)]">
        <div className="flex items-center space-x-2 overflow-x-auto pb-2 scrollbar-none">
          {CATEGORIES.map(category => (
            <button
              key={`cat-${category}`}
              onClick={() => handleCategoryClick(category)}
              className={`px-4 py-2 rounded-xl text-xs font-semibold whitespace-nowrap border transition-all duration-200 cursor-pointer ${
                activeCategory === category
                  ? "bg-[var(--stamp)]/10 border-[var(--stamp)]/30 text-[var(--link)] shadow-sm"
                  : "bg-[var(--paper-raised)]/30 border-[var(--rule)] text-[var(--ink-soft)] hover:text-[var(--ink)] hover:bg-[var(--paper-raised)]/80"
              }`}
            >
              {category}
            </button>
          ))}
        </div>
      </section>

      {/* MATCHING AUTHORS */}
      {matchingAuthors.length > 0 && (
        <section className="max-w-7xl mx-auto px-6 pt-6 pb-2">
          <div className="bg-[var(--paper-raised)]/20 border border-[var(--rule)] rounded-2xl p-6 shadow-xl relative overflow-hidden">
            <h3 className="text-xs font-extrabold uppercase tracking-wider text-[var(--ink-soft)] mb-4 flex items-center gap-2">
              <FaUser className="text-[var(--stamp)] text-xs" /> Authors matching your search
            </h3>
            
            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
              {matchingAuthors.map((author) => (
                <div 
                  key={`auth-${author.id}`}
                  className="flex items-center gap-4 p-4 rounded-xl bg-[var(--paper-raised)]/40 border border-[var(--rule)] hover:border-[var(--stamp)]/30 transition-all group"
                >
                  <img 
                    src={getImageUrl(author.profile_picture)} 
                    alt={author.name}
                    className="w-12 h-12 rounded-xl object-cover border border-[var(--rule)] group-hover:scale-105 transition-transform bg-[var(--paper-raised)]"
                    referrerPolicy="no-referrer"
                  />
                  <div className="min-w-0 flex-1">
                    <h4 className="text-xs md:text-sm font-bold text-[var(--ink)] group-hover:text-[var(--link)] transition-colors truncate">
                      {author.name}
                    </h4>
                    <p className="text-[10px] text-[var(--ink-soft)] truncate">
                      @{author.username}
                    </p>
                    <p className="text-[10px] text-[var(--ink-soft)] mt-1 line-clamp-1">
                      {author.bio}
                    </p>
                  </div>
                  <Link 
                    to={`/author/${author.username || author.email}`}
                    className="flex-shrink-0 px-3 py-1.5 rounded-lg bg-[var(--paper-raised)] border border-[var(--rule)] text-[10px] font-bold text-[var(--link)] hover:text-[var(--ink)] hover:bg-[var(--stamp)]/20 transition-all cursor-pointer"
                  >
                    View Profile
                  </Link>
                </div>
              ))}
            </div>
          </div>
        </section>
      )}

      {/* SKELETON LOADERS */}
      {loading && displayedBlogs.length === 0 ? (
        <section className="max-w-7xl mx-auto px-6 py-12">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <div className="lg:col-span-2 space-y-6">
              <div className="w-full h-96 rounded-2xl skeleton-box" />
              <div className="w-full h-48 rounded-2xl skeleton-box" />
            </div>
            <div className="space-y-6">
              <div className="w-full h-24 rounded-2xl skeleton-box" />
              <div className="w-full h-24 rounded-2xl skeleton-box" />
            </div>
          </div>
        </section>
      ) : displayedBlogs.length === 0 ? (
        <section className="max-w-md mx-auto px-6 py-20 text-center space-y-4">
          <div className="w-12 h-12 bg-[var(--paper-raised)]/80 border border-[var(--rule)] rounded-xl flex items-center justify-center text-[var(--ink-soft)] mx-auto">
            <FaExclamationCircle className="text-xl" />
          </div>
          <div className="space-y-1">
            <h3 className="text-sm font-bold text-[var(--ink)]">
              {activeCategory === "Bookmarks" ? "No bookmarked articles" : "No articles found"}
            </h3>
            <p className="text-[var(--ink-soft)] text-xs leading-relaxed max-w-xs mx-auto">
              {activeCategory === "Bookmarks" 
                ? "Your saved list is currently empty. Toggle the bookmark icon on cards to save articles."
                : "No matching publications. Try adjusting your search keywords."}
            </p>
          </div>
        </section>
      ) : (
        <div className="max-w-7xl mx-auto px-6 py-12">
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-10">
            
            {/* Left Col: Featured & Main Feed */}
            <div className="lg:col-span-2 space-y-12">
              
              {/* FEATURED SECTION */}
              {featuredBlog && (activeCategory === "All" || activeCategory === "Bookmarks") && (
                <div className="space-y-4">
                  <div className="flex items-center gap-2 text-xs font-semibold text-[var(--stamp)] uppercase tracking-wider">
                    <span className="w-1.5 h-1.5 bg-[var(--stamp)] rounded-full" /> Featured Article
                  </div>
                  <motion.article 
                    whileHover={{ y: -3 }}
                    transition={{ duration: 0.2 }}
                    className="relative group rounded-2xl bg-[var(--paper-raised)]/40 border border-[var(--rule)] p-6 flex flex-col md:flex-row gap-6 shadow-xl"
                  >
                    {/* Cover visual */}
                    <div className="w-full md:w-2/5 aspect-video md:aspect-auto md:h-52 rounded-xl bg-gradient-to-br from-[var(--stamp-bg)] via-slate-900 to-blue-950/20 border border-[var(--rule)] flex items-center justify-center overflow-hidden flex-shrink-0 relative group-hover:opacity-90">
                      {featuredBlog.featured_image && featuredBlog.featured_image !== 'null' && featuredBlog.featured_image !== 'undefined' ? (
                        <img 
                          src={getImageUrl((featuredBlog.featured_image_medium && featuredBlog.featured_image_medium !== 'null' && featuredBlog.featured_image_medium !== 'undefined') ? featuredBlog.featured_image_medium : featuredBlog.featured_image)} 
                          alt={featuredBlog.image_alt || featuredBlog.title} 
                          className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                        />
                      ) : (
                        <FaBookOpen className="text-3xl text-slate-850 group-hover:scale-105 transition-transform duration-300" />
                      )}
                      
                      {/* Interaction Buttons */}
                      <div className="absolute top-3 right-3 flex space-x-2">
                        {/* Bookmark */}
                        <button 
                          onClick={(e) => toggleBookmark(e, featuredBlog.id)}
                          className="p-2 rounded-lg bg-[var(--paper-raised)]/80 border border-[var(--rule)] text-[var(--ink-soft)] hover:text-[var(--link)] transition-all cursor-pointer"
                          title={bookmarks.includes(featuredBlog.id) ? "Remove Bookmark" : "Save Bookmark"}
                        >
                          {bookmarks.includes(featuredBlog.id) ? <FaBookmark className="text-[var(--stamp)] text-xs" /> : <FaRegBookmark className="text-xs" />}
                        </button>
                        {/* Signature vote rail */}
                        <VoteRail
                          size="sm"
                          score={(featuredBlog.likes || 0) - (featuredBlog.dislikes || 0)}
                          myVote={featuredBlog.liked === true ? "up" : featuredBlog.liked === false ? "down" : null}
                          onVote={(dir) => handleReaction({ preventDefault(){}, stopPropagation(){} }, featuredBlog.id, dir === "up" ? "like" : "dislike")}
                        />
                      </div>
                    </div>

                    <div className="flex-1 flex flex-col justify-between">
                      <div>
                        <div className="flex items-center gap-3 text-[10px] text-[var(--ink-soft)] mb-2">
                          <span className="px-2.5 py-0.5 rounded bg-[var(--stamp)]/5 border border-[var(--stamp)]/10 text-[var(--link)] font-semibold tracking-wider uppercase">Guide</span>
                          <span className="flex items-center gap-1"><FaClock /> {featuredBlog.reading_time || 1} min read</span>
                          <span className="flex items-center gap-1"><FaEye /> {featuredBlog.views || 0} views</span>
                        </div>
                        <h2 className="text-lg md:text-xl font-bold text-[var(--ink)] group-hover:text-[var(--link)] transition-colors line-clamp-2 leading-snug">
                          <Link to={`/blog/${featuredBlog.slug}`}>{featuredBlog.title}</Link>
                        </h2>
                        <p className="text-[var(--ink-soft)] text-xs md:text-sm mt-3 line-clamp-3 leading-relaxed">
                          {featuredBlog.description}
                        </p>
                      </div>

                      <div className="mt-6 pt-4 border-t border-[var(--rule)] flex items-center justify-between">
                        <span className="text-3xs text-slate-455 flex items-center gap-1">
                          <FaUser className="text-[var(--ink-soft)]" />
                          {featuredBlog.email ? (
                            <Link to={`/author/${featuredBlog.username || featuredBlog.email}`} className="hover:text-[var(--link)] hover:underline">{featuredBlog.author}</Link>
                          ) : (
                            featuredBlog.author
                          )}
                        </span>
                        <Link 
                          to={`/blog/${featuredBlog.slug}`} 
                          className="flex items-center gap-1 text-xs text-[var(--link)] font-bold group-hover:underline"
                        >
                          Read Article <FaArrowRight className="text-3xs" />
                        </Link>
                      </div>
                    </div>
                  </motion.article>
                </div>
              )}

              {/* MAIN FEED SECTION */}
              <div className="space-y-6">
                <h3 className="text-sm font-bold uppercase tracking-wider text-[var(--ink-soft)] flex items-center gap-2">
                  <span className="w-1.5 h-1.5 rounded-full bg-[var(--stamp)]" /> Latest Publications
                </h3>
                
                <div className="space-y-4">
                  {(activeCategory === "All" || activeCategory === "Bookmarks" ? feedBlogs : displayedBlogs).map(blog => (
                    <motion.article
                      key={`feed-${blog.id}`}
                      whileHover={{ x: 3 }}
                      transition={{ duration: 0.2 }}
                      className="group rounded-2xl bg-[var(--paper-raised)]/30 border border-[var(--rule)] p-5 hover:border-[var(--rule-strong)]/60 hover:bg-[var(--paper-raised)]/50 transition-all flex flex-col md:flex-row gap-5"
                    >
                      {/* image slot */}
                      <div className="w-full md:w-36 h-24 rounded-xl bg-gradient-to-r from-slate-950 to-slate-900 border border-[var(--rule)]/50 flex-shrink-0 flex items-center justify-center relative overflow-hidden">
                        {blog.featured_image && blog.featured_image !== 'null' && blog.featured_image !== 'undefined' ? (
                          <img 
                            src={getImageUrl((blog.featured_image_thumb && blog.featured_image_thumb !== 'null' && blog.featured_image_thumb !== 'undefined') ? blog.featured_image_thumb : blog.featured_image)} 
                            alt={blog.image_alt || blog.title} 
                            className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                          />
                        ) : (
                          <FaBookOpen className="text-slate-850 text-xl" />
                        )}
                        
                        <div className="absolute top-2 right-2 flex space-x-1">
                          {/* Bookmark */}
                          <button 
                            onClick={(e) => toggleBookmark(e, blog.id)}
                            className="p-1.5 rounded bg-[var(--paper-raised)]/90 border border-[var(--rule)] text-[var(--ink-soft)] hover:text-[var(--link)] transition-all cursor-pointer"
                            title={bookmarks.includes(blog.id) ? "Remove Bookmark" : "Save Bookmark"}
                          >
                            {bookmarks.includes(blog.id) ? <FaBookmark className="text-[var(--stamp)] text-[10px]" /> : <FaRegBookmark className="text-[10px]" />}
                          </button>
                          {/* Signature vote rail */}
                          <VoteRail
                            size="sm"
                            score={(blog.likes || 0) - (blog.dislikes || 0)}
                            myVote={blog.liked === true ? "up" : blog.liked === false ? "down" : null}
                            onVote={(dir) => handleReaction({ preventDefault(){}, stopPropagation(){} }, blog.id, dir === "up" ? "like" : "dislike")}
                          />
                        </div>
                      </div>

                      <div className="flex-1 flex flex-col justify-between">
                        <div>
                          <div className="flex items-center gap-2 mb-1.5 text-3xs">
                            <span className="text-[var(--ink-soft)]">{new Date(blog.created_at || Date.now()).toLocaleDateString("en-IN")}</span>
                            <span className="text-[var(--rule-strong)]">•</span>
                             <span className="text-[var(--ink-soft)] flex items-center gap-0.5"><FaClock className="text-[10px]" /> {blog.reading_time || 1} min read</span>
                            <span className="text-[var(--rule-strong)]">•</span>
                            <span className="text-[var(--ink-soft)] flex items-center gap-0.5"><FaEye className="text-[10px]" /> {blog.views || 0} views</span>
                          </div>
                          <h4 className="text-sm md:text-base font-bold text-[var(--ink)] group-hover:text-[var(--link)] transition-colors leading-snug">
                            <Link to={`/blog/${blog.slug}`}>{blog.title}</Link>
                          </h4>
                          <p className="text-xs text-[var(--ink-soft)] mt-1 line-clamp-2 leading-relaxed">
                            {blog.description}
                          </p>
                        </div>

                         <div className="flex items-center justify-between mt-3 pt-3 border-t border-slate-950">
                          <span className="text-3xs text-slate-455 flex items-center gap-1">
                            <FaUser className="text-slate-655" />
                            {blog.email ? (
                              <Link to={`/author/${blog.username || blog.email}`} className="hover:text-[var(--link)] hover:underline">{blog.author}</Link>
                            ) : (
                              blog.author
                            )}
                          </span>
                          <Link to={`/blog/${blog.slug}`} className="text-3xs text-[var(--link)] font-bold hover:underline flex items-center gap-0.5">
                            Read Article <FaChevronRight className="text-[10px]" />
                          </Link>
                        </div>
                      </div>
                    </motion.article>
                  ))}
                </div>

                {hasMore && activeCategory !== "Bookmarks" && (
                  <div className="flex justify-center pt-8">
                    <button
                      onClick={() => fetchBlogs(false)}
                      disabled={loading}
                      className="px-5 py-2.5 rounded-xl bg-[var(--paper-raised)] border border-[var(--rule)] text-[var(--link)] text-xs font-bold transition-all shadow-md active:scale-98 cursor-pointer flex items-center gap-2"
                    >
                      {loading ? (
                        <>
                          <FaSpinner className="animate-spin" /> Loading next...
                        </>
                      ) : (
                        "Load next publications"
                      )}
                    </button>
                  </div>
                )}
              </div>

            </div>

            {/* Right Col: Trending & Newsletter & Ad slot */}
            <div className="space-y-8">
              
              {/* TRENDING SECTION */}
              {activeCategory === "All" && trendingBlogs.length > 0 && (
                <div className="bg-[var(--paper-raised)]/20 border border-[var(--rule)] rounded-2xl p-5 shadow-lg">
                  <h3 className="text-xs font-bold uppercase tracking-wider text-[var(--ink-soft)] mb-5 flex items-center gap-2">
                    <FaFire className="text-amber-500 animate-pulse" /> Popular Articles
                  </h3>
                  <div className="space-y-5">
                    {trendingBlogs.map((blog, idx) => (
                      <div key={`trend-${blog.id}`} className="flex gap-4 group">
                        <span className="text-xl font-extrabold text-slate-800 group-hover:text-[var(--stamp)]/40 transition-colors">
                          {String(idx + 1).padStart(2, "0")}
                        </span>
                        <div className="space-y-1">
                          <h4 className="text-xs md:text-sm font-bold text-[var(--ink)] group-hover:text-[var(--ink)] transition-colors leading-snug">
                            <Link to={`/blog/${blog.slug}`}>{blog.title}</Link>
                          </h4>
                           <span className="text-3xs text-[var(--ink-soft)] flex items-center gap-1">
                            <FaUser />
                            {blog.email ? (
                              <Link to={`/author/${blog.username || blog.email}`} className="hover:text-[var(--link)] hover:underline">{blog.author}</Link>
                            ) : (
                              blog.author
                            )}
                          </span>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* NEWSLETTER */}
              {!newsletterSubscribed && (
                <div className="bg-gradient-to-b from-slate-900/40 to-slate-950/20 border border-[var(--rule)] rounded-2xl p-5 shadow-xl relative overflow-hidden">
                  <div className="absolute -right-10 -bottom-10 w-24 h-24 bg-[var(--stamp)]/5 rounded-full blur-xl pointer-events-none" />
                  <FaEnvelope className="text-[var(--link)] text-xl mb-3" />
                  <h3 className="text-xs md:text-sm font-bold text-[var(--ink)]">Join the ReadXHub Newsletter</h3>
                  <p className="text-[var(--ink-soft)] text-xs mt-2 leading-relaxed">
                    Join a cohort of tech students and developers. Get security alerts and programming tips.
                  </p>
                  <form onSubmit={handleNewsletterSubmit} className="mt-5 space-y-3">
                    <input
                      type="email"
                      value={email}
                      onChange={e => setEmail(e.target.value)}
                      placeholder="name@email.com"
                      required
                      disabled={isAuthenticated && !!user?.email}
                      className={`w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl px-4 py-2.5 text-xs text-slate-250 focus:border-[var(--stamp)]/40 focus:outline-none ${isAuthenticated && user?.email ? 'opacity-60 cursor-not-allowed bg-[var(--paper-raised)]/50' : ''}`}
                    />
                    <button
                      type="submit"
                      className="w-full py-2.5 rounded-xl bg-[var(--stamp)] hover:bg-[var(--stamp)] text-slate-955 text-xs font-bold transition-all shadow-md cursor-pointer"
                    >
                      Subscribe
                    </button>
                  </form>
                </div>
              )}

              {/* Google AdSense SIDEBAR Placement */}
              <AdSlot name="sidebar" placeholder="Sidebar Ad Slot" />

            </div>

          </div>
        </div>
      )}

      {/* Google AdSense FOOTER Placement */}
      <section className="max-w-7xl mx-auto px-6 pt-10">
        <AdSlot name="footer_banner" placeholder="Footer Banner Ad Slot" />
      </section>

    </main>
  );
}
