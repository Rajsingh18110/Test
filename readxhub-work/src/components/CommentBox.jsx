import React, { useState, useEffect, useMemo } from "react";
import { useAuth0 } from "@auth0/auth0-react";
import { motion, AnimatePresence } from "framer-motion";
import { 
    FaReply, FaTrash, FaEdit, FaSpinner, FaSignInAlt, 
    FaCheck, FaTimes, FaSave, FaCommentAlt, FaUserCircle, FaFlag 
} from "react-icons/fa";
import { getApiUrl } from "../utils/api.js";
import VoteRail from "./VoteRail.jsx";
const CommentBox = ({ blogId }) => {
    const { user, isAuthenticated, loginWithRedirect } = useAuth0();

    const getAvatarUrl = (url) => {
        if (!url || url === 'null' || url === 'undefined') return null;
        return url.startsWith('http') ? url : `https://blogs.readxhub.in/${url.startsWith('/') ? url.slice(1) : url}`;
    };

    const renderCommentText = (commentId, text, className) => {
        const limit = 250;
        if (!text || text.length <= limit) {
            return <p className={className}>{text}</p>;
        }

        const isExpanded = !!expandedComments[commentId];
        const displayText = isExpanded ? text : text.slice(0, limit) + "...";

        return (
            <div>
                <p className={className}>{displayText}</p>
                <button
                    onClick={() => setExpandedComments(prev => ({ ...prev, [commentId]: !isExpanded }))}
                    className="text-[10px] text-[var(--link)] hover:text-[var(--link)] transition-colors font-bold mt-1 cursor-pointer focus:outline-none"
                >
                    {isExpanded ? "See Less" : "See More"}
                </button>
            </div>
        );
    };

    const [comments, setComments] = useState([]);
    const [newComment, setNewComment] = useState("");
    const [replyToId, setReplyToId] = useState(null);
    const [replyText, setReplyText] = useState("");
    const [editingId, setEditingId] = useState(null);
    const [editingText, setEditingText] = useState("");

    const [expandedComments, setExpandedComments] = useState({});
    const [isFetchingComments, setIsFetchingComments] = useState(true);
    const [isPostingComment, setIsPostingComment] = useState(false);
    const [isPostingReply, setIsPostingReply] = useState(false);
    const [reportingCommentId, setReportingCommentId] = useState(null);
    const [commentReportNotes, setCommentReportNotes] = useState({});
    const [commentReportLoading, setCommentReportLoading] = useState(false);
    const [commentReportMessage, setCommentReportMessage] = useState({});
    const [error, setError] = useState(null);

    /* ---------- Comment voting (Reddit-style) ---------- */
    const [commentScores, setCommentScores] = useState({});
    const [myCommentVotes, setMyCommentVotes] = useState({});

    const fetchCommentVotes = async () => {
        if (!blogId) return;
        try {
            const emailParam = user?.email ? `&user_email=${encodeURIComponent(user.email)}` : "";
            const res = await fetch(getApiUrl(`vote_comment.php?blog_id=${blogId}${emailParam}`));
            if (!res.ok) return;
            const data = await res.json();
            setCommentScores(data.scores || {});
            const votes = {};
            Object.entries(data.my_votes || {}).forEach(([id, v]) => {
                votes[id] = v === 1 ? "up" : v === -1 ? "down" : null;
            });
            setMyCommentVotes(votes);
        } catch (err) {
            console.error("Failed to fetch comment votes:", err);
        }
    };

    useEffect(() => { fetchCommentVotes(); /* eslint-disable-next-line */ }, [blogId, user?.email]);

    const castCommentVote = async (commentId, dir) => {
        if (!isAuthenticated) {
            loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } });
            return;
        }
        const current = myCommentVotes[commentId] || null;
        const nextVote = current === dir ? null : dir; // clicking the active arrow again removes the vote
        const voteValue = nextVote === "up" ? 1 : nextVote === "down" ? -1 : 0;

        // Optimistic update
        const prevScore = commentScores[commentId] || 0;
        const delta = (voteValue === 1 ? 1 : voteValue === -1 ? -1 : 0) - (current === "up" ? 1 : current === "down" ? -1 : 0);
        setMyCommentVotes(prev => ({ ...prev, [commentId]: nextVote }));
        setCommentScores(prev => ({ ...prev, [commentId]: prevScore + delta }));

        try {
            await fetch(getApiUrl("vote_comment.php"), {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                credentials: "include",
                body: JSON.stringify({ comment_id: commentId, vote: voteValue, user_email: user.email }),
            });
        } catch (err) {
            console.error("Comment vote failed:", err);
            fetchCommentVotes(); // resync on failure
        }
    };

    /* ---------- 1. Fetch comments ---------- */
    useEffect(() => {
        if (!blogId) return;
        
        const fetchComments = async () => {
            setIsFetchingComments(true);
            setError(null);
            try {
                const res = await fetch(getApiUrl(`blogcomment_api.php?blog_id=${blogId}`));
                if (!res.ok) throw new Error("Failed to fetch comments.");
                const data = await res.json();
                setComments(Array.isArray(data) ? data : []); 
            } catch (err) {
                console.error("Fetch comments error:", err);
                setError("Failed to load discussion comments. Try refreshing.");
            } finally {
                setIsFetchingComments(false);
            }
        };

        fetchComments();
    }, [blogId]);

    /* ---------- 2. Add main comment (optimistic update) ---------- */
    const addComment = async () => {
        if (!newComment.trim() || !user || isPostingComment) return;
        
        setIsPostingComment(true);
        setError(null);

        const tempId = Date.now(); 
        const payload = {
            id: tempId,
            blog_id: blogId,
            user_email: user.email,
            user_name: user.name,
            profile_picture_url: user.picture,
            text: newComment,
            parent_id: null,
            isTemporary: true,
        };

        setComments((prev) => [payload, ...prev]);
        setNewComment("");

        try {
            const res = await fetch(getApiUrl("blogcomment_api.php"), {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(payload),
            });

            const data = await res.json();
            
            if (data.status === "success" && data.id) {
                setComments((prev) => 
                    prev.map((c) => (c.id === tempId ? { ...c, ...data, id: data.id, isTemporary: false } : c))
                );
            } else {
                throw new Error(data.message || "Failed to post comment.");
            }

        } catch (err) {
            console.error("Post comment error:", err);
            setError("Failed to post comment. Check network connection.");
            setComments((prev) => prev.filter(c => c.id !== tempId));
        } finally {
            setIsPostingComment(false);
        }
    };

    /* ---------- 3. Add reply (optimistic update) ---------- */
    const addReply = async (parentId) => {
        if (!replyText.trim() || !user || isPostingReply) return;
        
        setIsPostingReply(true);
        setError(null);

        const tempId = Date.now();
        const payload = {
            id: tempId,
            blog_id: blogId,
            user_email: user.email,
            user_name: user.name,
            profile_picture_url: user.picture,
            text: replyText,
            parent_id: parentId,
            isTemporary: true,
        };

        setComments((prev) => [payload, ...prev.filter(c => c.id !== tempId)]); 
        setReplyText("");
        setReplyToId(null); 

        try {
            const res = await fetch(getApiUrl("blogcomment_api.php"), {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(payload),
            });

            const data = await res.json();
            
            if (data.status === "success" && data.id) {
                setComments((prev) => 
                    prev.map((c) => (c.id === tempId ? { ...c, ...data, id: data.id, isTemporary: false } : c))
                );
            } else {
                throw new Error(data.message || "Failed to post reply.");
            }
        } catch (err) {
            console.error("Post reply error:", err);
            setError("Failed to post reply. Check network connection.");
            setComments((prev) => prev.filter(c => c.id !== tempId));
        } finally {
            setIsPostingReply(false);
        }
    };

    /* ---------- 4. Update comment (optimistic) ---------- */
    const updateComment = async (id) => {
        if (!editingText.trim()) return;

        const originalComment = comments.find(c => c.id === id);
        if (!originalComment) return;

        setComments((prev) =>
            prev.map((c) => (c.id === id ? { ...c, text: editingText } : c))
        );
        setEditingId(null);

        try {
            const res = await fetch(getApiUrl("blogcomment_api.php"), {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    id,
                    text: editingText,
                    user_email: user.email,
                }),
            });
            
            const data = await res.json();
            if (data.status !== "success") {
                 throw new Error(data.message || "Failed to update comment.");
            }
        } catch (err) {
            console.error("Update comment error:", err);
            setError("Failed to update comment. Reverting changes.");
            setComments((prev) => 
                prev.map((c) => (c.id === id ? originalComment : c))
            );
            setEditingId(null); 
        }
    };

    /* ---------- 5. Delete comment (optimistic) ---------- */
    const deleteComment = async (id) => {
        const originalComments = [...comments];
        
        setComments((prev) => 
            prev.filter((c) => c.id !== id && c.parent_id !== id)
        );

        try {
            const res = await fetch(getApiUrl("blogcomment_api.php"), {
                method: "DELETE",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ id, user_email: user.email }),
            });
            
            const data = await res.json();
            if (data.status !== "success") {
                 throw new Error(data.message || "Failed to delete comment.");
            }
        } catch (err) {
            console.error("Delete comment error:", err);
            setError("Failed to delete comment. Reverting changes.");
            setComments(originalComments);
        }
    };

    const renderReplyInput = (parentId, depth = 1) => {
        if (replyToId !== parentId) return null;
        const marginLeft = Math.min(depth, 4) * 1.5;
        return (
            <div className="mt-4 transition-all duration-300" style={{ marginLeft: `${marginLeft}rem` }}>
                <textarea
                    value={replyText}
                    onChange={(e) => setReplyText(e.target.value)}
                    placeholder="Write a reply..."
                    className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl p-3 text-xs md:text-sm text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none"
                    rows="2"
                    aria-label="Write your reply"
                />
                <div className="mt-2 flex gap-3">
                    <button
                        onClick={() => addReply(parentId)}
                        className="px-3.5 py-1.5 rounded-xl bg-[var(--stamp)] hover:bg-[var(--stamp)] text-slate-950 text-[10px] font-bold transition-all shadow-md cursor-pointer flex items-center gap-1"
                        disabled={!replyText.trim() || isPostingReply}
                    >
                        {isPostingReply ? (
                            <>
                                <FaSpinner className="animate-spin" /> Posting...
                            </>
                        ) : (
                            <>
                                <FaCheck /> Post Reply
                            </>
                        )}
                    </button>
                    <button
                        onClick={() => setReplyToId(null)}
                        className="text-xs text-[var(--ink-soft)] hover:text-slate-350 cursor-pointer"
                        disabled={isPostingReply}
                    >
                        Cancel
                    </button>
                </div>
            </div>
        );
    };

    const handleReportComment = async (comment) => {
        if (!isAuthenticated) {
            loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } });
            return;
        }
        const notes = (commentReportNotes[comment.id] || "").trim();
        if (!notes) {
            setCommentReportMessage(prev => ({
                ...prev,
                [comment.id]: { type: 'error', text: 'Please add a reason for reporting this comment.' }
            }));
            return;
        }

        setCommentReportLoading(true);
        setCommentReportMessage(prev => ({ ...prev, [comment.id]: { type: '', text: '' } }));

        try {
            const res = await fetch(getApiUrl('report_blog.php'), {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    target_type: 'comment',
                    comment_id: comment.id,
                    blog_id: blogId,
                    reporter_email: user.email,
                    reported_user_email: comment.user_email,
                    reported_user_name: comment.user_name,
                    target_identifier: comment.text.slice(0, 160),
                    report_notes: notes,
                }),
            });
            const data = await res.json();
            if (!res.ok || data.error) {
                throw new Error(data.error || 'Failed to submit report.');
            }
            setCommentReportMessage(prev => ({
                ...prev,
                [comment.id]: { type: 'success', text: 'Report submitted. Admin will review this comment.' }
            }));
            setCommentReportNotes(prev => ({ ...prev, [comment.id]: '' }));
            setReportingCommentId(null);
        } catch (err) {
            console.error('Report comment error:', err);
            setCommentReportMessage(prev => ({
                ...prev,
                [comment.id]: { type: 'error', text: err.message || 'Failed to submit report.' }
            }));
        } finally {
            setCommentReportLoading(false);
        }
    };

    /* ---------- 6. Nested Reply Renderer ---------- */
    const renderReplies = (parentId, depth = 1) =>
        comments
            .filter((c) => c.parent_id === parentId)
            .map((reply) => (
                <div
                    key={reply.id}
                    className={`mt-4 rounded-xl p-4 bg-[var(--paper-raised)]/30 border border-[var(--rule)] transition-all duration-300 ${reply.isTemporary ? 'opacity-50 animate-pulse' : 'opacity-100'}`}
                    style={{ marginLeft: `${Math.min(depth, 4) * 1.5}rem` }}
                >
                    <div className="flex gap-3">
                        <VoteRail
                            size="sm"
                            score={commentScores[reply.id] || 0}
                            myVote={myCommentVotes[reply.id] || null}
                            onVote={(dir) => castCommentVote(reply.id, dir)}
                        />
                        {getAvatarUrl(reply.profile_picture_url) || getAvatarUrl(user?.picture) ? (
                            <img
                                src={getAvatarUrl(reply.profile_picture_url) || getAvatarUrl(user?.picture)}
                                alt={reply.user_name || "User"}
                                className="w-8 h-8 rounded-lg object-cover border border-[var(--rule-strong)]/60"
                                referrerPolicy="no-referrer"
                            />
                        ) : (
                            <FaUserCircle className="w-8 h-8 text-[var(--ink-soft)] flex-shrink-0" />
                        )}
                        <div className="flex-1">
                            <div className="flex items-center justify-between">
                                <p className="text-xs font-bold text-[var(--link)]">
                                    {reply.user_name || "Anonymous"}
                                </p>
                                <span className="text-3xs text-[var(--ink-soft)]">
                                    {new Date(reply.created_at || Date.now()).toLocaleDateString()}
                                </span>
                            </div>
                            {renderCommentText(reply.id, reply.text, "mt-1.5 text-xs md:text-sm text-slate-350 leading-relaxed whitespace-pre-wrap")}

                            <div className="mt-3.5 flex items-center gap-4 text-xs font-semibold text-[var(--ink-soft)]">
                                {isAuthenticated && (
                                    <button
                                        onClick={() => {
                                            setReplyToId(replyToId === reply.id ? null : reply.id);
                                            setReplyText("");
                                        }}
                                        className={`flex items-center gap-1.5 transition-colors cursor-pointer text-2xs ${replyToId === reply.id ? 'text-[var(--link)]' : 'hover:text-[var(--ink-soft)]'}`}
                                        disabled={editingId === reply.id}
                                    >
                                        <FaReply /> {replyToId === reply.id ? "Cancel Reply" : "Reply"}
                                    </button>
                                )}

                                {reply.user_email === user?.email && (
                                    <button
                                        onClick={() => deleteComment(reply.id)}
                                        className="text-[10px] text-red-400/80 hover:text-red-400 transition-colors flex items-center gap-1 cursor-pointer font-bold"
                                    >
                                        <FaTrash className="w-2 h-2" /> Delete
                                    </button>
                                )}
                            </div>
                        </div>
                    </div>
                    {renderReplyInput(reply.id, depth + 1)}
                    {renderReplies(reply.id, depth + 1)}
                </div>
            ));

    const primaryComments = useMemo(() => 
        comments.filter((c) => !c.parent_id), 
        [comments]
    );

    return (
        <section className="mt-12">
            <h3 className="text-lg md:text-xl font-bold text-[var(--ink)] mb-6 flex items-center gap-2">
                <FaCommentAlt className="text-[var(--stamp)] text-sm" /> Discussion ({primaryComments.length})
            </h3>
            
            {/* Error alerts */}
            {error && (
                <div className="mb-6 p-4 rounded-xl border border-red-700/30 bg-red-900/10 text-red-400 text-xs font-semibold flex items-center gap-2">
                    <FaTimes /> {error}
                </div>
            )}

            {/* Input textarea */}
            {isAuthenticated ? (
                <div className="mb-8 flex gap-3">
                    <img
                        src={user.picture}
                        alt="profile"
                        className="w-9 h-9 rounded-lg object-cover flex-shrink-0 border border-[var(--rule-strong)]/60"
                        referrerPolicy="no-referrer"
                    />
                    <div className="flex-1">
                        <textarea
                            value={newComment}
                            onChange={(e) => setNewComment(e.target.value)}
                            placeholder="Add to the learning thread, share a tip, or ask a question..."
                            className="w-full bg-[var(--paper-raised)]/50 border border-[var(--rule)] rounded-xl text-[var(--ink)] p-3 text-xs md:text-sm placeholder-slate-500 focus:border-[var(--stamp)]/40 focus:outline-none transition-colors"
                            rows="3"
                            aria-label="Write a new comment"
                            disabled={isPostingComment}
                        />
                        <button
                            onClick={addComment}
                            className="mt-2 px-4 py-2 rounded-xl bg-[var(--stamp)] hover:bg-[var(--stamp)] text-slate-950 text-xs font-bold transition-all shadow-md active:scale-98 disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-1.5 cursor-pointer"
                            disabled={!newComment.trim() || isPostingComment}
                        >
                            {isPostingComment ? (
                                <>
                                    <FaSpinner className="animate-spin" /> Posting...
                                </>
                            ) : (
                                <>
                                    <FaCheck /> Post Comment
                                </>
                            )}
                        </button>
                    </div>
                </div>
            ) : (
                /* Login Banner CTA */
                <div className="mb-8 rounded-xl border border-[var(--rule)] bg-[var(--paper-raised)]/20 p-5 text-xs text-[var(--ink-soft)] flex flex-col sm:flex-row items-center justify-between gap-4">
                  <span>Sign in to participate in the developer discussion list.</span>
                  <button
                    onClick={() => loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } })}
                    className="flex items-center gap-1.5 px-4 py-2 rounded-xl bg-[var(--stamp)] hover:bg-[var(--stamp)] text-slate-950 text-xs font-bold transition-all shadow-md cursor-pointer"
                  >
                    <FaSignInAlt /> Login / Sign Up
                  </button>
                </div>
            )}

            {/* Skeleton Loading placeholders */}
            {isFetchingComments && (
                <div className="space-y-4 py-4">
                  <div className="h-20 w-full skeleton-box rounded-xl" />
                  <div className="h-20 w-full skeleton-box rounded-xl" />
                </div>
            )}

            {/* Comment lists */}
            {!isFetchingComments && primaryComments.length === 0 ? (
                <div className="text-center py-10 border border-[var(--rule)] rounded-xl bg-[var(--paper-raised)]/20">
                  <p className="text-[var(--ink-soft)] italic text-xs">No questions or comments yet. Start the thread!</p>
                </div>
            ) : (
                <div className="space-y-4">
                  <AnimatePresence>
                    {primaryComments.map((c) => (
                      <motion.div
                        key={c.id} 
                        initial={{ opacity: 0, y: 10 }}
                        animate={{ opacity: 1, y: 0 }}
                        exit={{ opacity: 0, y: -10 }}
                        className={`rounded-xl p-5 bg-[var(--paper-raised)]/40 border border-[var(--rule)] transition-all duration-300 ${c.isTemporary ? 'opacity-50 animate-pulse' : 'opacity-100'}`}
                      >
                        <div className="flex gap-3">
                            <VoteRail
                                size="sm"
                                score={commentScores[c.id] || 0}
                                myVote={myCommentVotes[c.id] || null}
                                onVote={(dir) => castCommentVote(c.id, dir)}
                            />
                            {getAvatarUrl(c.profile_picture_url) ? (
                                <img
                                    src={getAvatarUrl(c.profile_picture_url)}
                                    alt={c.user_name || "User"}
                                    className="w-9 h-9 rounded-lg object-cover flex-shrink-0 border border-[var(--rule-strong)]/60"
                                    referrerPolicy="no-referrer"
                                />
                            ) : (
                                <FaUserCircle className="w-9 h-9 text-[var(--ink-soft)] flex-shrink-0" />
                            )}
                            <div className="flex-1">
                                <div className="flex items-center justify-between">
                                  <p className="font-bold text-[var(--stamp)] text-xs md:text-sm">{c.user_name || "Anonymous"}</p>
                                  <span className="text-3xs text-[var(--ink-soft)]">
                                    {new Date(c.created_at || Date.now()).toLocaleDateString()}
                                  </span>
                                </div>

                                {editingId === c.id ? (
                                    /* Edit Textbox */
                                    <div className="mt-2">
                                        <textarea
                                            value={editingText}
                                            onChange={(e) => setEditingText(e.target.value)}
                                            className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl p-3 text-xs md:text-sm text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none"
                                            rows="3"
                                        />
                                        <div className="mt-2 flex gap-3 text-xs">
                                            <button
                                                onClick={() => updateComment(c.id)}
                                                className="flex items-center gap-1 font-bold text-emerald-450 hover:text-emerald-400 transition-colors cursor-pointer text-2xs"
                                            >
                                                <FaSave /> Save
                                            </button>
                                            <button
                                                onClick={() => setEditingId(null)}
                                                className="text-[var(--ink-soft)] hover:text-[var(--ink-soft)] transition-colors cursor-pointer text-2xs"
                                            >
                                                Cancel
                                            </button>
                                        </div>
                                    </div>
                                ) : (
                                    /* Display comment text */
                                    renderCommentText(c.id, c.text, "mt-2 text-xs md:text-sm text-[var(--ink-soft)] leading-relaxed whitespace-pre-wrap")
                                )}

                                {/* Card Actions */}
                                <div className="mt-3.5 flex items-center gap-4 text-xs font-semibold text-[var(--ink-soft)]">
                                    {isAuthenticated && (
                                        <button
                                            onClick={() => {
                                                setReplyToId(replyToId === c.id ? null : c.id);
                                                setReplyText(""); 
                                            }}
                                            className={`flex items-center gap-1.5 transition-colors cursor-pointer text-2xs ${replyToId === c.id ? 'text-[var(--link)]' : 'hover:text-[var(--ink-soft)]'}`}
                                            disabled={editingId === c.id}
                                        >
                                            <FaReply /> {replyToId === c.id ? "Cancel Reply" : "Reply"}
                                        </button>
                                    )}

                                    {isAuthenticated && c.user_email !== user?.email && (
                                        <button
                                            onClick={() => {
                                                setReportingCommentId(reportingCommentId === c.id ? null : c.id);
                                                setCommentReportNotes(prev => ({ ...prev, [c.id]: prev[c.id] || '' }));
                                            }}
                                            className={`flex items-center gap-1.5 transition-colors cursor-pointer text-2xs ${reportingCommentId === c.id ? 'text-red-400' : 'hover:text-[var(--ink-soft)]'}`}
                                            disabled={editingId === c.id}
                                        >
                                            <FaFlag /> {reportingCommentId === c.id ? 'Cancel Report' : 'Report'}
                                        </button>
                                    )}

                                    {c.user_email === user?.email && !editingId && (
                                        <>
                                            <button
                                                onClick={() => {
                                                    setEditingId(c.id);
                                                    setEditingText(c.text);
                                                    setReplyToId(null); 
                                                }}
                                                className="flex items-center gap-1.5 hover:text-amber-500 transition-colors cursor-pointer text-2xs"
                                            >
                                                <FaEdit /> Edit
                                            </button>
                                            <button
                                                onClick={() => deleteComment(c.id)}
                                                className="flex items-center gap-1.5 hover:text-red-400 transition-colors cursor-pointer text-2xs"
                                            >
                                                <FaTrash /> Delete
                                            </button>
                                        </>
                                    )}
                                </div>
                            </div>
                        </div>

                        {/* Expandable Reply text area */}
                        {replyToId === c.id && (
                            <div className="mt-4 ml-6 md:ml-12 transition-all duration-300">
                                <textarea
                                    value={replyText}
                                    onChange={(e) => setReplyText(e.target.value)}
                                    placeholder="Write a reply..."
                                    className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl p-3 text-xs md:text-sm text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none"
                                    rows="2"
                                    aria-label="Write your reply"
                                />
                                <div className="mt-2 flex gap-3">
                                    <button
                                        onClick={() => addReply(c.id)}
                                        className="px-3.5 py-1.5 rounded-xl bg-[var(--stamp)] hover:bg-[var(--stamp)] text-slate-950 text-[10px] font-bold transition-all shadow-md cursor-pointer flex items-center gap-1"
                                        disabled={!replyText.trim() || isPostingReply}
                                    >
                                        {isPostingReply ? (
                                            <>
                                                <FaSpinner className="animate-spin" /> Posting...
                                            </>
                                        ) : (
                                            <>
                                                <FaCheck /> Post Reply
                                            </>
                                        )}
                                    </button>
                                    <button
                                        onClick={() => setReplyToId(null)}
                                        className="text-xs text-[var(--ink-soft)] hover:text-slate-350 cursor-pointer"
                                        disabled={isPostingReply}
                                    >
                                        Cancel
                                    </button>
                                </div>
                            </div>
                        )}
                        {reportingCommentId === c.id && (
                            <div className="mt-4 ml-6 md:ml-12 rounded-2xl border border-red-700/20 bg-red-950/10 p-4">
                                <label className="text-[10px] uppercase tracking-widest text-red-300 font-bold mb-2 block">
                                    Why are you reporting this comment?
                                </label>
                                <textarea
                                    value={commentReportNotes[c.id] || ''}
                                    onChange={(e) => setCommentReportNotes(prev => ({ ...prev, [c.id]: e.target.value }))}
                                    placeholder="Describe the concern or rule violation."
                                    className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl p-3 text-xs md:text-sm text-[var(--ink)] focus:border-red-400/40 focus:outline-none"
                                    rows="3"
                                />
                                {commentReportMessage[c.id] && (
                                    <div className={`mt-3 text-2xs p-2 rounded-lg ${commentReportMessage[c.id].type === 'success' ? 'bg-emerald-950/20 border border-emerald-700 text-emerald-300' : 'bg-red-950/20 border border-red-700 text-red-300'}`}>
                                        {commentReportMessage[c.id].text}
                                    </div>
                                )}
                                <div className="mt-3 flex flex-wrap gap-2 items-center">
                                    <button
                                        onClick={() => handleReportComment(c)}
                                        className="inline-flex items-center gap-1 px-3.5 py-2 rounded-xl bg-red-500 hover:bg-red-400 text-slate-950 text-[10px] font-bold transition-all shadow-md"
                                        disabled={commentReportLoading}
                                    >
                                        {commentReportLoading ? <FaSpinner className="animate-spin" /> : 'Submit Report'}
                                    </button>
                                    <button
                                        onClick={() => setReportingCommentId(null)}
                                        className="text-[10px] text-[var(--ink-soft)] hover:text-[var(--ink)]"
                                    >
                                        Cancel
                                    </button>
                                </div>
                            </div>
                        )}
                        {renderReplies(c.id)}
                      </motion.div>
                    ))}
                  </AnimatePresence>
                </div>
            )}
        </section>
    );
};

export default CommentBox;