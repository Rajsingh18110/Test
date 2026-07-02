import React, { useState, useEffect, useRef } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import { 
    FaHome, FaGlobe, FaBars, FaTimes, FaSignInAlt, 
    FaSignOutAlt, FaPlusSquare, FaTachometerAlt, FaSpinner,
    FaSearch, FaBell, FaUser, FaChevronDown, FaUsers
} from "react-icons/fa";
import { useAuth0 } from "@auth0/auth0-react";
import Cookies from "js-cookie";
import { useContext } from "react";
import { AuthContext } from "../AuthProvider.jsx";
import { getApiUrl } from "../utils/api.js";
import { getOfflineAuthUser } from "../utils/auth.js";

const Navbar = () => {
    const location = useLocation();
    const navigate = useNavigate();
    const { loginWithRedirect, logout, isAuthenticated, user } = useAuth0();
    const offlineUser = getOfflineAuthUser();
    const effectiveUser = isAuthenticated && user?.email ? user : offlineUser;
    const effectiveAuthenticated = isAuthenticated || Boolean(offlineUser);
    const { setUser: setLocalUser } = useContext(AuthContext) || {};

    const [menuOpen, setMenuOpen] = useState(false);
    const [dropdownOpen, setDropdownOpen] = useState(false);
    const [isCreator, setIsCreator] = useState(false);
    const [isLoading, setIsLoading] = useState(true);
    const [navSearch, setNavSearch] = useState("");
    const dropdownRef = useRef(null);

    const resolveProfilePicture = (path) => {
        if (!path) return "";
        if (path.startsWith("http") || path.startsWith("data:")) return path;
        return getApiUrl(path);
    };

    const toggleMenu = () => setMenuOpen(!menuOpen);

    const handleSearchSubmit = (e) => {
        e.preventDefault();
        if (navSearch.trim()) {
            navigate(`/?q=${encodeURIComponent(navSearch.trim())}`);
        }
    };

    const handleLogout = () => {
        Cookies.remove("auth_token");
        localStorage.removeItem("readxhub_user");
        localStorage.removeItem("readxhub_user_picture");
        if (typeof setLocalUser === 'function') setLocalUser(null);
        logout({ returnTo: window.location.origin });
    };

    useEffect(() => {
        const checkCreatorStatus = async () => {
            setIsLoading(true);
            const authEmail = user?.email || getOfflineAuthUser()?.email;
            if (authEmail) {
                try {
                    Cookies.set("auth_token", authEmail, { expires: 365, sameSite: 'Lax' });
                    localStorage.setItem("readxhub_user", JSON.stringify({ email: authEmail }));
                    if (typeof setLocalUser === 'function') setLocalUser({ email: authEmail });

                    await fetch(getApiUrl("set_login_cookie.php"), {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        credentials: "include",
                        body: JSON.stringify({ email: authEmail }),
                    });

                    const creatorRes = await fetch(
                        getApiUrl(`check_email.php?email=${encodeURIComponent(authEmail)}`),
                        { credentials: "include" }
                    );
                    const data = await creatorRes.json();
                    setIsCreator(data.exists);
                    if (data.exists && data.profile_picture) {
                        localStorage.setItem("readxhub_user_picture", data.profile_picture);
                    }
                } catch (err) {
                    console.error("Status check failed:", err);
                }
            }
            setIsLoading(false);
        };
        checkCreatorStatus();
    }, [isAuthenticated, user]);

    useEffect(() => {
        const handleClickOutside = (event) => {
            if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
                setDropdownOpen(false);
            }
        };
        document.addEventListener("mousedown", handleClickOutside);
        return () => document.removeEventListener("mousedown", handleClickOutside);
    }, []);

    return (
        <nav className="sticky top-0 z-50 bg-[var(--ink-panel)] border-b-2 border-[var(--stamp)] shadow-md">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="flex justify-between items-center h-16">

                    {/* Left: Brand Logo */}
                    <div className="flex-shrink-0">
                        <Link to="/" className="flex items-center gap-2.5 group" onClick={() => setMenuOpen(false)}>
                            <div className="w-9 h-9 rounded-md bg-[var(--stamp-bg)] border-2 border-[var(--stamp)] overflow-hidden flex items-center justify-center group-hover:-rotate-3 transition-transform duration-200">
                                <img src="/logo.png" alt="ReadXHub Logo" className="w-full h-full object-cover" />
                            </div>
                            <span className="text-xl tracking-tight text-[#F6F3EA]" style={{ fontFamily: "'Fraunces', serif", fontWeight: 700 }}>
                                ReadX<span className="text-[var(--stamp)]">Hub</span>
                            </span>
                        </Link>
                    </div>

                    {/* Center: Search & Navigation links */}
                    <div className="hidden md:flex items-center space-x-6 flex-1 justify-center max-w-2xl mx-8">
                        <form onSubmit={handleSearchSubmit} className="relative w-full max-w-xs group">
                            <FaSearch className="absolute left-3 top-1/2 -translate-y-1/2 text-[#8A8570] group-focus-within:text-[var(--stamp)] transition-colors text-xs" />
                            <input 
                                type="text"
                                placeholder="Search the archive..."
                                value={navSearch}
                                onChange={(e) => setNavSearch(e.target.value)}
                                className="w-full bg-[var(--ink-panel-raised)] border border-[#3A3728] rounded-md pl-9 pr-4 py-1.5 text-xs text-[#F6F3EA] placeholder:text-[#8A8570] focus:border-[var(--stamp)] focus:outline-none transition-colors"
                            />
                        </form>

                        <div className="flex items-center space-x-1">
                            <Link
                                to="/"
                                className={`flex items-center gap-1.5 px-3.5 py-2 rounded-md text-sm font-medium transition-all duration-150 ${
                                    location.pathname === "/"
                                    ? "bg-[var(--stamp-bg)] text-[var(--ink)] border border-[var(--stamp)]"
                                    : "text-[#C9C4AE] hover:text-[var(--ink)] hover:bg-white/5"
                                }`}
                            >
                                <FaHome className="text-xs" /> Home
                            </Link>

                            {effectiveAuthenticated && !isLoading && (
                                <Link 
                                    to={isCreator ? "/dashboard" : "/beacreator"} 
                                    className={`flex items-center gap-1.5 px-3.5 py-2 rounded-md text-sm font-medium transition-all duration-150 ${
                                        location.pathname === (isCreator ? "/dashboard" : "/beacreator")
                                        ? "bg-[var(--stamp-bg)] text-[var(--ink)] border border-[var(--stamp)]"
                                        : "text-[#C9C4AE] hover:text-[var(--ink)] hover:bg-white/5"
                                    }`}
                                >
                                    {isCreator ? <FaTachometerAlt className="text-xs" /> : <FaPlusSquare className="text-xs" />} 
                                    {isCreator ? "Dashboard" : "Be a Creator"}
                                </Link>
                            )}

                            {effectiveAuthenticated && !isLoading && (
                                <Link 
                                    to="/subscriptions" 
                                    className={`flex items-center gap-1.5 px-3.5 py-2 rounded-md text-sm font-medium transition-all duration-150 ${
                                        location.pathname === "/subscriptions"
                                        ? "bg-[var(--stamp-bg)] text-[var(--ink)] border border-[var(--stamp)]"
                                        : "text-[#C9C4AE] hover:text-[var(--ink)] hover:bg-white/5"
                                    }`}
                                >
                                    <FaUsers className="text-xs" /> Subscriptions
                                </Link>
                            )}
                        </div>
                    </div>

                    {/* Right: Auth Operations & User Dropdown */}
                    <div className="hidden md:flex items-center space-x-4">
                        {isLoading ? (
                            <div className="flex items-center text-xs text-[#8A8570] bg-[var(--ink-panel-raised)] border border-[#3A3728] px-3 py-1.5 rounded-md font-medium">
                                <FaSpinner className="animate-spin mr-1.5 text-[var(--stamp)]" /> Verifying...
                            </div>
                        ) : isAuthenticated ? (
                            <div className="flex items-center space-x-4">
                                <button className="relative p-2 text-[#C9C4AE] hover:text-[var(--ink)] transition-colors bg-[var(--ink-panel-raised)] border border-[#3A3728] rounded-md">
                                    <FaBell className="text-sm" />
                                    <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-[var(--stamp)] rounded-full ring-2 ring-[var(--ink-panel)] animate-pulse"></span>
                                </button>

                                <div className="relative" ref={dropdownRef}>
                                    <button 
                                        onClick={() => setDropdownOpen(!dropdownOpen)}
                                        className="flex items-center gap-2 p-1.5 rounded-md bg-[var(--ink-panel-raised)] border border-[#3A3728] hover:border-[var(--stamp)]/60 transition-all text-[#C9C4AE] hover:text-[var(--ink)]"
                                    >
                                        <img 
                                            src={resolveProfilePicture(localStorage.getItem("readxhub_user_picture") || user.picture)} 
                                            alt={user.name} 
                                            referrerPolicy="no-referrer"
                                            className="w-7 h-7 rounded object-cover border border-[#3A3728]"
                                        />
                                        <FaChevronDown className={`text-2xs transition-transform duration-200 ${dropdownOpen ? 'rotate-180' : ''}`} />
                                    </button>

                                    <AnimatePresence>
                                        {dropdownOpen && (
                                            <motion.div 
                                                initial={{ opacity: 0, y: 10 }}
                                                animate={{ opacity: 1, y: 0 }}
                                                exit={{ opacity: 0, y: 10 }}
                                                transition={{ duration: 0.15 }}
                                                className="absolute right-0 mt-2 w-56 bg-[var(--paper-raised)] border border-[var(--rule)] rounded-md p-2 shadow-2xl z-50 text-left"
                                            >
                                                <div className="px-3 py-2 border-b border-[var(--rule)] mb-1.5">
                                                    <p className="text-xs font-semibold text-[var(--ink)] truncate">{user.name}</p>
                                                    <p className="text-2xs text-[var(--ink-soft)] truncate">{user.email}</p>
                                                </div>
                                                <Link 
                                                    to="/profile" 
                                                    onClick={() => setDropdownOpen(false)}
                                                    className="flex items-center gap-2 w-full px-3 py-2 rounded-md text-xs text-[var(--ink-soft)] hover:text-[var(--ink)] hover:bg-[var(--stamp-bg)] transition-colors"
                                                >
                                                    <FaUser className="text-[var(--ink-soft)]" /> View Profile
                                                </Link>
                                                <Link 
                                                    to="/subscriptions" 
                                                    onClick={() => setDropdownOpen(false)}
                                                    className="flex items-center gap-2 w-full px-3 py-2 rounded-md text-xs text-[var(--ink-soft)] hover:text-[var(--ink)] hover:bg-[var(--stamp-bg)] transition-colors"
                                                >
                                                    <FaUsers className="text-[var(--ink-soft)]" /> Subscriptions
                                                </Link>
                                                <button 
                                                    onClick={handleLogout}
                                                    className="flex items-center gap-2 w-full px-3 py-2 rounded-md text-xs text-[var(--vote-down)] hover:bg-[var(--vote-down)]/10 transition-colors mt-1"
                                                >
                                                    <FaSignOutAlt /> Logout
                                                </button>
                                            </motion.div>
                                        )}
                                    </AnimatePresence>
                                </div>
                            </div>
                        ) : (
                            <button 
                                className="px-4 py-2 rounded-md bg-[var(--stamp)] hover:bg-[#B47A22] text-[var(--ink-panel)] font-bold text-xs shadow-md active:scale-[0.98] transition-all flex items-center gap-1.5 cursor-pointer"
                                onClick={() => loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } })}
                            >
                                <FaSignInAlt /> Login / Signup
                            </button>
                        )}
                    </div>

                    {/* Mobile Hamburger menu toggle button */}
                    <div className="md:hidden flex items-center">
                        <button 
                            onClick={toggleMenu}
                            className="p-2 rounded-md text-[#C9C4AE] hover:text-[var(--ink)] bg-[var(--ink-panel-raised)] border border-[#3A3728]"
                            aria-label="Toggle menu"
                        >
                            {menuOpen ? <FaTimes size={18} /> : <FaBars size={18} />}
                        </button>
                    </div>
                </div>
            </div>

            {/* Mobile Menu Panel */}
            <AnimatePresence>
                {menuOpen && (
                    <motion.div 
                        initial={{ opacity: 0, height: 0 }}
                        animate={{ opacity: 1, height: "auto" }}
                        exit={{ opacity: 0, height: 0 }}
                        transition={{ duration: 0.25 }}
                        className="md:hidden overflow-hidden bg-[var(--ink-panel)] border-b border-[#3A3728]"
                    >
                        <div className="px-4 pt-2 pb-6 space-y-3">
                            <Link 
                                to="/" 
                                className={`flex items-center gap-2 px-4 py-3 rounded-md text-sm font-medium transition-colors ${
                                    location.pathname === "/" ? "bg-[var(--stamp-bg)] text-[var(--ink)] border border-[var(--stamp)]" : "text-[#C9C4AE]"
                                }`}
                                onClick={() => setMenuOpen(false)}
                            >
                                <FaHome /> Home
                            </Link>

                            {isLoading ? (
                                <div className="flex items-center px-4 py-3 text-sm text-[#8A8570] font-medium">
                                    <FaSpinner className="animate-spin mr-2 text-[var(--stamp)]" /> Verifying creator...
                                </div>
                            ) : (
                                <>
                                    {isAuthenticated ? (
                                        <>
                                            <Link 
                                                to={isCreator ? "/dashboard" : "/beacreator"} 
                                                className={`flex items-center gap-2 px-4 py-3 rounded-md text-sm font-medium transition-colors ${
                                                    location.pathname === (isCreator ? "/dashboard" : "/beacreator") ? "bg-[var(--stamp-bg)] text-[var(--ink)] border border-[var(--stamp)]" : "text-[#C9C4AE]"
                                                }`}
                                                onClick={() => setMenuOpen(false)}
                                            >
                                                {isCreator ? <FaTachometerAlt /> : <FaPlusSquare />} 
                                                {isCreator ? "Dashboard" : "Be a Creator"}
                                            </Link>
                                            
                                            <Link 
                                                to="/subscriptions" 
                                                className={`flex items-center gap-2 px-4 py-3 rounded-md text-sm font-medium transition-colors ${
                                                    location.pathname === "/subscriptions" ? "bg-[var(--stamp-bg)] text-[var(--ink)] border border-[var(--stamp)]" : "text-[#C9C4AE]"
                                                }`}
                                                onClick={() => setMenuOpen(false)}
                                            >
                                                <FaUsers /> Subscriptions
                                            </Link>
                                            
                                            <Link 
                                                to="/profile" 
                                                className="flex items-center gap-2 px-4 py-3 rounded-md text-sm font-medium text-[#C9C4AE]"
                                                onClick={() => setMenuOpen(false)}
                                            >
                                                <FaUser /> Profile settings
                                            </Link>

                                            <button 
                                                className="w-full px-4 py-3 rounded-md bg-[var(--vote-down)]/10 border border-[var(--vote-down)]/30 text-[var(--vote-down)] text-sm font-bold transition-all flex items-center justify-center gap-2"
                                                onClick={() => {
                                                    setMenuOpen(false);
                                                    handleLogout();
                                                }}
                                            >
                                                <FaSignOutAlt /> Logout
                                            </button>
                                        </>
                                    ) : (
                                        <button 
                                            className="w-full px-4 py-3 rounded-md bg-[var(--stamp)] text-[var(--ink-panel)] font-bold text-sm shadow-md flex items-center justify-center gap-2"
                                            onClick={() => {
                                                setMenuOpen(false);
                                                loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } });
                                            }}
                                        >
                                            <FaSignInAlt /> Login / Signup
                                        </button>
                                    )}
                                </>
                            )}
                        </div>
                    </motion.div>
                )}
            </AnimatePresence>
        </nav>
    );
};

export default Navbar;
