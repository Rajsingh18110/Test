export const getApiUrl = (path) => {
  if (!path) return "https://blogs.readxhub.in/";
  if (path.startsWith("http://") || path.startsWith("https://")) return path;
  return `https://blogs.readxhub.in/${path}`;
};
