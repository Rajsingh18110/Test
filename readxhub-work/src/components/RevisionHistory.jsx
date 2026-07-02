import React, { useState } from "react";
import { FaHistory, FaTimes, FaUserEdit, FaSpinner } from "react-icons/fa";
import { getApiUrl } from "../utils/api.js";

/**
 * RevisionHistory — a "View history" trigger + modal, in the spirit of
 * Wikipedia's article history tab. Lists every saved edit for a post,
 * newest first, pulled from blog_revisions via get_blog_revisions.php.
 */
export default function RevisionHistory({ blogId }) {
  const [open, setOpen] = useState(false);
  const [loading, setLoading] = useState(false);
  const [revisions, setRevisions] = useState(null);
  const [error, setError] = useState(null);

  const load = async () => {
    setOpen(true);
    if (revisions !== null) return; // already fetched this session
    setLoading(true);
    setError(null);
    try {
      const res = await fetch(getApiUrl(`get_blog_revisions.php?blog_id=${blogId}`));
      if (!res.ok) throw new Error("Failed to load history");
      const data = await res.json();
      setRevisions(Array.isArray(data) ? data : []);
    } catch (err) {
      setError("Couldn't load revision history.");
    } finally {
      setLoading(false);
    }
  };

  if (!blogId) return null;

  return (
    <>
      <button
        onClick={load}
        className="flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-[var(--paper-raised)] border border-[var(--rule)] text-[var(--ink-soft)] hover:text-[var(--link)] hover:border-[var(--stamp)]/20 transition-all cursor-pointer shadow-sm"
        title="View edit history"
      >
        <FaHistory className="text-xs" />
        <span className="text-xs font-semibold">History</span>
      </button>

      {open && (
        <div
          className="fixed inset-0 z-[100] bg-black/40 flex items-center justify-center p-4"
          onClick={() => setOpen(false)}
        >
          <div
            className="rx-card w-full max-w-lg max-h-[75vh] overflow-y-auto p-5"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center justify-between mb-4 pb-3 border-b border-[var(--rule)]">
              <h3 className="font-display text-lg text-[var(--ink)]" style={{ fontFamily: "var(--font-display)" }}>
                Revision history
              </h3>
              <button onClick={() => setOpen(false)} className="text-[var(--ink-soft)] hover:text-[var(--ink)]">
                <FaTimes />
              </button>
            </div>

            {loading && (
              <div className="flex items-center gap-2 text-sm text-[var(--ink-soft)] py-6 justify-center">
                <FaSpinner className="animate-spin" /> Loading history...
              </div>
            )}

            {error && <p className="text-red-500 text-sm">{error}</p>}

            {!loading && !error && revisions && revisions.length === 0 && (
              <p className="text-sm text-[var(--ink-soft)] py-4">
                No edits have been recorded for this article yet. Edits made from now on will appear here.
              </p>
            )}

            {!loading && revisions && revisions.length > 0 && (
              <ul className="space-y-2">
                {revisions.map((rev) => (
                  <li key={rev.id} className="flex items-start gap-3 p-3 rounded-lg border border-[var(--rule)] bg-[var(--paper)]">
                    <FaUserEdit className="text-[var(--stamp)] mt-0.5 flex-shrink-0" />
                    <div className="min-w-0">
                      <p className="text-sm text-[var(--ink)] font-medium truncate">{rev.title || "Untitled revision"}</p>
                      <p className="text-xs text-[var(--ink-soft)] mt-0.5">
                        {rev.edited_by_name || rev.edited_by_email || "Unknown editor"} &middot;{" "}
                        {new Date(rev.created_at).toLocaleString()}
                      </p>
                      {rev.edit_summary && (
                        <p className="text-xs text-[var(--ink-soft)] italic mt-1">"{rev.edit_summary}"</p>
                      )}
                    </div>
                  </li>
                ))}
              </ul>
            )}
          </div>
        </div>
      )}
    </>
  );
}
