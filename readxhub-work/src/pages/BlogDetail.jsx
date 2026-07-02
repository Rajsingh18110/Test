import React, { useEffect, useState, useRef } from "react";
import { useParams, Link, useNavigate } from "react-router-dom";
import DOMPurify from "dompurify";
import SEO from "../components/SEO";
import JsonLd, { generateBlogSchema } from "../components/JsonLd";
import { useAuth0 } from "@auth0/auth0-react";
import { getApiUrl } from "../utils/api.js";
import { getOfflineAuthUser } from "../utils/auth.js";
import { marked } from "marked";
import AdSlot from "../components/AdSlot";
import {
  FaUser,
  FaCalendarAlt,
  FaPlay,
  FaPause,
  FaArrowLeft,
  FaWhatsapp,
  FaFacebookF,
  FaTwitter,
  FaLinkedinIn,
  FaCopy,
  FaCheck,
  FaBookmark,
  FaRegBookmark,
  FaBookOpen,
  FaClock,
  FaChevronRight,
  FaBell,
  FaBellSlash,
  FaSpinner,
  FaThumbsUp,
  FaThumbsDown,
  FaEye,
  FaFlag
} from "react-icons/fa";
import CommentBox from "../components/CommentBox";
import FullScreenVideoPlayer from "./FullScreenVideoPlayer";
import ReactionPromptModal, { playPopSound } from "../components/ReactionPromptModal";
import ArticleAssistant from "../components/ArticleAssistant";
import VoteRail from "../components/VoteRail";
import RevisionHistory from "../components/RevisionHistory";

/* ---------- Language Detection ---------- */
const detectLanguage = (text) =>
  /[\u0900-\u097F]/.test(text) ? "hi-IN" : "en-IN";

/* ---------- Text Chunking Helper for SpeechSynthesis ---------- */
const chunkText = (text, maxLength = 200) => {
  if (!text) return [];
  const sentences = text.match(/[^.!?\n\r]+[.!?\n\r]*/g) || [text];
  const chunks = [];
  let currentChunk = "";

  for (const sentence of sentences) {
    if (sentence.length > maxLength) {
      if (currentChunk.trim()) {
        chunks.push(currentChunk.trim());
        currentChunk = "";
      }
      const words = sentence.split(/\s+/);
      let tempChunk = "";
      for (const word of words) {
        if ((tempChunk + " " + word).length > maxLength) {
          if (tempChunk.trim()) {
            chunks.push(tempChunk.trim());
          }
          tempChunk = word;
        } else {
          tempChunk = tempChunk ? tempChunk + " " + word : word;
        }
      }
      if (tempChunk.trim()) {
        currentChunk = tempChunk;
      }
    } else {
      if ((currentChunk + sentence).length > maxLength) {
        if (currentChunk.trim()) {
          chunks.push(currentChunk.trim());
        }
        currentChunk = sentence;
      } else {
        currentChunk += sentence;
      }
    }
  }

  if (currentChunk.trim()) {
    chunks.push(currentChunk.trim());
  }

  return chunks;
};

/* ---------- Content Parser (With AdSense In-Article Slot) ---------- */
const parseContent = (content, onVideoClick) => {
  if (!content) return null;

  const parts = content.split(/\[youtube:([a-zA-Z0-9_-]{11})\]/g);

  return parts.flatMap((part, index) => {
    const renders = [];

    // Odd indexes = video IDs
    if (index % 2 === 1) {
      const videoId = part;
      renders.push(
        <div
          key={`yt-${index}`}
          onClick={() => onVideoClick(videoId)}
          className="my-8 relative cursor-pointer rounded-2xl overflow-hidden border border-[var(--rule)] bg-black group shadow-xl"
        >
          <img
            src={`https://img.youtube.com/vi/${videoId}/hqdefault.jpg`}
            alt="YouTube Video"
            className="w-full aspect-video object-cover opacity-75 group-hover:opacity-95 transition-all duration-350"
          />
          <div className="absolute inset-0 flex items-center justify-center bg-black/20 group-hover:bg-black/40 transition-colors">
            <div className="w-14 h-14 bg-[var(--stamp)] text-slate-950 rounded-full flex items-center justify-center shadow-lg group-hover:scale-105 transition-transform duration-300">
              <svg viewBox="0 0 24 24" fill="currentColor" width="24" height="24">
                <path d="M8 5v14l11-7z" />
              </svg>
            </div>
          </div>
        </div>
      );
    } else {
      let rawHtml = marked.parse(part);
      
      // Anchor injection inside headers
      rawHtml = rawHtml.replace(/<h([1-6])(.*?)>(.*?)<\/h\1>/g, (match, lvl, attrs, txt) => {
        const plainText = txt.replace(/<[^>]*>/g, "").trim();
        const id = plainText.toLowerCase().replace(/[^\w\s-]/g, "").replace(/\s+/g, "-");
        const classNames = lvl === '1' ? 'text-2xl font-extrabold text-[var(--ink)] mt-10 mb-4 scroll-mt-24'
                         : lvl === '2' ? 'text-xl font-extrabold text-[var(--ink)] mt-8 mb-3.5 scroll-mt-24' 
                         : lvl === '3' ? 'text-lg font-bold text-[var(--ink)] mt-6 mb-2.5 scroll-mt-24'
                         : 'font-bold text-[var(--ink)] mt-6 mb-2.5 scroll-mt-24';
        return `<h${lvl} id="${id}" class="${classNames}">${txt}</h${lvl}>`;
      });

      const safeHtml = DOMPurify.sanitize(rawHtml, {
        ADD_TAGS: ["h1", "h2", "h3", "h4", "h5", "h6", "p", "br", "ul", "ol", "li", "strong", "em", "del", "a", "blockquote", "code", "pre", "img"],
        ADD_ATTR: ["id", "class", "href", "target", "rel", "scroll-mt-24", "src", "alt", "title"]
      });

      renders.push(
        <div
          key={`txt-${index}`}
          className="custom-markdown-styles"
          dangerouslySetInnerHTML={{ __html: safeHtml }}
        />
      );

      if (index === 0) {
        renders.push(
          <AdSlot key={`ad-in-article-${index}`} name="in_article" />
        );
      }
    }

    return renders;
  });
};

export default function BlogDetails() {
  const { loginWithRedirect, isAuthenticated, user } = useAuth0();
  const offlineUser = getOfflineAuthUser();
  const effectiveUser = isAuthenticated && user?.email ? user : offlineUser;
  const effectiveAuthenticated = isAuthenticated || Boolean(offlineUser);
  const redirectWithReturn = () => loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } });
  const getImageUrl = (path) => {
    if (!path) return "";
    if (path.startsWith("http")) return path;
    const cleanPath = path.startsWith("/") ? path.slice(1) : path;
    return getApiUrl(cleanPath);
  };
  const { slug } = useParams();
  const navigate = useNavigate();
  const [blog, setBlog] = useState(null);
  const [error, setError] = useState(null);

  /* Reader */
  const [isReading, setIsReading] = useState(false);
  const [readerError, setReaderError] = useState(null);
  const utteranceRef = useRef(null);
  const chunksRef = useRef([]);
  const currentChunkIndexRef = useRef(0);
  const isReadingRef = useRef(false);

  /* Video Player */
  const [activeVideo, setActiveVideo] = useState(null);

  /* Reading Progress & TOC & Bookmarks */
  const [scrollProgress, setScrollProgress] = useState(0);
  const [headings, setHeadings] = useState([]);
  const [activeHeadingId, setActiveHeadingId] = useState("");
  const [showAllHeadings, setShowAllHeadings] = useState(false);
  const [copied, setCopied] = useState(false);
  
  const [bookmarks, setBookmarks] = useState(() => {
    try {
      const saved = localStorage.getItem("readxhub_bookmarks");
      return saved ? JSON.parse(saved) : [];
    } catch {
      return [];
    }
  });
  // Reaction UI state and timer reference
  const [showReactionPrompt, setShowReactionPrompt] = useState(false);
  const reactionTimerRef = useRef(null);

  /* Related Articles state */
  const [relatedBlogs, setRelatedBlogs] = useState([]);

  /* Report Blog state */
  const [isReportModalOpen, setIsReportModalOpen] = useState(false);
  const [reportEmail, setReportEmail] = useState("");
  const [reportNotes, setReportNotes] = useState("");
  const [isReporting, setIsReporting] = useState(false);
  const [reportSuccess, setReportSuccess] = useState(false);
  const [reportError, setReportError] = useState(null);
  const [isAuthorSubscribed, setIsAuthorSubscribed] = useState(false);
  const [authorSubscriptionLoading, setAuthorSubscriptionLoading] = useState(false);
  const [authorSubscriptionChecked, setAuthorSubscriptionChecked] = useState(false);
  const [authorSubscriptionMessage, setAuthorSubscriptionMessage] = useState("");
  const [guestSubscriberEmail, setGuestSubscriberEmail] = useState("");

  useEffect(() => {
    if (isAuthenticated && user?.email) {
      setReportEmail(user.email);
      setGuestSubscriberEmail(user.email);
    }
  }, [isAuthenticated, user]);

  useEffect(() => {
    if (!slug) return;

    fetch(getApiUrl(`fetch_single_blog_by_slug.php?slug=${encodeURIComponent(slug)}`))
      .then((res) => res.json())
      .then((data) => {
        if (data?.redirect) {
          navigate(data.redirect, { replace: true });
          return;
        }
        if (data?.error) {
          setError(data.error);
          return;
        }

        setBlog(data);

        const parsedHeadings = [];
        const htmlRegex = /<h([1-3])[^>]*>(.*?)<\/h\1>/g;
        let match;
        while ((match = htmlRegex.exec(data.content)) !== null) {
          const text = match[2].replace(/<[^>]*>/g, "").trim();
          const id = text
            .toLowerCase()
            .replace(/[^\w\s-]/g, "")

            .replace(/\s+/g, "-");
          parsedHeadings.push({ level: parseInt(match[1], 10), text, id });
        }

        if (parsedHeadings.length === 0) {
          const mdRegex = /^(#|##|###)\s+(.*)$/gm;
          let mdMatch;
          while ((mdMatch = mdRegex.exec(data.content)) !== null) {
            const level = mdMatch[1].length;
            const text = mdMatch[2].trim();
            const id = text
              .toLowerCase()
            .replace(/[^\w\s-]/g, "")

              .replace(/\s+/g, "-");
            parsedHeadings.push({ level, text, id });
          }
        }

        setHeadings(parsedHeadings);

        if (reactionTimerRef.current) {
          clearTimeout(reactionTimerRef.current);
        }
        const alreadyReacted = data.id && localStorage.getItem(`readxhub_reacted_${data.id}`);
        if (!alreadyReacted) {
          reactionTimerRef.current = setTimeout(() => setShowReactionPrompt(true), 150000);
        }
      })
      .catch(() => setError("Failed to load article content."));
  }, [slug, navigate]);

  useEffect(() => {
    if (!blog) return;

    const creatorIdentifier = blog.username || blog.email || '';
    if (!creatorIdentifier || !effectiveAuthenticated || !effectiveUser?.email) {
      setAuthorSubscriptionChecked(true);
      return;
    }

    const controller = new AbortController();
    const checkSubscription = async () => {
      try {
        const response = await fetch(
          getApiUrl(
            `subscribe.php?action=check&creator_identifier=${encodeURIComponent(
              creatorIdentifier
            )}&subscriber_email=${encodeURIComponent(effectiveUser.email)}`
          ),
          { signal: controller.signal, credentials: 'include' }
        );
        const data = await response.json();
        if (response.ok && !data.error) {
          setIsAuthorSubscribed(!!data.subscribed);
        }
      } catch (error) {
        console.error("Subscription check failed:", error);
      } finally {
        setAuthorSubscriptionChecked(true);
      }
    };

    checkSubscription();
    return () => controller.abort();
  }, [blog, isAuthenticated, user]);

  const handleSubscribeToggle = async (event) => {
    event?.preventDefault();
    if (!blog) return;

    if (!effectiveAuthenticated || !effectiveUser?.email) {
      setAuthorSubscriptionMessage('Please log in to subscribe to this author.');
      loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } });
      return;
    }

    const creatorIdentifier = blog.username || blog.email || '';
    const subscriberEmail = effectiveUser.email;

    if (!creatorIdentifier) {
      setAuthorSubscriptionMessage('Unable to determine the author identifier.');
      return;
    }

    setAuthorSubscriptionLoading(true);
    setAuthorSubscriptionMessage('');

    try {
      const action = isAuthorSubscribed ? 'unsubscribe' : 'subscribe';
      const response = await fetch(getApiUrl('subscribe.php'), {
        method: 'POST',
        credentials: 'include',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          action,
          creator_identifier: creatorIdentifier,
          subscriber_email: subscriberEmail
        })
      });
      const data = await response.json();

      if (response.ok && !data.error) {
        setIsAuthorSubscribed(!isAuthorSubscribed);
        setAuthorSubscriptionMessage(
          isAuthorSubscribed
            ? 'You are no longer subscribed to this author.'
            : 'Subscribed successfully. You will receive updates from this author.'
        );
        if (!isAuthorSubscribed) {
          playPopSound();
        }
      } else {
        throw new Error(data.error || 'Subscription request failed.');
      }
    } catch (err) {
      setAuthorSubscriptionMessage(err.message);
    } finally {
      setAuthorSubscriptionLoading(false);
    }
  };

  const handleGuestSubscribeSubmit = async (event) => {
    event.preventDefault();
    await handleSubscribeToggle(event);
  };

  const handleReportSubmit = async (event) => {
    event.preventDefault();
    if (!isAuthenticated || !user?.email) {
      setReportError('Please log in to report this article.');
      loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } });
      return;
    }

    if (!reportEmail || !reportEmail.trim()) {
      setReportError('Your email is required to submit the report.');
      return;
    }
    if (!reportNotes.trim()) {
      setReportError('Please provide details for the report.');
      return;
    }
    setIsReporting(true);
    setReportError(null);
    setReportSuccess(false);

    try {
      const response = await fetch(getApiUrl('report_blog.php'), {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          target_type: 'article',
          blog_id: blog.id,
          reporter_email: reportEmail.trim(),
          reported_user_email: blog.email || '',
          reported_user_name: blog.author || '',
          target_identifier: blog.slug,
          report_notes: reportNotes.trim(),
        }),
      });
      const data = await response.json();
      if (!response.ok || data.error) {
        throw new Error(data.error || 'Unable to submit report at this time.');
      }
      setReportSuccess(true);
      setReportNotes('');
    } catch (err) {
      console.error('Report submission failed:', err);
      setReportError(err.message || 'Report submission failed.');
    } finally {
      setIsReporting(false);
    }
  };

  const showSubscribeControl = Boolean(blog && (blog.username || blog.email));

  useEffect(() => {
    if (!slug) return;
    
    let viewTracked = false;
    
    const trackView = () => {
      if (viewTracked) return;
      viewTracked = true;
      fetch(
        getApiUrl(`track_blog_view.php?slug=${encodeURIComponent(slug)}`),
        { credentials: 'include' }
      ).catch(() => {});
    };

    // Track view after 15 seconds
    const creatorIdentifier = blog?.username || blog?.email || '';
    let timerId = null;
    timerId = setTimeout(() => {
      trackView();
    }, 15000);

    // Or track view if user scrolls 30% down the page
    const handleScroll = () => {
      if (window.scrollY > document.documentElement.scrollHeight * 0.3) {
        trackView();
      }
    };
    
    window.addEventListener('scroll', handleScroll, { passive: true });

    return () => {
      clearTimeout(timerId);
      window.removeEventListener('scroll', handleScroll);
    };
  }, [slug, blog, effectiveAuthenticated, effectiveUser]);

  // Cleanup reaction timer on component unmount
  useEffect(() => {
    return () => {
      if (reactionTimerRef.current) clearTimeout(reactionTimerRef.current);
    };
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

  /* ---------- Scroll Progress & TOC Tracker ---------- */
  useEffect(() => {
    const handleScroll = () => {
      const totalHeight = document.documentElement.scrollHeight - window.innerHeight;
      if (totalHeight > 0) {
        const scrolled = (window.scrollY / totalHeight) * 100;
        setScrollProgress(scrolled);
      }

      let currentActive = "";
      for (const heading of headings) {
        const element = document.getElementById(heading.id);
        if (element) {
          const rect = element.getBoundingClientRect();
          if (rect.top <= 120) {
            currentActive = heading.id;
          }
        }
      }
      setActiveHeadingId(currentActive);
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, [headings]);

  /* ---------- Bookmarks LocalStorage Sync ---------- */
  useEffect(() => {
    localStorage.setItem("readxhub_bookmarks", JSON.stringify(bookmarks));
  }, [bookmarks]);

  /* ---------- Cleanup Reader ---------- */
  useEffect(() => {
    return () => {
      isReadingRef.current = false;
      window.speechSynthesis?.cancel();
    };
  }, []);

  /* ---------- Reader ---------- */
  const playChunk = (index) => {
    if (!isReadingRef.current) return;
    if (index >= chunksRef.current.length) {
      setIsReading(false);
      isReadingRef.current = false;
      return;
    }

    currentChunkIndexRef.current = index;
    const chunkTextStr = chunksRef.current[index];

    if (!chunkTextStr || !chunkTextStr.trim()) {
      playChunk(index + 1);
      return;
    }

    const utter = new SpeechSynthesisUtterance(chunkTextStr);
    utter.lang = detectLanguage(chunkTextStr);
    utter.rate = 0.95;

    utter.onend = () => {
      if (isReadingRef.current) {
        playChunk(index + 1);
      }
    };

    utter.onerror = (e) => {
      if (e.error !== "interrupted") {
        setIsReading(false);
        isReadingRef.current = false;
      }
    };

    utteranceRef.current = utter;
    window.speechSynthesis.speak(utter);
  };

  const startReading = () => {
    try {
      const text = new DOMParser()
        .parseFromString(blog.content, "text/html")
        .body.innerText;

      window.speechSynthesis.cancel();

      const chunks = chunkText(text, 200);
      chunksRef.current = chunks;
      currentChunkIndexRef.current = 0;
      isReadingRef.current = true;
      setIsReading(true);

      if (chunks.length > 0) {
        playChunk(0);
      } else {
        setIsReading(false);
        isReadingRef.current = false;
      }
    } catch {
      setReaderError("Speech Synthesis engine failed to initialize.");
    }
  };

  const stopReading = () => {
    isReadingRef.current = false;
    setIsReading(false);
    window.speechSynthesis.cancel();
  };

  const copyToClipboard = () => {
    navigator.clipboard.writeText(window.location.href);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  const toggleBookmark = () => {
    setBookmarks(prev =>
      prev.includes(blog.id) ? prev.filter(id => id !== blog.id) : [...prev, blog.id]
    );
  };

  // Handle like/dislike reactions for the current blog
  const handleReaction = async (type) => {
    if (!blog) return;
    if (!effectiveAuthenticated) {
      alert("Please log in to react to this publication.");
      redirectWithReturn();
      return;
    }
    try {
      const res = await fetch(getApiUrl('like_dislike.php'), {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({ blog_id: blog.id, reaction: type, user_email: effectiveUser?.email })
      });
      if (res.status === 401) {
        alert("Session expired or unauthorized. Please log in again.");
        redirectWithReturn();
        return;
      }
      const data = await res.json();
      setBlog(prev => ({ ...prev, likes: data.likes, dislikes: data.dislikes, liked: type === 'like' }));
    } catch (err) {
      console.error('Reaction error', err);
    }
  };

  const getReadingTime = (text) => {
    const words = text ? text.split(" ").length : 65;
    const time = Math.max(1, Math.round(words / 200));
    return `${time} min read`;
  };

  /* ---------- States ---------- */
  if (error)
    return (
      <div className="min-h-screen flex items-center justify-center text-red-400 bg-[var(--paper)] p-6">
        <div className="bg-red-500/10 border border-red-500/20 p-6 rounded-2xl max-w-sm text-center">
          <p className="font-bold">{error}</p>
          <Link to="/" className="mt-4 inline-flex items-center gap-1.5 text-xs text-[var(--link)] font-semibold hover:underline">
            <FaArrowLeft /> Back to home
          </Link>
        </div>
      </div>
    );

  if (!blog)
    return (
      <div className="min-h-screen flex items-center justify-center bg-[var(--paper)]">
        <div className="w-full max-w-3xl px-6 space-y-6">
          <div className="h-8 w-2/3 skeleton-box rounded-lg" />
          <div className="h-4 w-1/3 skeleton-box rounded-lg" />
          <div className="h-96 w-full skeleton-box rounded-2xl" />
        </div>
      </div>
    );

  const plainText = new DOMParser()
    .parseFromString(blog.content, "text/html")
    .body.innerText;

  const seoDescription =
    blog.description ||
    (plainText.length > 155 ? plainText.slice(0, 152) + "…" : plainText);

  const toPublicUrl = (value, fallbackPath = `/blog/${blog.slug}`) => {
    const publicOrigin = "https://readxhub.in";
    if (!value) return `${publicOrigin}${fallbackPath}`;
    try {
      const parsed = new URL(value, publicOrigin);
      return `${publicOrigin}${parsed.pathname}${parsed.search}`;
    } catch {
      return `${publicOrigin}${fallbackPath}`;
    }
  };

  const canonicalUrl = toPublicUrl(blog.canonical_url);
  const featuredImage = blog.social_image || blog.featured_image_large || blog.featured_image || "";
  const absoluteFeaturedImage = featuredImage ? getImageUrl(featuredImage) : "";
  const shareTitle = encodeURIComponent(blog.title || "Read this article on ReadXHub");
  const shareUrl = encodeURIComponent(canonicalUrl);

  // JSON-LD Structured Data - ReadXHub Rebrand
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "TechArticle",
    "headline": blog.title,
    "description": seoDescription,
    "image": absoluteFeaturedImage ? [absoluteFeaturedImage] : undefined,
    "inLanguage": "en-US",
    "mainEntityOfPage": {
      "@type": "WebPage",
      "@id": canonicalUrl
    },
    "datePublished": blog.created_at,
    "dateModified": blog.updated_at || blog.created_at,
    "author": {
      "@type": "Person",
      "name": blog.author
    },
    "publisher": {
      "@type": "Organization",
      "name": "ReadXHub",
      "logo": {
        "@type": "ImageObject",
        "url": "https://readxhub.in/logo.png"
      }
    }
  };

  const suggestedQuestions = [
    `What is the main takeaway from this article about ${blog.title || 'this topic'}?`,
    `How can I apply the key ideas from this article in real research or projects?`,
    `Which points in this article should I verify further before relying on them?`,
    `Does the article look more like AI-generated content or human-written analysis, and why?`,
  ];

  // Render the report modal via a helper to avoid deep nested JSX/ternaries
  const renderReportModal = () => {
    if (!isReportModalOpen) return null;

    const container = (
      <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-[var(--paper-raised)]/90 backdrop-blur-sm">
        <div className="w-full max-w-md bg-[var(--paper-raised)]/95 border border-[var(--rule)] p-6 rounded-2xl shadow-2xl relative backdrop-blur-md">
          <h3 className="text-sm font-bold text-[var(--ink)] mb-2 flex items-center gap-2">
            <FaFlag className="text-red-500 text-xs" /> Report Article
          </h3>
          <p className="text-xs text-[var(--ink-soft)] mb-4 leading-relaxed">
            Help us keep ReadXHub safe and high-quality. Please explain what is wrong with this article.
          </p>
          {reportSuccess ? (
            <div className="p-4 rounded-xl bg-green-500/10 border border-green-500/20 text-green-400 text-xs font-semibold text-center flex flex-col items-center gap-2">
              <div className="w-8 h-8 rounded-full bg-green-500/20 flex items-center justify-center text-green-455 font-bold text-sm">✓</div>
              Report submitted successfully! Thank you.
            </div>
          ) : !isAuthenticated ? (
            <div className="rounded-2xl border border-[var(--rule)] bg-[var(--paper-raised)]/40 p-4 text-xs text-[var(--ink-soft)]">
              <p>Please log in to report this article. Your verified account email will be used for tracking and replies.</p>
              <button
                type="button"
                onClick={() => loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } })}
                className="mt-3 inline-flex items-center justify-center rounded-xl bg-[var(--stamp)] px-4 py-2 text-xs font-bold text-slate-950 transition hover:bg-[var(--stamp)]"
              >
                Login to Report
              </button>
            </div>
          ) : (
            <form onSubmit={handleReportSubmit} className="space-y-4">
              <div>
                <label className="block text-[10px] font-bold uppercase tracking-widest text-[var(--ink-soft)] mb-1.5">Your Email</label>
                <input
                  type="email"
                  value={reportEmail}
                  onChange={() => {}}
                  placeholder="name@email.com"
                  required
                  disabled
                  readOnly
                  className="w-full bg-[var(--paper-raised)]/50 border border-[var(--rule)] rounded-xl px-4 py-2.5 text-xs text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none opacity-60 cursor-not-allowed"
                />
              </div>

              <div>
                <label className="block text-[10px] font-bold uppercase tracking-widest text-[var(--ink-soft)] mb-1.5">Report Details</label>
                <textarea
                  value={reportNotes}
                  onChange={(e) => setReportNotes(e.target.value)}
                  placeholder="Tell us what is wrong (e.g. plagiarized content, broken code, misinformation, offensive content)..."
                  required
                  rows={4}
                  className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl px-4 py-2.5 text-xs text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none resize-none"
                />
              </div>

              {reportError && (
                <div className="text-2xs text-red-400 bg-red-500/10 border border-red-500/20 p-2.5 rounded-lg">{reportError}</div>
              )}

              <div className="flex items-center justify-end gap-2 pt-2">
                <button type="button" onClick={() => setIsReportModalOpen(false)} className="px-4 py-2 rounded-xl border border-[var(--rule)] text-[var(--ink-soft)] hover:bg-[var(--stamp-bg)] hover:text-[var(--ink)] text-xs font-semibold transition-all cursor-pointer">Cancel</button>
                <button type="submit" disabled={isReporting} className="px-4 py-2 rounded-xl bg-red-500 hover:bg-red-400 disabled:bg-red-500/50 text-[var(--ink)] text-xs font-semibold transition-all shadow-md cursor-pointer flex items-center gap-1.5">
                  {isReporting ? <span className="w-3 h-3 border border-white border-t-transparent rounded-full animate-spin" /> : null}
                  Submit Report
                </button>
              </div>
            </form>
          )}
        </div>
      </div>
    );

    return container;
  };

  return ( <>
    <main className="min-h-screen bg-[var(--paper)] text-[var(--ink)] selection:bg-[var(--stamp)]/30 selection:text-[var(--link)] pb-24">
      <SEO 
        title={`${blog.title} | ReadXHub`}
        description={seoDescription}
        keywords={blog.keywords || blog.focus_keyword}
        canonicalUrl={canonicalUrl}
        type="article"
        image={absoluteFeaturedImage}
        author={blog.author}
        publishedTime={blog.created_at}
        modifiedTime={blog.updated_at || blog.created_at}
      />
      <JsonLd data={jsonLd} />

      {/* Reading Progress Indicator */}
      <div 
        className="fixed top-16 left-0 h-[3px] bg-[var(--stamp)] z-50 transition-all duration-75"
        style={{ width: `${scrollProgress}%` }}
      />

      {/* Google AdSense TOP BANNER Placement */}
      <section className="max-w-7xl mx-auto px-6 pt-6">
        <AdSlot name="top_banner" placeholder="Top Banner Ad Slot" />
      </section>

      <article className="max-w-7xl mx-auto px-6 pt-6">
        {/* Back Link */}
        <Link 
          to="/" 
          className="inline-flex items-center gap-1.5 text-xs text-[var(--ink-soft)] hover:text-[var(--stamp)] transition-colors mb-6 font-medium"
        >
          <FaArrowLeft /> Back to publications
        </Link>

        {/* Heading metadata */}
        <header className="mb-10 max-w-4xl border-b border-[var(--rule)] pb-8 relative group">
          <h1 className="text-3xl md:text-4xl lg:text-5xl font-extrabold text-[var(--ink)] tracking-tight leading-tight mb-6">
            {blog.title}
          </h1>

          <div className="flex flex-wrap justify-between items-center gap-4 text-xs text-[var(--ink-soft)]">
            <div className="flex flex-wrap gap-4 items-center">
              <span className="flex items-center gap-1.5">
                {blog.profile_picture ? (
                  <img
                    src={getImageUrl(blog.profile_picture)}
                    alt={blog.author}
                    className="w-5 h-5 rounded-full object-cover border border-[var(--rule-strong)] bg-[var(--stamp-bg)]"
                    referrerPolicy="no-referrer"
                  />
                ) : (
                  <span className="w-5 h-5 rounded-full bg-[var(--stamp-bg)] flex items-center justify-center text-[var(--ink-soft)] border border-[var(--rule-strong)]">
                    <FaUser className="text-[10px]" />
                  </span>
                )}
                <span className="font-semibold text-[var(--ink-soft)]">
                  {blog.email ? (
                    <Link to={`/author/${blog.username || blog.email}`} className="text-[var(--ink-soft)] hover:text-[var(--link)] hover:underline">{blog.author}</Link>
                  ) : (
                    blog.author
                  )}
                </span>
              </span>
              <span className="text-[var(--rule-strong)]">•</span>
              <span className="flex items-center gap-1.5">
                <FaCalendarAlt className="text-[var(--stamp)]" />
                {new Date(blog.created_at || blog.publish_date).toLocaleDateString("en-IN", {
                  year: "numeric",
                  month: "long",
                  day: "numeric"
                })}
              </span>
              <span className="text-[var(--rule-strong)]">•</span>
              <span className="flex items-center gap-1.5">
                <FaBookOpen className="text-[var(--stamp)]" />
                {blog.reading_time || 2} min read
              </span>
              <span className="text-[var(--rule-strong)]">•</span>
              <span className="flex items-center gap-1.5">
                <FaEye className="text-[var(--stamp)]" />
                {blog.views || 0} views
              </span>
            </div>

            {/* Action buttons (Vote, Bookmark, History, Report) */}
            <div className="flex items-center gap-3">
              {/* Signature vote rail */}
              <VoteRail
                score={(blog.likes ?? 0) - (blog.dislikes ?? 0)}
                myVote={blog.liked === true ? "up" : blog.liked === false ? "down" : null}
                onVote={(dir) => handleReaction(dir === "up" ? "like" : "dislike")}
              />
              {/* Bookmark */}
              <button 
                onClick={toggleBookmark}
                className="flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-[var(--paper-raised)] border border-[var(--rule)] text-[var(--ink-soft)] hover:text-[var(--link)] hover:border-[var(--stamp)]/20 transition-all cursor-pointer shadow-sm"
                title={bookmarks.includes(blog.id) ? "Remove Bookmark" : "Save Bookmark"}
              >
                {bookmarks.includes(blog.id) ? <FaBookmark className="text-[var(--stamp)] text-xs" /> : <FaRegBookmark className="text-xs" />}
              </button>
              {/* Revision history — Wikipedia-style "View history" */}
              <RevisionHistory blogId={blog.id} />
              {/* Report */}
              <button 
                onClick={() => setIsReportModalOpen(true)}
                className="flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-[var(--paper-raised)] border border-[var(--rule)] text-[var(--ink-soft)] hover:text-red-400 hover:border-red-500/20 transition-all cursor-pointer shadow-sm"
                title="Report this article"
              >
                <FaFlag className="text-xs" />
                <span className="text-xs font-semibold">Report</span>
              </button>
            </div>

            {showSubscribeControl && (
              <div className="mt-4 space-y-3 w-full">
                {authorSubscriptionMessage && (
                  <div className={`rounded-2xl border px-4 py-3 text-xs ${authorSubscriptionMessage.includes('Subscribed') ? 'bg-emerald-950/20 border-emerald-800 text-emerald-300' : 'bg-[var(--paper-raised)]/80 border-[var(--rule)] text-[var(--ink-soft)]'}`}>
                    {authorSubscriptionMessage}
                  </div>
                )}

                {isAuthenticated ? (
                  <button
                    onClick={handleSubscribeToggle}
                    disabled={authorSubscriptionLoading}
                    className={`inline-flex items-center gap-2 rounded-xl px-4 py-2 text-xs font-bold transition-all shadow-sm ${isAuthorSubscribed ? 'bg-[var(--paper-raised)] border border-[var(--rule)] text-[var(--ink-soft)] hover:text-[var(--link)] hover:border-[var(--stamp)]/20' : 'bg-[var(--stamp)] text-slate-950 hover:bg-[var(--stamp)]'}`}
                  >
                    {authorSubscriptionLoading ? <FaSpinner className="animate-spin" /> : isAuthorSubscribed ? 'Subscribed' : 'Subscribe'}
                  </button>
                ) : (
                  <div className="rounded-2xl border border-[var(--rule)] bg-[var(--paper-raised)]/40 p-4 text-xs text-[var(--ink-soft)]">
                    <p>Please log in to subscribe to this author. Subscriptions are tied to your verified account email.</p>
                    <button
                      type="button"
                      onClick={() => loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } })}
                      className="mt-3 inline-flex items-center justify-center rounded-xl bg-[var(--stamp)] px-4 py-2 text-xs font-bold text-slate-950 transition hover:bg-[var(--stamp)]"
                    >
                      Login to Subscribe
                    </button>
                  </div>
                )}
              </div>
            )}
          </div>

          {/* TTS Audio Controls */}
          <div className="mt-8 flex items-center gap-3">
            {!isReading ? (
              <button
                onClick={startReading}
                className="flex items-center gap-2 px-4 py-2 rounded-xl bg-[var(--stamp)]/10 hover:bg-[var(--stamp)]/20 text-[var(--link)] border border-[var(--stamp)]/20 text-xs font-bold transition-all cursor-pointer"
              >
                <FaPlay className="text-[10px]" /> Read Article Aloud
              </button>
            ) : (
              <button
                onClick={stopReading}
                className="flex items-center gap-2 px-4 py-2 rounded-xl bg-red-500/10 hover:bg-red-500/20 text-red-400 border border-red-500/20 text-xs font-bold transition-all cursor-pointer"
              >
                <FaPause className="text-[10px]" /> Stop Reader Voice
              </button>
            )}
            {readerError && <span className="text-2xs text-red-400">{readerError}</span>}
          </div>
        </header>

        

        {blog.featured_image && blog.featured_image !== 'null' && blog.featured_image !== 'undefined' && (
          <figure className="mb-12 mt-6 w-full rounded-2xl overflow-hidden shadow-2xl border border-[var(--rule)] bg-[var(--paper-raised)]/50">
            <picture>
              {blog.featured_image_large && blog.featured_image_large !== 'null' && blog.featured_image_large !== 'undefined' && <source srcSet={getImageUrl(blog.featured_image_large)} media="(min-width: 1024px)" />}
              {blog.featured_image_medium && blog.featured_image_medium !== 'null' && blog.featured_image_medium !== 'undefined' && <source srcSet={getImageUrl(blog.featured_image_medium)} media="(min-width: 768px)" />}
              <img 
                src={getImageUrl((blog.featured_image_thumb && blog.featured_image_thumb !== 'null' && blog.featured_image_thumb !== 'undefined') ? blog.featured_image_thumb : blog.featured_image)} 
                alt={blog.image_alt || blog.title} 
                className="w-full h-auto object-cover max-h-[600px]"
                loading="eager"
                decoding="async"
                width={1200}
                height={630}
              />
            </picture>
            {(blog.image_caption || blog.image_credit) && (
              <figcaption className="p-3 text-center text-xs text-[var(--ink-soft)] border-t border-[var(--rule)] bg-[var(--paper-raised)]/50">
                {blog.image_caption}
                {blog.image_caption && blog.image_credit && ' | '}
                {blog.image_credit && <span className="italic">Credit: {blog.image_credit}</span>}
              </figcaption>
            )}
          </figure>
        )}

        {/* Layout split */}
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-10">
          
          {/* LEFT SIDEBAR: Table of Contents & Adsense block */}
          <aside className="hidden lg:block lg:col-span-3 sticky top-28 h-fit max-h-[75vh] overflow-y-auto pr-4 border-r border-[var(--rule)] scrollbar-none space-y-8">
            <div>
              <h4 className="text-[10px] font-bold uppercase tracking-widest text-[var(--ink-soft)] mb-4">Table of contents</h4>
              {headings.length === 0 ? (
                <p className="text-xs italic text-[var(--ink-soft)]">No content headers found.</p>
              ) : (
                <>
                  <ul className="space-y-3">
                    {(showAllHeadings ? headings : headings.slice(0, 5)).map((heading, i) => (
                      <li 
                        key={i} 
                        style={{ paddingLeft: `${Math.max(0, heading.level - 1) * 12}px` }}
                      >
                        <a 
                          href={`#${heading.id}`}
                          className={`block text-xs font-medium transition-colors hover:text-[var(--link)] ${
                            activeHeadingId === heading.id 
                              ? "text-[var(--link)] border-l-2 border-[var(--stamp)] pl-2 -ml-[2px]" 
                              : "text-[var(--ink-soft)]"
                          }`}
                        >
                          {heading.text}
                        </a>
                      </li>
                    ))}
                  </ul>
                  {headings.length > 5 && (
                    <button
                      onClick={() => setShowAllHeadings(!showAllHeadings)}
                      className="mt-3 text-[10px] font-bold text-[var(--link)] hover:text-[var(--link)] transition-colors uppercase tracking-wider flex items-center gap-1 cursor-pointer focus:outline-none"
                    >
                      {showAllHeadings ? "See Less" : `+ See More (${headings.length - 5} more)`}
                    </button>
                  )}
                </>
              )}
            </div>

            {/* Google AdSense SIDEBAR Placement */}
            <AdSlot name="sidebar" placeholder="Sidebar Ad Slot" />
          </aside>

          {/* CENTER: Content */}
          <section className="lg:col-span-7 space-y-10 max-w-none">
            <div className="article-body font-sans">
              {parseContent(blog.content, setActiveVideo)}
            </div>

            {/* RELATED ARTICLES RECOMMENDER SECTION */}
            {relatedBlogs.length > 0 && (
              <div className="border-t border-[var(--rule)]/80 pt-8 mt-12 space-y-6">
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
<section className="mb-10 rounded-3xl border border-[var(--rule)] bg-[var(--paper-raised)]/70 p-6 shadow-2xl">
          {/* <div className="mb-6 rounded-3xl border border-[var(--rule)]/70 bg-[var(--paper-raised)]/70 p-5">
            <h2 className="text-sm font-semibold uppercase tracking-[0.24em] text-[var(--ink-soft)] mb-3">Suggested questions</h2>
            <div className="grid gap-3 sm:grid-cols-2">
              {suggestedQuestions.map((question, index) => (
                <button
                  key={index}
                  type="button"
                  onClick={() => navigator.clipboard.writeText(question)}
                  className="text-left rounded-2xl border border-[var(--rule)]/70 bg-[var(--paper-raised)]/80 p-4 text-sm text-[var(--ink)] transition hover:border-[var(--stamp)]/40 hover:bg-[var(--paper-raised)]"
                >
                  <span className="block text-[var(--ink-soft)] text-[11px] uppercase tracking-[0.24em] mb-2">Suggestion {index + 1}</span>
                  {question}
                </button>
              ))}
            </div>
            <p className="mt-4 text-[11px] text-[var(--ink-soft)]">Tap a suggestion to copy it and ask the assistant directly.</p>
          </div> */}
          
          <ArticleAssistant
            title="Kriti A.I"
            description="Ask about this article, request a summary, or get clarity on the topic without leaving the page."
            placeholder="Ask a question about this article..."
            contextLabel="Article excerpt"
            context={plainText.slice(0, 1200)}
          />
        </section>
            {/* Comments thread */}
            <div className="mt-16 pt-8 border-t border-[var(--rule)]">
              <CommentBox blogId={blog.id} />
            </div>
          </section>

          {/* RIGHT SIDEBAR: Float Sharing tools */}
          <aside className="lg:col-span-2 sticky top-28 h-fit flex lg:flex-col justify-center lg:justify-start gap-3 pb-6 border-t lg:border-t-0 border-[var(--rule)]/40 pt-6 lg:pt-0">
            <span className="hidden lg:block text-[10px] font-bold uppercase tracking-widest text-[var(--ink-soft)] mb-2">Share Article</span>
            
            <a 
              href={`https://wa.me/?text=${shareTitle}%20-%20${shareUrl}`}
              target="_blank"
              rel="noopener noreferrer"
              className="w-10 h-10 rounded-xl bg-[var(--paper-raised)] border border-[var(--rule)] flex items-center justify-center text-[var(--ink-soft)] hover:text-green-500 hover:border-green-500/30 transition-all hover:scale-105"
              title="Share on WhatsApp"
            >
              <FaWhatsapp className="text-sm" />
            </a>

            <a 
              href={`https://www.facebook.com/sharer/sharer.php?u=${shareUrl}`}
              target="_blank"
              rel="noopener noreferrer"
              className="w-10 h-10 rounded-xl bg-[var(--paper-raised)] border border-[var(--rule)] flex items-center justify-center text-[var(--ink-soft)] hover:text-blue-500 hover:border-blue-500/30 transition-all hover:scale-105"
              title="Share on Facebook"
            >
              <FaFacebookF className="text-sm" />
            </a>

            <a 
              href={`https://twitter.com/intent/tweet?url=${shareUrl}&text=${shareTitle}`}
              target="_blank"
              rel="noopener noreferrer"
              className="w-10 h-10 rounded-xl bg-[var(--paper-raised)] border border-[var(--rule)] flex items-center justify-center text-[var(--ink-soft)] hover:text-[var(--link)] hover:border-[var(--stamp)]/30 transition-all hover:scale-105"
              title="Share on Twitter"
            >
              <FaTwitter className="text-sm" />
            </a>

            <a 
              href={`https://www.linkedin.com/shareArticle?url=${shareUrl}&title=${shareTitle}`}
              target="_blank"
              rel="noopener noreferrer"
              className="w-10 h-10 rounded-xl bg-[var(--paper-raised)] border border-[var(--rule)] flex items-center justify-center text-[var(--ink-soft)] hover:text-blue-400 hover:border-blue-400/30 transition-all hover:scale-105"
              title="Share on LinkedIn"
            >
              <FaLinkedinIn className="text-sm" />
            </a>

            <button
              onClick={copyToClipboard}
              className="w-10 h-10 rounded-xl bg-[var(--paper-raised)] border border-[var(--rule)] flex items-center justify-center text-[var(--ink-soft)] hover:text-[var(--link)] hover:border-[var(--stamp)]/30 transition-all hover:scale-105 cursor-pointer"
              title="Copy Link"
            >
              {copied ? <FaCheck className="text-sm text-[var(--link)]" /> : <FaCopy className="text-sm" />}
            </button>
          </aside>

        </div>
      </article>

      {/* Google AdSense FOOTER Placement */}
      <section className="max-w-7xl mx-auto px-6 pt-10">
        <AdSlot name="footer_banner" placeholder="Footer Banner Ad Slot" />
      </section>

      {/* Video Overlay */}
      {activeVideo && (
        <FullScreenVideoPlayer
          videoId={activeVideo}
          onClose={() => setActiveVideo(null)}
        />
      )}
    </main>
    <ReactionPromptModal
      isOpen={showReactionPrompt}
      onClose={() => setShowReactionPrompt(false)}
      onReact={handleReaction}
      blogId={blog?.id}
    />

    {renderReportModal()}
  </>
  );
}
