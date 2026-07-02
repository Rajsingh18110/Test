import React, { createContext, useEffect, useState } from "react";
import { getApiUrl } from "./utils/api.js";
import { getOfflineAuthUser } from "./utils/auth.js";

export const AuthContext = createContext();

export default function AuthProvider({ children }) {
  const [user, setUser] = useState(() => getOfflineAuthUser());
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const localUser = getOfflineAuthUser();
    if (localUser) {
      setUser(localUser);
      setLoading(false);
      return;
    }

    if (typeof navigator !== "undefined" && !navigator.onLine) {
      setUser(null);
      setLoading(false);
      return;
    }

    fetch(getApiUrl("verify_login.php"), {
      credentials: "include",
    })
      .then((res) => res.json())
      .then((data) => {
        if (data.logged_in) {
          const userObj = { email: data.email };
          setUser(userObj);
          localStorage.setItem("readxhub_user", JSON.stringify(userObj));
        } else {
          setUser(null);
          localStorage.removeItem("readxhub_user");
        }
      })
      .catch((err) => {
        console.error("Session verification failed:", err);
      })
      .finally(() => {
        setLoading(false);
      });
  }, []);

  return (
    <AuthContext.Provider value={{ user, setUser, loading }}>
      {children}
    </AuthContext.Provider>
  );
}
