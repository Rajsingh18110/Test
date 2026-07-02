import React, { useEffect } from 'react';
import Cookies from 'js-cookie';
import { getApiUrl } from './utils/api.js';

const IsLogged = () => {
  useEffect(() => {
    console.log("🔁 useEffect: Starting login check...");

    // Check local session cookie first to allow offline/local login
    if (Cookies.get("auth_token")) {
      console.log("Offline/Persistent login detected via local cookie.");
      return;
    }

    const requestUrl = getApiUrl("verify_login.php");
    const requestOptions = {
      method: "GET",
      credentials: "include", // Ensure cookies are sent
    };

    // console.log("🌐 Fetching:", requestUrl);
    // console.log("📦 Request Options:", requestOptions);

    fetch(requestUrl, requestOptions)
      .then((res) => {
        // console.log("✅ Received response:", res);
        if (!res.ok) {
          throw new Error(`❌ HTTP error! Status: ${res.status}`);
        }
        return res.json();
      })
      .then((data) => {
        // console.log("📨 Parsed JSON:", data);
        if (!data.logged_in) {
          // console.warn("⛔ Not logged in. Redirecting...");
          window.location.href = "/";
        } else {
          // console.log("✅ User is logged in as:", data.email);
        }
      })
      .catch((err) => {
        // console.error("🚨 Auth check failed:", err);
      });
  }, []);

  return <></>;
};

export default IsLogged;
