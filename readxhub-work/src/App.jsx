import { BrowserRouter as Router, Routes, Route, Link, useLocation } from "react-router-dom";
import React, { useEffect, Suspense, lazy } from "react";

function ScrollToTop() {
  const { pathname } = useLocation();

  useEffect(() => {
    window.scrollTo(0, 0);
  }, [pathname]);

  return null;
}

function PreLoader() {
  return (
    <div className="min-h-screen bg-[#030712] flex flex-col items-center justify-center relative overflow-hidden select-none">
      <div className="absolute w-64 h-64 bg-cyan-500/10 rounded-full blur-3xl animate-pulse pointer-events-none" style={{ animationDuration: '3s' }} />
      <div className="absolute w-48 h-48 bg-blue-500/5 rounded-full blur-3xl pointer-events-none" />
      <div className="relative flex items-center justify-center">
        <div className="w-16 h-16 rounded-full border-2 border-slate-800 border-t-cyan-500 animate-spin" style={{ animationDuration: '0.8s' }} />
        <div className="absolute text-[10px] uppercase tracking-widest font-black text-cyan-400 animate-pulse">
          TS
        </div>
      </div>
      <div className="mt-4 text-xs font-bold uppercase tracking-widest text-slate-500 animate-pulse" style={{ animationDuration: '1.5s' }}>
        Loading
      </div>
    </div>
  );
}

import Navbar from "./components/Navbar";

// Code splitting
const Blogs = lazy(() => import("./pages/Home"));
const BlogDetails = lazy(() => import("./pages/BlogDetail"));
const Profile = lazy(() => import("./pages/Profile"));
const BeACreator = lazy(() => import("./Logged/BeACreator"));
const Dashboard = lazy(() => import("./Logged/Dashboard"));
const CreatePost = lazy(() => import("./Logged/CreatePost"));
const Post = lazy(() => import("./pages/Post"));
const EditPost = lazy(() => import("./Logged/EditPost"));
const ViewMore = lazy(() => import("./pages/View-More"));
const NotFound = lazy(() => import("./pages/NotFound"));
const AuthorProfile = lazy(() => import("./pages/AuthorProfile"));
const Subscriptions = lazy(() => import("./pages/Subscriptions"));
const MarkdownTutorial = lazy(() => import("./pages/MarkdownTutorial"));
const About = lazy(() => import("./pages/About"));
const Contact = lazy(() => import("./pages/Contact"));
const PrivacyPolicy = lazy(() => import("./pages/PrivacyPolicy"));
const TermsAndConditions = lazy(() => import("./pages/TermsAndConditions"));
const APIDocs = lazy(() => import("./pages/APIDocs"));

function App() {
  return (
    <Router>
      <ScrollToTop />
      <Navbar />
      <Suspense fallback={<PreLoader />}>
        <Routes>
          <Route path="/" element={<Blogs />} />
          <Route path="/profile" element={<Profile />} />
          <Route path="/blog/:slug" element={<BlogDetails />} />
          <Route path="/beacreator" element={<BeACreator />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/createapost" element={<CreatePost />} />
          <Route path="/post/:slug" element={<Post />} />
          <Route path="/edit/:slug" element={<EditPost />} />
          <Route path="/ViewMore/:id" element={<ViewMore />} />
          <Route path="/author/:identifier" element={<AuthorProfile />} />
          <Route path="/subscriptions" element={<Subscriptions />} />
          <Route path="/markdown-tutorial" element={<MarkdownTutorial />} />
          <Route path="/about" element={<About />} />
          <Route path="/contact" element={<Contact />} />
          <Route path="/privacy-policy" element={<PrivacyPolicy />} />
          <Route path="/terms-and-conditions" element={<TermsAndConditions />} />
          <Route path="/api-docs" element={<APIDocs />} />
          <Route path="*" element={<NotFound />} />
        </Routes>
      </Suspense>
      <footer className="border-t border-slate-800/80 bg-[#030712]">
        <div className="mx-auto flex max-w-7xl flex-col gap-3 px-4 py-6 text-sm text-slate-500 sm:px-6 lg:px-8 md:flex-row md:items-center md:justify-between">
          <p>© 2026 ReadXHub. All rights reserved.</p>
          <div className="flex flex-wrap items-center gap-4">
            <Link to="/about" className="transition hover:text-cyan-400">About</Link>
            <Link to="/contact" className="transition hover:text-cyan-400">Contact</Link>
            <Link to="/privacy-policy" className="transition hover:text-cyan-400">Privacy Policy</Link>
            <Link to="/terms-and-conditions" className="transition hover:text-cyan-400">Terms</Link>
          </div>
        </div>
      </footer>
    </Router>
  );
}

export default App;
