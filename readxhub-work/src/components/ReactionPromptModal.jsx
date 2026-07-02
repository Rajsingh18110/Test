import React, { useState, useEffect, useRef } from 'react';
import { FaThumbsUp, FaThumbsDown, FaTimes, FaHeart } from 'react-icons/fa';

/* ---------- Web Audio Pop Sound (no external URL needed) ---------- */
export const playPopSound = () => {
  try {
    const ctx = new (window.AudioContext || window.webkitAudioContext)();

    // Oscillator 1 — main pop tone
    const osc = ctx.createOscillator();
    const gainNode = ctx.createGain();
    osc.connect(gainNode);
    gainNode.connect(ctx.destination);

    osc.type = 'sine';
    osc.frequency.setValueAtTime(520, ctx.currentTime);
    osc.frequency.exponentialRampToValueAtTime(180, ctx.currentTime + 0.08);

    gainNode.gain.setValueAtTime(0.5, ctx.currentTime);
    gainNode.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + 0.12);

    osc.start(ctx.currentTime);
    osc.stop(ctx.currentTime + 0.13);

    // Oscillator 2 — high click layer
    const osc2 = ctx.createOscillator();
    const gain2 = ctx.createGain();
    osc2.connect(gain2);
    gain2.connect(ctx.destination);

    osc2.type = 'triangle';
    osc2.frequency.setValueAtTime(900, ctx.currentTime);
    osc2.frequency.exponentialRampToValueAtTime(300, ctx.currentTime + 0.05);
    gain2.gain.setValueAtTime(0.25, ctx.currentTime);
    gain2.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + 0.06);

    osc2.start(ctx.currentTime);
    osc2.stop(ctx.currentTime + 0.07);
  } catch (e) {
    // silently ignore if audio context is unavailable
  }
};

export default function ReactionPromptModal({ isOpen, onClose, onReact, blogId }) {
  const [visible, setVisible] = useState(false);
  const [animOut, setAnimOut] = useState(false);
  const [reacted, setReacted] = useState(false);
  const [reactedType, setReactedType] = useState(null);

  // Check localStorage to see if user already reacted to this blog
  useEffect(() => {
    if (!blogId) return;
    const key = `readxhub_reacted_${blogId}`;
    if (localStorage.getItem(key)) {
      // User has already reacted — never show the modal for this blog
      onClose();
    }
  }, [blogId]);

  // Animate in when modal opens
  useEffect(() => {
    if (isOpen && !animOut) {
      const t = setTimeout(() => setVisible(true), 30);
      return () => clearTimeout(t);
    }
  }, [isOpen]);

  const dismiss = (animated = true) => {
    if (animated) {
      setAnimOut(true);
      setTimeout(() => {
        setVisible(false);
        setAnimOut(false);
        onClose();
      }, 340);
    } else {
      setVisible(false);
      onClose();
    }
  };

  const handleReact = (type) => {
    if (reacted) return;

    // Mark as reacted in localStorage
    if (blogId) {
      localStorage.setItem(`readxhub_reacted_${blogId}`, type);
    }

    setReacted(true);
    setReactedType(type);
    playPopSound();

    // Let the "thank you" animation play briefly, then dismiss
    setTimeout(() => {
      dismiss(true);
      onReact(type);
    }, 600);
  };

  if (!isOpen) return null;

  return (
    <div
      className="fixed inset-0 flex items-end sm:items-center justify-center z-50 p-4"
      style={{
        background: visible && !animOut ? 'rgba(0,0,0,0.45)' : 'rgba(0,0,0,0)',
        backdropFilter: visible && !animOut ? 'blur(4px)' : 'none',
        transition: 'background 0.3s ease, backdrop-filter 0.3s ease',
      }}
      onClick={(e) => { if (e.target === e.currentTarget) dismiss(); }}
    >
      <div
        style={{
          transform: animOut
            ? 'scale(0.7) translateY(30px)'
            : visible
            ? 'scale(1) translateY(0px)'
            : 'scale(0.85) translateY(30px)',
          opacity: animOut ? 0 : visible ? 1 : 0,
          transition: animOut
            ? 'all 0.32s cubic-bezier(0.4,0,0.2,1)'
            : 'all 0.28s cubic-bezier(0.34,1.56,0.64,1)',
        }}
        className="relative bg-[var(--paper-raised)] border border-[var(--rule-strong)]/80 rounded-2xl shadow-2xl w-full max-w-xs p-6 overflow-hidden"
      >
        {/* Subtle glow background */}
        <div className="absolute inset-0 bg-gradient-to-br from-[var(--stamp)]/5 via-transparent to-pink-500/5 pointer-events-none rounded-2xl" />

        {/* Close button */}
        <button
          onClick={() => dismiss()}
          className="absolute top-3 right-3 w-6 h-6 flex items-center justify-center rounded-full bg-[var(--stamp-bg)] hover:bg-[var(--stamp-bg)] text-[var(--ink-soft)] hover:text-[var(--ink-soft)] transition-all cursor-pointer"
        >
          <FaTimes className="text-[10px]" />
        </button>

        {!reacted ? (
          <>
            <div className="text-center mb-1">
              <span className="text-2xl">🎉</span>
            </div>
            <h2 className="text-sm font-bold text-center text-[var(--ink)] mb-1">
              Enjoying the article?
            </h2>
            <p className="text-xs text-[var(--ink-soft)] text-center mb-5 leading-relaxed">
              A quick reaction means a lot to the author!
            </p>

            <div className="flex justify-center gap-4">
              <button
                onClick={() => handleReact('like')}
                className="group flex items-center gap-2 px-5 py-2.5 rounded-xl bg-[var(--stamp)]/10 hover:bg-[var(--stamp)]/20 border border-[var(--stamp)]/20 hover:border-[var(--stamp)]/40 text-[var(--link)] hover:text-[var(--link)] font-bold text-sm transition-all hover:scale-105 active:scale-95 cursor-pointer"
              >
                <FaThumbsUp className="group-hover:animate-bounce text-base" />
                Like
              </button>
              <button
                onClick={() => handleReact('dislike')}
                className="group flex items-center gap-2 px-5 py-2.5 rounded-xl bg-rose-500/10 hover:bg-rose-500/20 border border-rose-500/20 hover:border-rose-400/40 text-rose-400 hover:text-rose-300 font-bold text-sm transition-all hover:scale-105 active:scale-95 cursor-pointer"
              >
                <FaThumbsDown className="group-hover:animate-bounce text-base" />
                Dislike
              </button>
            </div>

            <p className="text-center text-[10px] text-[var(--ink-soft)] mt-4">
              You won't be asked again for this article
            </p>
          </>
        ) : (
          /* Thank-you micro-animation */
          <div className="text-center py-2">
            <div
              style={{
                animation: 'reactionPop 0.5s cubic-bezier(0.34,1.56,0.64,1) forwards',
              }}
            >
              {reactedType === 'like' ? (
                <FaThumbsUp className="text-4xl text-[var(--link)] mx-auto mb-2" />
              ) : (
                <FaThumbsDown className="text-4xl text-rose-400 mx-auto mb-2" />
              )}
            </div>
            <p className="text-sm font-bold text-[var(--ink)]">
              {reactedType === 'like' ? 'Thank you! 🎉' : 'Got it, thanks!'}
            </p>
            <p className="text-xs text-[var(--ink-soft)] mt-1">
              Your feedback matters.
            </p>
          </div>
        )}
      </div>

      <style>{`
        @keyframes reactionPop {
          0%   { transform: scale(0.5) rotate(-15deg); opacity: 0; }
          60%  { transform: scale(1.3) rotate(5deg); opacity: 1; }
          100% { transform: scale(1) rotate(0deg); opacity: 1; }
        }
      `}</style>
    </div>
  );
}
