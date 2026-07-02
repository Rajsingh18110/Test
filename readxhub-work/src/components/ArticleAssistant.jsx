import React, { useContext, useEffect, useState } from "react";
import { FaRobot, FaPaperPlane, FaCircleNotch } from "react-icons/fa";
import { useAuth0 } from "@auth0/auth0-react";
import { AuthContext } from "../AuthProvider.jsx";
import { getApiUrl } from "../utils/api.js";

const MODE_OPTIONS = [
  { key: "ask", label: "Ask a question", placeholder: "Ask about this article, research topic, or writing details..." },
  { key: "detect", label: "Detect AI content", placeholder: "Paste text to analyze whether it appears AI-generated..." },
  { key: "research", label: "Research help", placeholder: "Ask for deeper research, comparisons, or follow-up ideas..." },
];

export default function ArticleAssistant({
  title,
  description,
  placeholder = "Ask a question or analyze text...",
  contextLabel,
  context,
  initialPrompt = "",
}) {
  const { user: auth0User, isAuthenticated: auth0IsAuthenticated, isLoading: auth0IsLoading } = useAuth0();
  const { user: localUser } = useContext(AuthContext) || {};
  
  // Check both Auth0 and local authentication
  // Auth0 takes priority, but fall back to local auth if available
  const isAuth0User = auth0IsAuthenticated && auth0User?.email;
  const isLocalUser = localUser?.email;

  // Fallback checks: cookie or localStorage may indicate a signed-in user
  let isLocalCookie = false;
  let cookieEmail = null;
  try {
    isLocalCookie = typeof document !== 'undefined' && document.cookie.includes('auth_token=');
    const m = (typeof document !== 'undefined' && document.cookie.match(/auth_token=([^;]+)/)) || null;
    cookieEmail = m ? decodeURIComponent(m[1]) : null;
  } catch (e) {
    isLocalCookie = false;
    cookieEmail = null;
  }

  const localStorageEmail = (() => {
    try {
      const s = localStorage.getItem('readxhub_user');
      if (!s) return null;
      const obj = JSON.parse(s);
      return obj?.email || null;
    } catch (e) { return null; }
  })();

  const isSignedIn = Boolean(isAuth0User || isLocalUser || isLocalCookie || localStorageEmail);
  const userEmail = auth0User?.email || localUser?.email || cookieEmail || localStorageEmail || null;
  
  // We're ready to interact once Auth0 has finished loading
  // Don't wait for Auth0 if user is already logged in locally
  const isReady = !auth0IsLoading || isLocalUser;
  
  const [mode, setMode] = useState("ask");
  const [prompt, setPrompt] = useState(initialPrompt);
  const [response, setResponse] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    setPrompt(initialPrompt);
  }, [initialPrompt]);

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError("");
    setResponse("");

    const trimmedPrompt = prompt.trim();
    const needsPrompt = mode !== "detect" || !context;
    if (!trimmedPrompt && needsPrompt) {
      setError("Please enter a question or text to analyze.");
      return;
    }

    if (!isSignedIn) {
      setError("Please sign in to use the assistant.");
      return;
    }

    const requestPrompt = trimmedPrompt || "Please determine whether the provided content appears to be AI-generated or human-created.";
    setLoading(true);

    try {
      const res = await fetch(getApiUrl("assistant_chat.php"), {
        method: "POST",
        credentials: "include",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          prompt: requestPrompt,
          context: context || "",
          contextLabel: contextLabel || "",
          mode,
          client_email: userEmail || null,
        }),
      });

      const data = await res.json();
      if (!res.ok || !data.success) {
        setError(data.error || "Assistant request failed. Please try again.");
      } else {
        setResponse(data.assistant || "No answer returned.");
      }
    } catch (err) {
      console.error("Assistant request failed:", err);
      setError("Unable to reach the assistant. Please try again later.");
    } finally {
      setLoading(false);
    }
  };

  const activePlaceholder = (
    MODE_OPTIONS.find((item) => item.key === mode)?.placeholder || placeholder
  );

  return (
    <section className="rounded-3xl border border-[var(--rule)] bg-[var(--paper-raised)]/70 p-6 shadow-2xl backdrop-blur-xl">
      <div className="flex items-start gap-4">
        <div className="w-11 h-11 rounded-2xl bg-[var(--stamp)]/10 border border-[var(--stamp)]/20 grid place-items-center text-[var(--link)]">
          <FaRobot className="text-lg" />
        </div>
        <div className="min-w-0">
          <p className="text-[10px] uppercase tracking-[0.4em] text-[var(--link)] font-bold mb-2">{title}</p>
          <p className="text-sm text-[var(--ink-soft)] leading-6">{description}</p>
        </div>
      </div>

      {context ? (
        <div className="mt-5 rounded-2xl border border-[var(--rule)]/70 bg-[var(--paper-raised)]/60 p-4 text-xs text-[var(--ink-soft)]">
          <p className="font-semibold text-[var(--ink)] mb-2">{contextLabel || "Article context:"}</p>
          <p className="whitespace-pre-wrap break-words text-[var(--ink-soft)] max-h-36 overflow-hidden">{context}</p>
        </div>
      ) : null}

      <div className="mt-5 flex flex-wrap gap-2">
        {MODE_OPTIONS.map((item) => (
          <button
            key={item.key}
            type="button"
            onClick={() => setMode(item.key)}
            className={`rounded-full border px-4 py-2 text-[11px] font-semibold uppercase tracking-[0.14em] transition ${
              mode === item.key
                ? "border-[var(--stamp)] bg-[var(--stamp)]/15 text-cyan-200"
                : "border-[var(--rule)] bg-[var(--paper-raised)] text-[var(--ink-soft)] hover:border-slate-600 hover:text-[var(--ink)]"
            }`}
          >
            {item.label}
          </button>
        ))}
      </div>

      {!isReady ? (
        <div className="mt-5 rounded-2xl border border-slate-500/20 bg-slate-500/10 p-4 text-sm text-[var(--ink-soft)]">
          Authenticating with your account...
        </div>
      ) : !isSignedIn ? (
        <div className="mt-5 rounded-2xl border border-amber-500/20 bg-amber-500/10 p-4 text-sm text-amber-300">
          Please sign in to use the assistant. Each signed-in user can submit up to 10 requests per day.
        </div>
      ) : null}

      <form onSubmit={handleSubmit} className="mt-5 space-y-4">
        <label htmlFor="assistant-prompt" className="sr-only">
          Assistant prompt
        </label>
        <textarea
          id="assistant-prompt"
          rows={3}
          value={prompt}
          onChange={(e) => setPrompt(e.target.value)}
          placeholder={activePlaceholder}
          disabled={!isReady || !isSignedIn}
          className="w-full resize-none rounded-2xl border border-[var(--rule)]/90 bg-[var(--paper-raised)] px-4 py-3 text-sm text-[var(--ink)] placeholder:text-[var(--ink-soft)] focus:border-[var(--stamp)] focus:outline-none focus:ring-2 focus:ring-[var(--stamp)]/15 transition-colors disabled:cursor-not-allowed disabled:opacity-60"
        />

        <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
          <button
            type="submit"
            disabled={loading || !isReady || !isSignedIn}
            className="inline-flex items-center justify-center gap-2 rounded-2xl bg-[var(--stamp)] px-4 py-2 text-xs font-semibold uppercase tracking-[0.18em] text-slate-950 transition hover:bg-[var(--stamp)] disabled:cursor-not-allowed disabled:bg-[var(--stamp-bg)]"
          >
            {loading ? <FaCircleNotch className="animate-spin text-sm" /> : <FaPaperPlane className="text-xs" />}
            {loading
              ? "Thinking…"
              : mode === "detect"
              ? "Analyze content"
              : mode === "research"
              ? "Start research"
              : "Ask the assistant"}
          </button>
        </div>
      </form>

      {error ? (
        <div className="mt-4 rounded-2xl border border-red-500/20 bg-red-500/10 p-4 text-sm text-red-300">
          {error}
        </div>
      ) : null}

      {response ? (
        <div className="mt-4 rounded-3xl border border-[var(--rule)] bg-[var(--paper-raised)]/80 p-4 text-sm leading-6 text-[var(--ink)] whitespace-pre-line">
          {response}
        </div>
      ) : null}
    </section>
  );
}
