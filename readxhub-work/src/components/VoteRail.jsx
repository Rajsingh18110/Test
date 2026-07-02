import React from "react";
import { FaCaretUp, FaCaretDown } from "react-icons/fa";

/**
 * VoteRail — the site's signature community element.
 * A vertical up/down + score card styled like a library due-date stamp,
 * used consistently on feed cards, article headers, and comments so the
 * "vote" action always looks and behaves the same way across ReadXHub.
 *
 * Props:
 *  score      - number to display (net score, e.g. likes - dislikes)
 *  myVote     - 'up' | 'down' | null, current user's vote state
 *  onVote(dir)- called with 'up' or 'down' when a control is pressed
 *  size       - 'sm' | 'md' (default 'md')
 */
export default function VoteRail({ score = 0, myVote = null, onVote, size = "md" }) {
  const dims = size === "sm"
    ? { btn: "w-6 h-5", icon: "text-xs", score: "text-[11px]" }
    : { btn: "w-7 h-6", icon: "text-sm", score: "text-xs" };

  return (
    <div className="rx-stamp-rail select-none">
      <button
        type="button"
        onClick={(e) => { e.preventDefault(); e.stopPropagation(); onVote && onVote("up"); }}
        className={`rx-stamp-btn is-up ${myVote === "up" ? "active" : ""} ${dims.btn}`}
        aria-label="Upvote"
        title="Upvote"
      >
        <FaCaretUp className={dims.icon} />
      </button>
      <span className={`rx-stamp-score ${dims.score}`}>{score}</span>
      <button
        type="button"
        onClick={(e) => { e.preventDefault(); e.stopPropagation(); onVote && onVote("down"); }}
        className={`rx-stamp-btn is-down ${myVote === "down" ? "active" : ""} ${dims.btn}`}
        aria-label="Downvote"
        title="Downvote"
      >
        <FaCaretDown className={dims.icon} />
      </button>
    </div>
  );
}
