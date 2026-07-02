export const getStoredAuthUser = () => {
  if (typeof window === 'undefined') return null;
  try {
    const saved = localStorage.getItem("readxhub_user");
    return saved ? JSON.parse(saved) : null;
  } catch (err) {
    console.error("Failed to parse stored auth user:", err);
    return null;
  }
};

export const getAuthTokenEmail = () => {
  if (typeof document === 'undefined') return null;
  try {
    const match = document.cookie.match(/(?:^|; )auth_token=([^;]+)/);
    return match ? decodeURIComponent(match[1]) : null;
  } catch {
    return null;
  }
};

export const getOfflineAuthUser = () => {
  const storedUser = getStoredAuthUser();
  if (storedUser?.email) return storedUser;
  const tokenEmail = getAuthTokenEmail();
  return tokenEmail ? { email: tokenEmail } : null;
};

export const isOfflineAuthenticated = () => Boolean(getOfflineAuthUser());
