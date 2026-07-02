import React, { useEffect, useState } from "react";
import { FaTimes } from "react-icons/fa";
import { getApiUrl } from "../utils/api.js";

// Global cache for advertisements promise to avoid multiple parallel API requests
let adsCachePromise = null;
let cachedAdsData = null;

const fetchAdsData = () => {
  if (cachedAdsData) {
    return Promise.resolve(cachedAdsData);
  }
  if (adsCachePromise) {
    return adsCachePromise;
  }

  adsCachePromise = fetch(getApiUrl("get_advertisements.php"))
    .then((res) => {
      if (!res.ok) throw new Error("Failed to fetch ads");
      return res.json();
    })
    .then((json) => {
      if (json.success && json.data) {
        cachedAdsData = json.data;
        return json.data;
      }
      return {};
    })
    .catch((err) => {
      console.error("AdSlot fetch error:", err);
      return {};
    });

  return adsCachePromise;
};

export default function AdSlot({ name, placeholder }) {
  const [ad, setAd] = useState(null);
  const [loading, setLoading] = useState(true);
  const [isDismissed, setIsDismissed] = useState(false);

  useEffect(() => {
    fetchAdsData()
      .then((data) => {
        if (data && data[name] && Array.isArray(data[name]) && data[name].length > 0) {
          const randomIndex = Math.floor(Math.random() * data[name].length);
          setAd(data[name][randomIndex]);
        }
      })
      .finally(() => {
        setLoading(false);
      });
  }, [name]);

  if (isDismissed) {
    return null;
  }

  if (loading) {
    return null;
  }

  if (ad && ad.image_url) {
    // Resolve relative backend media path
    let imageUrl = ad.image_url;
    if (!imageUrl.startsWith("http://") && !imageUrl.startsWith("https://") && !imageUrl.startsWith("data:")) {
      imageUrl = getApiUrl(imageUrl);
    }

    // Determine container classes
    let containerClass = "relative group/ad w-full overflow-hidden rounded-2xl border border-[var(--rule)] bg-[var(--paper-raised)]/20 shadow-xl transition-all duration-300 hover:border-[var(--stamp)]/20";
    if (name === "sidebar") {
      containerClass += " max-w-sm mx-auto";
    } else if (name === "in_article") {
      containerClass += " my-8";
    } else {
      containerClass += " my-4";
    }

    return (
      <div className={containerClass} id={`ad-container-${name}`}>
        {/* Close button to remove the ad section completely */}
        <button
          onClick={() => setIsDismissed(true)}
          className="absolute top-2.5 right-2.5 w-6 h-6 rounded-full bg-black/70 hover:bg-black/90 text-[var(--ink-soft)] hover:text-[var(--ink)] flex items-center justify-center text-xs transition-colors z-20 cursor-pointer border border-[var(--rule)]"
          title="Remove Advertisement"
        >
          <FaTimes className="text-[10px]" />
        </button>

        {/* Ad Indicator Badge */}
        <span className="absolute bottom-2.5 right-2.5 px-1.5 py-0.5 rounded-md bg-black/70 text-[8px] text-[var(--ink-soft)] uppercase tracking-widest font-extrabold select-none z-10 border border-[var(--rule)] pointer-events-none">
          Ad
        </span>

        <a
          href={ad.link_url}
          target="_blank"
          rel="noopener noreferrer"
          className="block w-full"
          id={`ad-slot-${name}`}
        >
          <img
            src={imageUrl}
            alt={ad.alt_text || `Advertisement - ${name}`}
            className="w-full h-auto block object-contain"
            loading="lazy"
          />
        </a>
      </div>
    );
  }

  return null;
}
