import React, { useEffect, useState } from "react";
import { useNavigate, Link } from "react-router-dom";
import { useAuth0 } from "@auth0/auth0-react";
import { motion } from "framer-motion";
import {
  FaPlus,
  FaLink,
  FaEdit,
  FaTrash,
  FaEye,
  FaSpinner,
  FaBook,
  FaChartBar,
  FaChartLine
} from "react-icons/fa";
import Logged from "../IsLogged";
import { getApiUrl } from "../utils/api.js";

export default function Dashboard() {
  const navigate = useNavigate();
  const { user, isAuthenticated } = useAuth0();

  const [creatorName, setCreatorName] = useState("Creator");
  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);

  /* ---------- Load creator name ---------- */
  useEffect(() => {
    if (!isAuthenticated) {
      navigate("/");
      return;
    }

    fetch(
      getApiUrl(`get_creator_name.php?email=${encodeURIComponent(
        user.email
      )}`),
      { credentials: "include" }
    )
      .then((r) => r.json())
      .then((d) => {
        if (d?.name) {
          const name = d.name.trim();
          setCreatorName(name.charAt(0).toUpperCase() + name.slice(1));
        } else {
          navigate("/beacreator");
        }
      })
      .catch(() => {});
  }, [isAuthenticated, user, navigate]);

  /* ---------- Load posts + views ---------- */
  useEffect(() => {
    if (!isAuthenticated || !user?.email) return;

    setLoading(true);
    fetch(
      getApiUrl(`pages.php?email=${encodeURIComponent(
        user.email
      )}`),
      { credentials: "include" }
    )
      .then((r) => r.json())
      .then((data) => {
        const blogList = Array.isArray(data) ? data : [];
        setPosts(blogList);

        const slugs = blogList.map((p) => p.slug).filter(Boolean);
        if (!slugs.length) return;

        fetch(getApiUrl("get_views_by_slugs.php"), {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          credentials: "include",
          body: JSON.stringify({ slugs }),
        })
          .then((res) => res.json())
          .then((views) => {
            setPosts((prev) =>
              prev.map((p) => ({
                ...p,
                views: views[p.slug] || 0,
              }))
            );
          })
          .catch(() => {});
      })
      .catch(() => setPosts([]))
      .finally(() => setLoading(false));
  }, [isAuthenticated, user]);

  /* ---------- Delete post ---------- */
  const handleDelete = async (blog) => {
    const ok = window.confirm(
      `Delete “${blog.title}”? This action is permanent and cannot be undone.`
    );
    if (!ok) return;

    try {
      const res = await fetch(
        getApiUrl("delete_blog.php"),
        {
          method: "DELETE",
          headers: { "Content-Type": "application/json" },
          credentials: "include",
          body: JSON.stringify({ id: blog.id, email: user.email }),
        }
      );
      const data = await res.json();

      if (data?.success) {
        setPosts((prev) => prev.filter((p) => p.id !== blog.id));
      }
    } catch {}
  };

  // Analytics helper calculations
  const totalViews = posts.reduce((acc, p) => acc + (p.views || 0), 0);
  const averageViews = posts.length ? Math.round(totalViews / posts.length) : 0;

  return (
    <>
      <Logged />
      <main className="min-h-screen bg-[var(--paper)] text-[var(--ink)] selection:bg-[var(--stamp)]/30 selection:text-[var(--link)] px-6 py-12">
        <div className="max-w-6xl mx-auto space-y-10">
          
          {/* Welcome Dashboard Header */}
          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-6 pb-6 border-b border-[var(--rule)]">
            <div>
              <h1 className="text-2xl md:text-3xl font-extrabold text-[var(--ink)] tracking-tight">
                Welcome back, {creatorName}
              </h1>
              <p className="text-xs md:text-sm text-[var(--ink-soft)] mt-1">
                Monitor your article distributions, read counts, and author metrics.
              </p>
            </div>

            <button
              onClick={() => navigate("/createapost")}
              className="inline-flex items-center gap-2 px-4.5 py-2.5 rounded-xl bg-[var(--stamp)] hover:bg-[var(--stamp)] text-slate-950 font-bold text-xs shadow-md transition-all active:scale-98 cursor-pointer"
            >
              <FaPlus /> Create Publication
            </button>
          </div>

          {/* METRIC ANALYTIC WIDGETS */}
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-6">
            <div className="bg-[var(--paper-raised)]/30 border border-[var(--rule)] rounded-2xl p-5 shadow-lg flex items-center gap-4">
              <div className="w-10 h-10 rounded-xl bg-[var(--stamp)]/10 border border-[var(--stamp)]/20 flex items-center justify-center text-[var(--link)]">
                <FaBook className="text-sm" />
              </div>
              <div>
                <span className="text-3xs uppercase tracking-wider text-[var(--ink-soft)] font-bold block">Total Publications</span>
                <span className="text-xl font-extrabold text-[var(--ink)] mt-0.5 block">{posts.length}</span>
              </div>
            </div>

            <div className="bg-[var(--paper-raised)]/30 border border-[var(--rule)] rounded-2xl p-5 shadow-lg flex items-center gap-4">
              <div className="w-10 h-10 rounded-xl bg-[var(--stamp)]/10 border border-[var(--stamp)]/20 flex items-center justify-center text-[var(--link)]">
                <FaChartBar className="text-sm" />
              </div>
              <div>
                <span className="text-3xs uppercase tracking-wider text-[var(--ink-soft)] font-bold block">Accrued Article Views</span>
                <span className="text-xl font-extrabold text-[var(--ink)] mt-0.5 block">{totalViews}</span>
              </div>
            </div>

            <div className="bg-[var(--paper-raised)]/30 border border-[var(--rule)] rounded-2xl p-5 shadow-lg flex items-center gap-4">
              <div className="w-10 h-10 rounded-xl bg-[var(--stamp)]/10 border border-[var(--stamp)]/20 flex items-center justify-center text-[var(--link)]">
                <FaChartLine className="text-sm" />
              </div>
              <div>
                <span className="text-3xs uppercase tracking-wider text-[var(--ink-soft)] font-bold block">Average Engagement</span>
                <span className="text-xl font-extrabold text-[var(--ink)] mt-0.5 block">{averageViews} views/post</span>
              </div>
            </div>
          </div>

          {/* DASHBOARD CORE CONTENT */}
          {loading ? (
            <div className="text-center py-20">
              <FaSpinner className="animate-spin text-[var(--link)] text-3xl mx-auto" />
              <p className="text-[var(--ink-soft)] text-xs mt-3">Loading creator credentials and lists...</p>
            </div>
          ) : posts.length === 0 ? (
            <div className="rounded-2xl border border-[var(--rule)] bg-[var(--paper-raised)]/10 p-12 text-center shadow-inner max-w-md mx-auto space-y-4">
              <FaBook className="text-4xl text-[var(--rule-strong)] mx-auto" />
              <div className="space-y-1">
                <h3 className="text-sm font-bold text-[var(--ink)]">No articles written</h3>
                <p className="text-[var(--ink-soft)] text-xs leading-relaxed">
                  You haven't written any publications yet. Share your engineering or hacking findings now.
                </p>
              </div>
              <button 
                onClick={() => navigate("/createapost")}
                className="px-4 py-2 rounded-xl bg-[var(--stamp)]/10 hover:bg-[var(--stamp)]/20 text-[var(--link)] border border-[var(--stamp)]/20 text-xs font-bold transition-all cursor-pointer"
              >
                Write your first article
              </button>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {posts.map((blog) => (
                <motion.div
                  key={blog.id}
                  whileHover={{ y: -3 }}
                  className="rounded-2xl bg-[var(--paper-raised)]/40 border border-[var(--rule)] p-6 shadow-xl flex flex-col justify-between hover:border-[var(--rule-strong)]/60"
                >
                  <div>
                    <h2 className="text-base md:text-lg font-bold text-[var(--ink)] line-clamp-2 leading-snug">
                      {blog.title}
                    </h2>

                    <div className="flex flex-wrap items-center gap-4 text-3xs font-semibold text-[var(--ink-soft)] mt-2 mb-4">
                      <span className="bg-[var(--paper-raised)] px-2 py-1 rounded border border-[var(--rule)]">
                        📅 {blog.created_at?.slice(0, 10)}
                      </span>
                      <span className="bg-[var(--paper-raised)] px-2 py-1 rounded border border-[var(--rule)] flex items-center gap-1">
                        <FaEye className="text-[var(--stamp)]" /> {blog.views || 0} views
                      </span>
                    </div>

                    <p className="text-xs md:text-sm text-[var(--ink-soft)] line-clamp-3 leading-relaxed">
                      {blog.description}
                    </p>
                  </div>

                  {/* Operational Toolbar */}
                  <div className="mt-6 pt-4 border-t border-[var(--rule)] flex items-center justify-between">
                    {blog.slug ? (
                      <a
                        href={getApiUrl(`post.php?slug=${encodeURIComponent(
                          blog.slug
                        )}`)}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="inline-flex items-center gap-1 text-xs text-[var(--stamp)] hover:text-[var(--link)] transition-colors font-bold"
                      >
                        <FaLink /> View Live
                      </a>
                    ) : (
                      <div />
                    )}

                    <div className="flex items-center gap-4">
                      <button
                        onClick={() =>
                          navigate(`/edit/${encodeURIComponent(blog.slug)}`)
                        }
                        className="inline-flex items-center gap-1.5 text-xs text-[var(--ink-soft)] hover:text-emerald-400 transition-colors font-semibold cursor-pointer"
                      >
                        <FaEdit /> Edit
                      </button>

                      <button
                        onClick={() => handleDelete(blog)}
                        className="inline-flex items-center gap-1.5 text-xs text-[var(--ink-soft)] hover:text-red-400 transition-colors font-semibold cursor-pointer"
                      >
                        <FaTrash /> Delete
                      </button>
                    </div>
                  </div>
                </motion.div>
              ))}
            </div>
          )}
        </div>
      </main>
    </>
  );
}
