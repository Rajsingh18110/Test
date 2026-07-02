import React from "react";
import { Link } from "react-router-dom";
import { FaExclamationTriangle, FaArrowLeft } from "react-icons/fa";

export default function NotFound() {
  return (
    <main className="min-h-screen bg-[var(--paper)] text-[var(--ink)] flex items-center justify-center p-6 selection:bg-[var(--stamp)]/30 selection:text-[var(--link)]">
      <div className="max-w-md w-full bg-[var(--paper-raised)]/40 border border-[var(--rule)] rounded-2xl p-8 text-center shadow-xl space-y-6">
        <div className="w-16 h-16 bg-red-500/10 border border-red-500/20 rounded-2xl flex items-center justify-center text-red-400 mx-auto shadow-md shadow-red-950/5">
          <FaExclamationTriangle className="text-2xl" />
        </div>
        
        <div className="space-y-2">
          <h1 className="text-4xl font-extrabold text-[var(--ink)] tracking-tight">404</h1>
          <h2 className="text-lg font-bold text-[var(--ink)]">Cosmic Coordinates Lost</h2>
          <p className="text-xs text-[var(--ink-soft)] leading-relaxed max-w-xs mx-auto">
            The page you are looking for has drifted out of ReadXHub orbit or was never published.
          </p>
        </div>

        <div className="pt-2">
          <Link 
            to="/" 
            className="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl bg-[var(--stamp)] hover:bg-[var(--stamp)] text-slate-950 text-xs font-bold transition-all shadow-md active:scale-98"
          >
            <FaArrowLeft /> Return to ReadXHub
          </Link>
        </div>
      </div>
    </main>
  );
}
