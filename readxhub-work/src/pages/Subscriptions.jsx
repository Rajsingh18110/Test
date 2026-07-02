import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import { useAuth0 } from "@auth0/auth0-react";
import { getOfflineAuthUser } from "../utils/auth.js";
import { 
    FaUsers, FaBookOpen, FaUser, FaClock, FaEye, 
    FaThumbsUp, FaThumbsDown, FaBookmark, FaRegBookmark, 
    FaSpinner, FaRss, FaArrowRight, FaSignInAlt
} from "react-icons/fa";
import { getApiUrl } from "../utils/api.js";

export default function Subscriptions() {
    const { user, isAuthenticated, loginWithRedirect, isLoading: authLoading } = useAuth0();
    const offlineUser = getOfflineAuthUser();
    const effectiveUser = isAuthenticated && user?.email ? user : offlineUser;
    const effectiveAuthenticated = isAuthenticated || Boolean(offlineUser);
    
    const [activeTab, setActiveTab] = useState("feed"); // "feed" or "creators"
    const [creators, setCreators] = useState([]);
    const [posts, setPosts] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    
    // Bookmarks and reactions local state management
    const [bookmarks, setBookmarks] = useState(() => {
        try {
            const saved = localStorage.getItem("readxhub_bookmarks");
            return saved ? JSON.parse(saved) : [];
        } catch {
            return [];
        }
    });

    useEffect(() => {
        localStorage.setItem("readxhub_bookmarks", JSON.stringify(bookmarks));
    }, [bookmarks]);

    const fetchSubscriptionsData = () => {
        if (effectiveAuthenticated && effectiveUser?.email) {
            setLoading(true);
            setError(null);
            fetch(getApiUrl(`subscribe.php?action=get_feed&subscriber_email=${encodeURIComponent(effectiveUser.email)}`), {
                credentials: "include"
            })
            .then(res => {
                if (!res.ok) {
                    throw new Error("Failed to fetch subscriptions data.");
                }
                return res.json();
            })
            .then(data => {
                setCreators(data.creators || []);
                setPosts(data.posts || []);
            })
            .catch(err => {
                console.error("Error loading subscriptions:", err);
                setError("Failed to load your subscriptions feed. Please check your internet connection.");
            })
            .finally(() => {
                setLoading(false);
            });
        } else {
            setLoading(false);
        }
    };

    useEffect(() => {
        if (!authLoading) {
            fetchSubscriptionsData();
        }
        // eslint-disable-next-line
    }, [isAuthenticated, user, authLoading]);

    const toggleBookmark = (e, blogId) => {
        e.preventDefault();
        e.stopPropagation();
        setBookmarks(prev => 
            prev.includes(blogId) ? prev.filter(id => id !== blogId) : [...prev, blogId]
        );
    };

    const handleReaction = async (e, blogId, reactionType) => {
        e.preventDefault();
        e.stopPropagation();
        if (!effectiveAuthenticated || !effectiveUser?.email) {
            alert("Please log in to react to this publication.");
            loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } });
            return;
        }

        try {
            const res = await fetch(getApiUrl("like_dislike.php"), {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                credentials: "include",
                body: JSON.stringify({ blog_id: blogId, reaction: reactionType, user_email: effectiveUser?.email })
            });

            if (res.status === 401) {
                alert("Session expired or unauthorized. Please log in again.");
                loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } });
                return;
            }

            const data = await res.json();
            setPosts(prevPosts => 
                prevPosts.map(p => p.id === blogId ? { ...p, likes: data.likes, dislikes: data.dislikes } : p)
            );
        } catch (err) {
            console.error("Reaction submission failed:", err);
        }
    };

    const getReadingTime = (desc) => {
        const words = desc ? desc.split(" ").length : 0;
        return `${Math.max(1, Math.round(words / 200))} min read`;
    };

    if (authLoading || (isAuthenticated && loading)) {
        return (
            <div className="min-h-screen flex items-center justify-center bg-[var(--paper)] text-[var(--ink)]">
                <div className="flex flex-col items-center gap-3">
                    <FaSpinner className="animate-spin text-3xl text-[var(--link)]" />
                    <p className="text-xs font-bold uppercase tracking-wider text-[var(--ink-soft)]">Loading your feed...</p>
                </div>
            </div>
        );
    }

    if (!effectiveAuthenticated) {
        return (
            <div className="min-h-screen flex flex-col items-center justify-center bg-[var(--paper)] text-[var(--ink)] p-6">
                <motion.div 
                    initial={{ opacity: 0, y: 15 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.4 }}
                    className="bg-[var(--paper-raised)]/40 border border-[var(--rule)] p-8 rounded-2xl max-w-md text-center shadow-2xl backdrop-blur-md"
                >
                    <div className="w-16 h-16 bg-gradient-to-tr from-[var(--stamp)]/10 to-blue-500/10 border border-[var(--stamp)]/20 rounded-2xl flex items-center justify-center text-[var(--link)] mx-auto mb-6">
                        <FaUsers className="text-3xl animate-pulse" />
                    </div>
                    <h2 className="text-xl font-extrabold text-[var(--ink)] tracking-tight">Access Your Subscriptions</h2>
                    <p className="text-slate-450 text-xs mt-3 leading-relaxed">
                        Join ReadXHub or log in to view recent updates, publications, and dashboard stats from creators you subscribe to.
                    </p>
                    <button 
                        onClick={() => loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } })}
                        className="mt-6 w-full py-2.5 px-4 rounded-xl bg-gradient-to-r from-[var(--stamp)] to-[#B47A22] hover:from-[#B47A22] hover:to-[#9A6A1C] text-slate-950 font-bold text-xs shadow-md shadow-black/5 active:scale-[0.98] transition-all flex items-center justify-center gap-1.5 cursor-pointer"
                    >
                        <FaSignInAlt /> Login / Sign Up
                    </button>
                </motion.div>
            </div>
        );
    }

    return (
        <main className="min-h-screen bg-[var(--paper)] text-[var(--ink)] pb-20 selection:bg-[var(--stamp)]/30 selection:text-[var(--link)]">
            {/* Header Banner */}
            <section className="relative overflow-hidden pt-12 pb-10 border-b border-[var(--rule)] bg-gradient-to-b from-[var(--paper)] via-[var(--paper)] to-[var(--paper)]">
                <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_top,_var(--tw-gradient-stops))] from-[var(--stamp-bg)] via-transparent to-transparent pointer-events-none" />
                <div className="max-w-7xl mx-auto px-6 relative z-10 text-center">
                    <h1 className="text-3xl sm:text-4xl font-extrabold tracking-tight text-[var(--ink)]">
                        Your Subscriptions
                    </h1>
                    <p className="text-[var(--ink-soft)] text-xs sm:text-sm mt-3 max-w-xl mx-auto leading-relaxed">
                        Stay updated with search guides, programming structures, and recent notifications from creators you follow.
                    </p>
                </div>
            </section>

            <div className="max-w-7xl mx-auto px-6 pt-8">
                {error && (
                    <div className="bg-red-500/10 border border-red-500/20 p-5 rounded-2xl text-center text-red-400 text-xs font-semibold mb-6">
                        {error}
                        <button onClick={fetchSubscriptionsData} className="ml-3 underline hover:text-red-300">Retry</button>
                    </div>
                )}

                {/* Tabs Layout */}
                <div className="flex items-center space-x-2 border-b border-[var(--rule)]/65 pb-3">
                    <button 
                        onClick={() => setActiveTab("feed")}
                        className={`px-4 py-2 rounded-xl text-xs font-bold whitespace-nowrap border transition-all cursor-pointer ${
                            activeTab === "feed"
                            ? "bg-[var(--stamp)]/10 border-[var(--stamp)]/30 text-[var(--link)] shadow-sm"
                            : "bg-[var(--paper-raised)]/30 border-[var(--rule)] text-slate-455 hover:text-[var(--ink)]"
                        }`}
                    >
                        <FaRss className="inline mr-1.5 text-[10px]" /> Articles Feed
                    </button>
                    <button 
                        onClick={() => setActiveTab("creators")}
                        className={`px-4 py-2 rounded-xl text-xs font-bold whitespace-nowrap border transition-all cursor-pointer ${
                            activeTab === "creators"
                            ? "bg-[var(--stamp)]/10 border-[var(--stamp)]/30 text-[var(--link)] shadow-sm"
                            : "bg-[var(--paper-raised)]/30 border-[var(--rule)] text-slate-455 hover:text-[var(--ink)]"
                        }`}
                    >
                        <FaUsers className="inline mr-1.5 text-[10px]" /> Subscribed Creators ({creators.length})
                    </button>
                </div>

                <div className="mt-8">
                    {activeTab === "feed" ? (
                        /* ARTICLES FEED TAB */
                        posts.length === 0 ? (
                            <div className="max-w-md mx-auto text-center py-16 space-y-4">
                                <div className="w-12 h-12 bg-[var(--paper-raised)]/80 border border-[var(--rule)] rounded-xl flex items-center justify-center text-[var(--ink-soft)] mx-auto">
                                    <FaBookOpen className="text-xl" />
                                </div>
                                <div className="space-y-1">
                                    <h3 className="text-sm font-bold text-[var(--ink)]">Your Feed is Empty</h3>
                                    <p className="text-[var(--ink-soft)] text-xs leading-relaxed max-w-xs mx-auto">
                                        No recent articles found. Subscribe to creators to see their engineering updates here.
                                    </p>
                                </div>
                                <Link 
                                    to="/" 
                                    className="inline-flex items-center gap-1.5 px-4 py-2 rounded-xl bg-[var(--paper-raised)] border border-[var(--rule)] text-[var(--stamp)] hover:text-[var(--link)] text-xs font-bold transition-all shadow-md active:scale-98"
                                >
                                    Browse Creators <FaArrowRight className="text-[10px]" />
                                </Link>
                            </div>
                        ) : (
                            <div className="space-y-4 max-w-4xl">
                                {posts.map(blog => (
                                    <motion.article
                                        key={`sub-feed-${blog.id}`}
                                        whileHover={{ x: 3 }}
                                        transition={{ duration: 0.2 }}
                                        className="group rounded-2xl bg-[var(--paper-raised)]/30 border border-[var(--rule)] p-5 hover:border-[var(--rule-strong)]/60 hover:bg-[var(--paper-raised)]/50 transition-all flex flex-col md:flex-row gap-5"
                                    >
                                        <div className="w-full md:w-36 h-24 rounded-xl bg-gradient-to-r from-slate-950 to-slate-900 border border-[var(--rule)]/50 flex-shrink-0 flex items-center justify-center relative">
                                            <FaBookOpen className="text-slate-850 text-xl" />
                                            <div className="absolute top-2 right-2 flex space-x-1">
                                                <button 
                                                    onClick={(e) => toggleBookmark(e, blog.id)}
                                                    className="p-1.5 rounded bg-[var(--paper-raised)]/90 border border-[var(--rule)] text-[var(--ink-soft)] hover:text-[var(--link)] transition-all cursor-pointer"
                                                    title={bookmarks.includes(blog.id) ? "Remove Bookmark" : "Save Bookmark"}
                                                >
                                                    {bookmarks.includes(blog.id) ? <FaBookmark className="text-[var(--stamp)] text-[10px]" /> : <FaRegBookmark className="text-[10px]" />}
                                                </button>
                                                <button 
                                                    onClick={(e) => handleReaction(e, blog.id, 'like')}
                                                    className="p-1.5 rounded bg-[var(--paper-raised)]/90 border border-[var(--rule)] text-[var(--ink-soft)] hover:text-green-400 transition-all cursor-pointer"
                                                    title="Like"
                                                >
                                                    <FaThumbsUp className="text-[10px]" /> {blog.likes || 0}
                                                </button>
                                                <button 
                                                    onClick={(e) => handleReaction(e, blog.id, 'dislike')}
                                                    className="p-1.5 rounded bg-[var(--paper-raised)]/90 border border-[var(--rule)] text-[var(--ink-soft)] hover:text-red-400 transition-all cursor-pointer"
                                                    title="Dislike"
                                                >
                                                    <FaThumbsDown className="text-[10px]" /> {blog.dislikes || 0}
                                                </button>
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
                                                <span className="text-3xs text-slate-455 flex items-center gap-1.5">
                                                    <img 
                                                        src={blog.profile_picture} 
                                                        alt={blog.author} 
                                                        className="w-4 h-4 rounded-full object-cover border border-[var(--rule-strong)]" 
                                                    />
                                                    {blog.email ? (
                                                        <Link to={`/author/${blog.username || blog.email}`} className="hover:text-[var(--link)] hover:underline">{blog.author}</Link>
                                                    ) : (
                                                        blog.author
                                                    )}
                                                </span>
                                                <Link to={`/blog/${blog.slug}`} className="text-3xs text-[var(--link)] font-bold hover:underline flex items-center gap-0.5">
                                                    Read Article <FaArrowRight className="text-[9px]" />
                                                </Link>
                                            </div>
                                        </div>
                                    </motion.article>
                                ))}
                            </div>
                        )
                    ) : (
                        /* SUBSCRIBED CREATORS TAB */
                        creators.length === 0 ? (
                            <div className="max-w-md mx-auto text-center py-16 space-y-4">
                                <div className="w-12 h-12 bg-[var(--paper-raised)]/80 border border-[var(--rule)] rounded-xl flex items-center justify-center text-[var(--ink-soft)] mx-auto">
                                    <FaUsers className="text-xl" />
                                </div>
                                <div className="space-y-1">
                                    <h3 className="text-sm font-bold text-[var(--ink)]">No Subscriptions Yet</h3>
                                    <p className="text-[var(--ink-soft)] text-xs leading-relaxed max-w-xs mx-auto">
                                        Explore ReadXHub and subscribe to authors you want to follow.
                                    </p>
                                </div>
                                <Link 
                                    to="/" 
                                    className="inline-flex items-center gap-1.5 px-4 py-2 rounded-xl bg-[var(--paper-raised)] border border-[var(--rule)] text-[var(--stamp)] hover:text-[var(--link)] text-xs font-bold transition-all"
                                >
                                    Explore Articles
                                </Link>
                            </div>
                        ) : (
                            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
                                {creators.map(creator => (
                                    <motion.div
                                        key={`sub-creator-${creator.email}`}
                                        whileHover={{ y: -3 }}
                                        className="bg-[var(--paper-raised)]/40 border border-[var(--rule)] rounded-2xl p-5 text-center flex flex-col justify-between items-center h-full relative"
                                    >
                                        <div className="flex flex-col items-center">
                                            <img 
                                                src={creator.profile_picture} 
                                                alt={creator.name} 
                                                className="w-16 h-16 rounded-full object-cover border-2 border-[var(--rule)] mb-3 shadow-md"
                                            />
                                            <h4 className="text-sm font-bold text-[var(--ink)] leading-tight">
                                                {creator.name}
                                            </h4>
                                            <p className="text-[10px] text-[var(--stamp)] font-semibold mb-2">@{creator.username || "creator"}</p>
                                            <p className="text-2xs text-slate-455 line-clamp-2 leading-relaxed px-2">
                                                {creator.bio}
                                            </p>
                                        </div>
                                        <div className="w-full mt-4 pt-4 border-t border-slate-950 flex justify-center">
                                            <Link 
                                                to={`/author/${creator.username || creator.email}`}
                                                className="text-xs text-[var(--stamp)] hover:text-[var(--link)] font-bold transition-colors inline-flex items-center gap-1"
                                            >
                                                View Creator Profile <FaArrowRight className="text-[9px]" />
                                            </Link>
                                        </div>
                                    </motion.div>
                                ))}
                            </div>
                        )
                    )}
                </div>
            </div>
        </main>
    );
}
