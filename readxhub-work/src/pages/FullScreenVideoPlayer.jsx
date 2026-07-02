import React, { useEffect, useRef, useState } from "react";
import { Play, Pause, Maximize, Minimize, X } from "lucide-react";

/* ---------- SAFE Floating Watermark ---------- */
const FloatingWatermark = () => {
  const [style, setStyle] = useState({});

  useEffect(() => {
    const move = () => {
      setStyle({
        top: `${Math.random() * 80 + 10}%`,
        left: `${Math.random() * 80 + 10}%`,
        transform: "translate(-50%, -50%)",
      });
    };

    move();
    const i = setInterval(move, 4000);
    return () => clearInterval(i);
  }, []);

  return (
    <div
      style={style}
      className="absolute z-40 text-gray-300 text-sm font-mono pointer-events-none select-none
                 transition-all duration-2000 opacity-70"
    >
      ReadXHub
    </div>
  );
};

/* ---------- FullScreenVideoPlayer ---------- */
const FullScreenVideoPlayer = ({ videoId, onClose }) => {
  const playerRef = useRef(null);
  const playerInstance = useRef(null);
  const containerRef = useRef(null);
  const seekbarRef = useRef(null);

  const [isPlaying, setIsPlaying] = useState(true);
  const [isFullscreen, setIsFullscreen] = useState(false);
  const [currentTime, setCurrentTime] = useState(0);
  const [duration, setDuration] = useState(0);
  const lastTapTimeRef = useRef(0);
  const lastTapSideRef = useRef(null);
  const clickTimeoutRef = useRef(null);

  /* ---------- ESC to close ---------- */
  useEffect(() => {
    const handleKey = (e) => {
      if (e.key === "Escape") onClose();
    };
    document.addEventListener("keydown", handleKey);
    return () => document.removeEventListener("keydown", handleKey);
  }, [onClose]);

  /* ---------- Disable right click ---------- */
  useEffect(() => {
    const block = (e) => e.preventDefault();
    document.addEventListener("contextmenu", block);
    return () => document.removeEventListener("contextmenu", block);
  }, []);

  /* ---------- YouTube Init ---------- */
  useEffect(() => {
    const onReady = (e) => {
      setDuration(e.target.getDuration());
      setIsPlaying(true);
    };

    const createPlayer = () => {
      playerInstance.current?.destroy();

      playerInstance.current = new window.YT.Player(playerRef.current, {
        videoId,
        playerVars: {
          autoplay: 1,
          controls: 0,
          rel: 0,
          modestbranding: 1,
          disablekb: 1,
        },
        events: {
          onReady,
          onStateChange: (e) =>
            setIsPlaying(e.data === window.YT.PlayerState.PLAYING),
        },
      });
    };

    if (window.YT?.Player) {
      createPlayer();
    } else {
      window.onYouTubeIframeAPIReady = createPlayer;
      if (!window.__ytLoaded) {
        const s = document.createElement("script");
        s.src = "https://www.youtube.com/iframe_api";
        document.body.appendChild(s);
        window.__ytLoaded = true;
      }
    }

    return () => playerInstance.current?.destroy();
  }, [videoId]);

  /* ---------- Time update ---------- */
  useEffect(() => {
    if (!isPlaying) return;
    const i = setInterval(() => {
      const t = playerInstance.current?.getCurrentTime?.();
      if (t != null) setCurrentTime(t);
    }, 500);
    return () => clearInterval(i);
  }, [isPlaying]);

  /* ---------- Controls ---------- */
  const togglePlay = () =>
    isPlaying
      ? playerInstance.current.pauseVideo()
      : playerInstance.current.playVideo();

  const handleSeek = (e) => {
    const r = seekbarRef.current.getBoundingClientRect();
    const t = ((e.clientX - r.left) / r.width) * duration;
    playerInstance.current.seekTo(t, true);
    setCurrentTime(t);
  };

  const skipTime = (seconds) => {
    if (!playerInstance.current) return;
    const time = Math.max(
      0,
      Math.min(
        duration,
        (playerInstance.current.getCurrentTime?.() || currentTime) + seconds
      )
    );
    playerInstance.current.seekTo(time, true);
    setCurrentTime(time);
  };

  const handleSkip = (side) => skipTime(side === "left" ? -10 : 10);

  const handleTap = (side) => {
    const now = Date.now();
    if (now - lastTapTimeRef.current < 300 && lastTapSideRef.current === side) {
      if (clickTimeoutRef.current) {
        clearTimeout(clickTimeoutRef.current);
        clickTimeoutRef.current = null;
      }
      handleSkip(side);
      lastTapTimeRef.current = 0;
      lastTapSideRef.current = null;
      return;
    }

    lastTapTimeRef.current = now;
    lastTapSideRef.current = side;

    if (clickTimeoutRef.current) clearTimeout(clickTimeoutRef.current);
    clickTimeoutRef.current = setTimeout(() => {
      togglePlay();
      clickTimeoutRef.current = null;
      lastTapTimeRef.current = 0;
      lastTapSideRef.current = null;
    }, 250);
  };

  const handleTouchEnd = (event) => {
    const touch = event.changedTouches?.[0];
    if (!touch || !containerRef.current) return;
    const rect = containerRef.current.getBoundingClientRect();
    const side = touch.clientX - rect.left < rect.width / 2 ? "left" : "right";
    handleTap(side);
  };

  const lockLandscapeOrientation = async () => {
    if (screen.orientation?.lock) {
      try {
        await screen.orientation.lock("landscape");
      } catch {}
    }
  };

  const unlockOrientation = async () => {
    if (screen.orientation?.unlock) {
      try {
        screen.orientation.unlock();
      } catch {}
    }
  };

  const toggleFullscreen = async () => {
    try {
      if (!document.fullscreenElement) {
        await containerRef.current.requestFullscreen();
        await lockLandscapeOrientation();
      } else {
        await document.exitFullscreen();
        await unlockOrientation();
      }
    } catch {}
  };

  useEffect(() => {
    const f = () => setIsFullscreen(!!document.fullscreenElement);
    document.addEventListener("fullscreenchange", f);
    return () => document.removeEventListener("fullscreenchange", f);
  }, []);

  const formatTime = (t) =>
    `${String(Math.floor(t / 60)).padStart(2, "0")}:${String(
      Math.floor(t % 60)
    ).padStart(2, "0")}`;

  return (
    <div
      ref={containerRef}
      className="fixed inset-0 z-[100] bg-[var(--paper)] flex items-center justify-center"
      onClick={onClose}
    >
      {/* ❌ Close button */}
      <button
        onClick={onClose}
        className={`absolute top-4 right-5 z-50 p-2 rounded-full text-gray-300 hover:bg-gray-800
        ${isFullscreen ? "opacity-0 pointer-events-none" : ""}`}
      >
        <X size={32} />
      </button>

      {/* Video box */}
      <div
        className={`relative w-full h-full ${isFullscreen ? "max-w-none aspect-[16/9]" : "max-w-7xl aspect-video"} bg-black rounded-lg overflow-hidden`}
        onClick={(e) => e.stopPropagation()}
      >
        <div ref={playerRef} className="w-full h-full" />

        {/* Click / double-tap overlay */}
        <div className="absolute inset-0 z-20 grid grid-cols-2">
          <div
            className="h-full"
            onClick={() => handleTap("left")}
            onTouchEnd={(e) => {
              e.preventDefault();
              handleTouchEnd(e);
            }}
          />
          <div
            className="h-full"
            onClick={() => handleTap("right")}
            onTouchEnd={(e) => {
              e.preventDefault();
              handleTouchEnd(e);
            }}
          />
        </div>

        <div className="pointer-events-none absolute inset-y-0 left-0 w-1/2 flex items-center justify-center">
          <span className="text-[10px] text-white/70">Double tap left to rewind 10s</span>
        </div>
        <div className="pointer-events-none absolute inset-y-0 right-0 w-1/2 flex items-center justify-center">
          <span className="text-[10px] text-white/70">Double tap right to skip 10s</span>
        </div>

        <FloatingWatermark />

        {/* Controls */}
        <div className="absolute bottom-0 left-0 w-full p-4 z-40 bg-gradient-to-t from-black/90 to-transparent">
          <div
            ref={seekbarRef}
            onClick={handleSeek}
            className="h-1 bg-gray-700 rounded cursor-pointer"
          >
            <div
              className="h-full bg-gray-300"
              style={{ width: `${(currentTime / duration) * 100}%` }}
            />
          </div>

          <div className="flex items-center gap-4 mt-3 text-gray-200">
            <button onClick={togglePlay}>
              {isPlaying ? <Pause /> : <Play />}
            </button>

            <span className="text-xs">
              {formatTime(currentTime)} / {formatTime(duration)}
            </span>

            <button onClick={toggleFullscreen} className="ml-auto">
              {isFullscreen ? <Minimize /> : <Maximize />}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default FullScreenVideoPlayer;
