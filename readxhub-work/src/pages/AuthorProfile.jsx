import React, { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { FaUser, FaEnvelope, FaBookOpen, FaClock, FaArrowLeft, FaSpinner, FaBell, FaBellSlash, FaCheckCircle, FaFlag } from "react-icons/fa";
import { useAuth0 } from "@auth0/auth0-react";
import { getApiUrl } from "../utils/api.js";
import { getOfflineAuthUser } from "../utils/auth.js";

export default function AuthorProfile() {
  const { identifier } = useParams();
  const { user, isAuthenticated, loginWithRedirect } = useAuth0();
  const offlineUser = getOfflineAuthUser();
  const effectiveUser = isAuthenticated && user?.email ? user : offlineUser;
  const effectiveAuthenticated = isAuthenticated || Boolean(offlineUser);
  const [profile, setProfile] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [showReportPanel, setShowReportPanel] = useState(false);
  const [reportNotes, setReportNotes] = useState("");
  const [isReporting, setIsReporting] = useState(false);
  const [reportError, setReportError] = useState(null);
  const [reportSuccess, setReportSuccess] = useState(false);

  const getAvatarUrl = (prof) => {
    if (prof.profile_picture && !prof.profile_picture.includes("unsplash.com")) {
      if (prof.profile_picture.startsWith("http") || prof.profile_picture.startsWith("data:")) {
        return prof.profile_picture;
      }
      return getApiUrl(prof.profile_picture);
    }
    const gender = String(prof.gender || "male").toLowerCase();
    if (gender === "female") {
      return `data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%23f472b6"/><path d="M50 28a15 15 0 1 0 0 30 15 15 0 1 0 0-30z" fill="%230f172a"/><path d="M50 64c-18 0-33 11-33 22v4h66v-4c0-11-15-22-33-22z" fill="%230f172a"/></svg>`;
    }
    if (gender === "trans" || gender === "transgender" || gender === "other") {
      return `data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%23a855f7"/><path d="M50 29a15 15 0 1 0 0 30 15 15 0 1 0 0-30z" fill="%230f172a"/><path d="M50 64c-18 0-33 11-33 22v4h66v-4c0-11-15-22-33-22z" fill="%230f172a"/></svg>`;
    }
    return `data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="50" fill="%2338bdf8"/><path d="M50 30a16 16 0 1 0 0 32 16 16 0 1 0 0-32z" fill="%230f172a"/><path d="M50 66c-18.5 0-34 11-34 22v4h68v-4c0-11-15.5-22-34-22z" fill="%230f172a"/></svg>`;
  };

  useEffect(() => {
    setLoading(true);
    setError(null);
    const isEmail = identifier.includes("@");
    const paramName = isEmail ? "email" : "username";
    fetch(getApiUrl(`get_creator_profile.php?${paramName}=${encodeURIComponent(identifier)}`), { credentials: "include" })
      .then(res => {
        if (!res.ok) {
          throw new Error("Author profile not found or database connection failed.");
        }
        return res.json();
      })
      .then(data => {
        setProfile(data);
      })
      .catch(err => {
        setError(err.message);
      })
      .finally(() => {
        setLoading(false);
      });
  }, [identifier]);

  const handleReportProfile = async () => {
    if (!profile) return;
    if (!effectiveAuthenticated || !effectiveUser?.email) {
      loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } });
      return;
    }
    if (!reportNotes.trim()) {
      setReportError('Please explain why you are reporting this profile.');
      return;
    }

    setIsReporting(true);
    setReportError(null);
    setReportSuccess(false);

    try {
      const res = await fetch(getApiUrl('report_blog.php'), {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          target_type: 'profile',
          reporter_email: effectiveUser?.email || '',
          reported_user_email: profile.email,
          reported_user_name: profile.name,
          target_identifier: profile.username || profile.email,
          report_notes: reportNotes.trim(),
        }),
      });
      const data = await res.json();
      if (!res.ok || data.error) {
        throw new Error(data.error || 'Unable to submit profile report.');
      }
      setReportSuccess(true);
      setReportNotes('');
    } catch (err) {
      setReportError(err.message || 'Failed to submit report.');
    } finally {
      setIsReporting(false);
    }
  };

  const getReadingTime = (text) => {
    const words = text ? text.split(" ").length : 65;
    const time = Math.max(1, Math.round(words / 200));
    return `${time} min read`;
  };

  if (loading) {
    return (
      <main className="min-h-screen bg-[var(--paper)] flex items-center justify-center">
        <FaSpinner className="animate-spin text-[var(--link)] text-3xl" />
      </main>
    );
  }

  if (error || !profile) {
    return (
      <main className="min-h-screen bg-[var(--paper)] flex items-center justify-center p-6 text-center">
        <div className="bg-red-500/10 border border-red-500/20 p-6 rounded-2xl max-w-sm">
          <p className="text-red-400 font-bold text-lg">Author Not Found</p>
          <p className="text-[var(--ink-soft)] text-xs mt-1.5">{error || "The profile you requested does not exist."}</p>
          <Link to="/" className="mt-4 inline-flex items-center gap-1.5 text-xs text-[var(--link)] font-semibold hover:underline">
            <FaArrowLeft /> Back to home
          </Link>
        </div>
      </main>
    );
  }

  return (
    <main className="min-h-screen bg-[var(--paper)] text-[var(--ink)] selection:bg-[var(--stamp)]/30 selection:text-[var(--link)] py-16 px-6">
      <div className="max-w-4xl mx-auto space-y-10">
        
        {/* Navigation back */}
        <Link 
          to="/" 
          className="inline-flex items-center gap-1.5 text-xs text-[var(--ink-soft)] hover:text-[var(--link)] transition-colors font-medium"
        >
          <FaArrowLeft /> Back to publications
        </Link>

        {/* Profile Card */}
        <div className="bg-[var(--paper-raised)]/40 border border-[var(--rule)] rounded-2xl p-6 md:p-8 shadow-xl">
          <div className="flex flex-col sm:flex-row items-center sm:items-start gap-6">
            <img 
              src={getAvatarUrl(profile)} 
              alt={profile.name} 
              className="w-24 h-24 rounded-2xl object-cover border border-slate-705 shadow-md flex-shrink-0"
              referrerPolicy="no-referrer"
            />
            <div className="text-center sm:text-left space-y-3 flex-1">
              <div>
                <h1 className="text-2xl md:text-3xl font-extrabold text-[var(--ink)] tracking-tight">{profile.name}</h1>
                {profile.email && (
                  <p className="text-xs text-[var(--ink-soft)] flex items-center justify-center sm:justify-start gap-1.5 mt-1.5">
                    <FaEnvelope className="text-[var(--stamp)] text-3xs" /> {profile.email}
                  </p>
                )}
                <div className="flex items-center justify-center sm:justify-start gap-4 mt-3">
                  <div className="bg-[var(--paper-raised)] border border-[var(--rule)] rounded-lg px-3 py-1.5 flex items-center gap-2 shadow-sm">
                    <FaBell className="text-[var(--stamp)] text-xs" />
                    <span className="text-xs font-bold text-[var(--ink)]">{profile.total_subscribers || 0}</span>
                    <span className="text-3xs text-[var(--ink-soft)] uppercase tracking-widest">Subscribers</span>
                  </div>
                  <div className="bg-[var(--paper-raised)] border border-[var(--rule)] rounded-lg px-3 py-1.5 flex items-center gap-2 shadow-sm">
                    <FaBookOpen className="text-[var(--stamp)] text-xs" />
                    <span className="text-xs font-bold text-[var(--ink)]">{profile.total_views || 0}</span>
                    <span className="text-3xs text-[var(--ink-soft)] uppercase tracking-widest">Views</span>
                  </div>
                </div>
                {!profile.is_self && (
                  <div className="mt-4">
                    <button
                      onClick={() => {
                        setShowReportPanel(!showReportPanel);
                        setReportError(null);
                        setReportSuccess(false);
                      }}
                      className="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-red-500 hover:bg-red-400 text-slate-950 text-xs font-bold transition-all shadow-md"
                    >
                      <FaFlag /> Report Creator
                    </button>
                  </div>
                )}
                {showReportPanel && (
                  <div className="mt-4 rounded-3xl border border-red-700/20 bg-red-950/10 p-5">
                    <p className="text-[10px] uppercase tracking-widest text-red-300 font-bold mb-3">Report this creator</p>
                    <textarea
                      value={reportNotes}
                      onChange={(e) => setReportNotes(e.target.value)}
                      rows={4}
                      placeholder="Describe the reason for reporting this profile..."
                      className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-2xl p-3 text-xs text-[var(--ink)] focus:border-red-400/40 focus:outline-none"
                    />
                    {reportError && (
                      <div className="mt-3 text-2xs text-red-300 bg-red-950/20 border border-red-700/20 rounded-xl p-3">
                        {reportError}
                      </div>
                    )}
                    {reportSuccess && (
                      <div className="mt-3 text-2xs text-emerald-300 bg-emerald-950/20 border border-emerald-700/20 rounded-xl p-3">
                        Profile report submitted successfully.
                      </div>
                    )}
                    <div className="mt-4 flex flex-wrap gap-2">
                      <button
                        onClick={handleReportProfile}
                        disabled={isReporting}
                        className="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-red-500 hover:bg-red-400 text-slate-950 text-xs font-bold transition-all shadow-md"
                      >
                        {isReporting ? <FaSpinner className="animate-spin" /> : 'Submit Report'}
                      </button>
                      <button
                        onClick={() => setShowReportPanel(false)}
                        className="inline-flex items-center gap-2 px-4 py-2 rounded-xl border border-[var(--rule)] text-[var(--ink-soft)] text-xs font-semibold hover:bg-[var(--paper-raised)]"
                      >
                        Cancel
                      </button>
                    </div>
                  </div>
                )}
              </div>
              <p className="text-xs md:text-sm text-[var(--ink-soft)] leading-relaxed max-w-2xl mt-3">{profile.bio}</p>
            </div>
          </div>
        </div>

        {/* Subscribe Card */}
        <SubscribeCard creatorIdentifier={identifier} creatorName={profile.name} />

        {/* Creator's Articles */}
        <div className="space-y-6">
          <h2 className="text-sm font-bold uppercase tracking-wider text-[var(--ink-soft)] flex items-center gap-2">
            <span className="w-1.5 h-1.5 rounded-full bg-[var(--stamp)]" /> Publications by {profile.name} ({profile.blogs?.length || 0})
          </h2>

          {profile.blogs?.length === 0 ? (
            <div className="p-8 text-center rounded-2xl border border-[var(--rule)] bg-[var(--paper-raised)]/10 text-[var(--ink-soft)] text-xs italic">
              This creator hasn't published any articles yet.
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {profile.blogs.map(blog => (
                <article 
                  key={blog.id} 
                  className="group rounded-2xl bg-[var(--paper-raised)]/30 border border-[var(--rule)] p-5 hover:border-[var(--rule-strong)]/60 hover:bg-[var(--paper-raised)]/50 transition-all flex flex-col justify-between"
                >
                  <div className="space-y-3">
                    <div className="flex items-center gap-2 text-3xs text-[var(--ink-soft)]">
                      <span>{new Date(blog.created_at).toLocaleDateString("en-IN")}</span>
                      <span>•</span>
                      <span className="flex items-center gap-0.5"><FaClock /> {blog.reading_time || 1} min read</span>
                    </div>
                    <h3 className="text-sm md:text-base font-bold text-[var(--ink)] group-hover:text-[var(--link)] transition-colors leading-snug">
                      <Link to={`/blog/${blog.slug}`}>{blog.title}</Link>
                    </h3>
                    <p className="text-xs text-[var(--ink-soft)] line-clamp-2 leading-relaxed">
                      {blog.description}
                    </p>
                  </div>
                  <div className="mt-4 pt-3 border-t border-slate-950 flex justify-end">
                    <Link to={`/blog/${blog.slug}`} className="text-3xs text-[var(--link)] font-bold hover:underline inline-flex items-center gap-0.5">
                      Read Article <FaArrowLeft className="rotate-180 text-[8px]" />
                    </Link>
                  </div>
                </article>
              ))}
            </div>
          )}
        </div>

      </div>
    </main>
  );
}

function SubscribeCard({ creatorIdentifier, creatorName }) {
  const { user, isAuthenticated, loginWithRedirect } = useAuth0();
  const offlineUser = getOfflineAuthUser();
  const effectiveUser = isAuthenticated && user?.email ? user : offlineUser;
  const effectiveAuthenticated = isAuthenticated || Boolean(offlineUser);
  const [isSubscribed, setIsSubscribed] = useState(false);
  const [isSelf, setIsSelf] = useState(false);
  const [checking, setChecking] = useState(false);
  const [loading, setLoading] = useState(false);
  const [emailInput, setEmailInput] = useState("");
  const [msg, setMsg] = useState({ text: "", type: "" });

  useEffect(() => {
    if (effectiveAuthenticated && effectiveUser?.email) {
      setChecking(true);
      fetch(getApiUrl(`subscribe.php?action=check&creator_identifier=${encodeURIComponent(creatorIdentifier)}&subscriber_email=${encodeURIComponent(effectiveUser.email)}`), {
        credentials: 'include'
      })
        .then(res => res.json())
        .then(data => {
          setIsSubscribed(!!data.subscribed);
          setIsSelf(!!data.is_self);
        })
        .catch(err => console.error("Error checking subscription status:", err))
        .finally(() => setChecking(false));
    }
  }, [creatorIdentifier, effectiveAuthenticated, effectiveUser?.email]);

  const handleSubscribeToggle = async () => {
    if (!effectiveAuthenticated || !effectiveUser?.email) {
      loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } });
      return;
    }
    setLoading(true);
    setMsg({ text: "", type: "" });
    const action = isSubscribed ? "unsubscribe" : "subscribe";
    
    try {
      const res = await fetch(getApiUrl("subscribe.php"), {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({
          action,
          creator_identifier: creatorIdentifier,
          subscriber_email: effectiveUser.email
        })
      });
      const data = await res.json();
      if (res.ok && !data.error) {
        setIsSubscribed(!isSubscribed);
        setMsg({
          text: isSubscribed ? "Unsubscribed successfully." : "Subscribed successfully! You will receive email notifications for new posts.",
          type: "success"
        });
      } else {
        throw new Error(data.error || "Failed to toggle subscription.");
      }
    } catch (err) {
      setMsg({ text: err.message, type: "error" });
    } finally {
      setLoading(false);
    }
  };

  const handleGuestSubscribe = async (e) => {
    e.preventDefault();
    setMsg({ text: "Please log in to subscribe with your account email.", type: "error" });
  };

  if (isSelf) {
    return (
      <div className="bg-[var(--paper-raised)]/30 border border-[var(--rule)] rounded-2xl p-6 shadow-xl flex items-center justify-center">
        <p className="text-xs text-[var(--ink-soft)] font-semibold">This is your public author profile view.</p>
      </div>
    );
  }

  return (
    <div className="bg-[var(--paper-raised)]/30 border border-[var(--rule)] rounded-2xl p-6 shadow-xl space-y-4">
      <div className="flex items-center gap-3">
        <div className="p-2.5 rounded-xl bg-[var(--stamp)]/10 text-[var(--link)] border border-[var(--stamp)]/10">
          <FaBell className="text-sm" />
        </div>
        <div>
          <h3 className="text-sm font-bold text-[var(--ink)]">Subscribe to {creatorName}</h3>
          <p className="text-3xs text-[var(--ink-soft)] mt-0.5">Get notified immediately by email when new articles are published.</p>
        </div>
      </div>

      {msg.text && (
        <div className={`p-3 rounded-lg border text-3xs font-semibold ${
          msg.type === "success" ? "bg-green-950/20 border-green-800/30 text-green-400" : "bg-red-950/20 border-red-800/30 text-red-400"
        }`}>
          {msg.text}
        </div>
      )}

      {effectiveAuthenticated ? (
        checking ? (
          <div className="flex items-center gap-2 text-3xs text-[var(--ink-soft)]">
            <FaSpinner className="animate-spin text-[var(--link)]" /> Checking subscription status...
          </div>
        ) : (
          <button
            onClick={handleSubscribeToggle}
            disabled={loading}
            className={`w-full py-2.5 rounded-xl text-xs font-bold transition-all shadow-md flex items-center justify-center gap-2 cursor-pointer ${
              isSubscribed 
                ? "bg-[var(--paper-raised)] border border-[var(--rule)] text-[var(--ink-soft)] hover:text-red-400 hover:border-red-950/30" 
                : "bg-[var(--stamp)] text-slate-950 hover:bg-[var(--stamp)]"
            }`}
          >
            {loading ? (
              <FaSpinner className="animate-spin" />
            ) : isSubscribed ? (
              <>
                <FaBellSlash /> Unsubscribe from notifications
              </>
            ) : (
              <>
                <FaBell /> Enable Email Notifications
              </>
            )}
          </button>
        )
      ) : (
        <div className="rounded-2xl border border-[var(--rule)] bg-[var(--paper-raised)]/40 p-4 text-xs text-[var(--ink-soft)] space-y-3">
          <p>Please log in to subscribe with your verified account email.</p>
          <button
            type="button"
            onClick={() => loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } })}
            className="w-full rounded-xl bg-[var(--stamp)] px-4 py-2 text-xs font-bold text-slate-950 transition hover:bg-[var(--stamp)]"
          >
            Login to Subscribe
          </button>
        </div>
      )}
    </div>
  );
}
