import React, { useEffect, useState } from "react";
import { useAuth0 } from "@auth0/auth0-react";
import { motion } from "framer-motion";
import { 
  FaUserCircle, FaEnvelope, FaSignOutAlt, FaShieldAlt, FaKey, 
  FaEdit, FaCamera, FaCheck, FaSpinner, FaBookOpen, FaUser, FaLink, FaCode
} from "react-icons/fa";
import { Link } from "react-router-dom";
import IsLogged from "../IsLogged";
import Cookies from "js-cookie";
import { getApiUrl } from "../utils/api.js";
import DeveloperAPISection from "../components/DeveloperAPISection";
import { getOfflineAuthUser } from "../utils/auth.js";

const Profile = () => {
  const { user, isAuthenticated, loginWithRedirect, logout } = useAuth0();
  const offlineUser = getOfflineAuthUser();
  const effectiveUser = isAuthenticated && user?.email ? user : offlineUser;
  const effectiveAuthenticated = isAuthenticated || Boolean(offlineUser);
  const displayEmail = effectiveUser?.email || user?.email || "";
  
  const [creatorProfile, setCreatorProfile] = useState(null);
  const [isCreator, setIsCreator] = useState(false);
  const [fetchingCreator, setFetchingCreator] = useState(true);

  // Editor states
  const [editMode, setEditMode] = useState(false);
  const [editName, setEditName] = useState("");
  const [editBio, setEditBio] = useState("");
  const [editUsername, setEditUsername] = useState("");
  const [editGender, setEditGender] = useState("male");
  const [editShowEmail, setEditShowEmail] = useState(false);
  const [editPublicEmail, setEditPublicEmail] = useState("");
  const [selectedPhoto, setSelectedPhoto] = useState(null);
  const [photoPreview, setPhotoPreview] = useState("");
  const [statusMsg, setStatusMsg] = useState({ text: "", type: "" });
  const [saving, setSaving] = useState(false);
  const resolveProfilePicture = (path) => {
    if (!path) return "";
    if (path.startsWith("http") || path.startsWith("data:")) return path;
    return getApiUrl(path);
  };

  const fetchCreatorDetails = () => {
    if (effectiveAuthenticated && effectiveUser?.email) {
      setFetchingCreator(true);
      fetch(getApiUrl(`check_email.php?email=${encodeURIComponent(effectiveUser.email)}`), { credentials: "include" })
        .then(res => res.json())
        .then(data => {
          if (data.exists) {
            setIsCreator(true);
            setCreatorProfile(data);
            setEditName(data.name || "");
            setEditBio(data.bio || "");
            setEditUsername(data.username || "");
            setEditGender(data.gender || "male");
            setEditShowEmail(!!data.show_email);
            setEditPublicEmail(data.public_email || "");
            if (data.profile_picture) {
              localStorage.setItem("readxhub_user_picture", data.profile_picture);
            }
          } else {
            setIsCreator(false);
          }
        })
        .catch(err => {
          console.error("Error fetching creator profile:", err);
        })
        .finally(() => {
          setFetchingCreator(false);
        });
    } else {
      setFetchingCreator(false);
    }
  };

  useEffect(() => {
    fetchCreatorDetails();
    // eslint-disable-next-line
  }, [effectiveAuthenticated, effectiveUser?.email]);

  const handlePhotoChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      setSelectedPhoto(file);
      setPhotoPreview(URL.createObjectURL(file));
    }
  };

  const handleProfileSubmit = async (e) => {
    e.preventDefault();
    setSaving(true);
    setStatusMsg({ text: "", type: "" });

    if (!effectiveUser?.email) {
      setStatusMsg({ text: "Please log in again to update your profile.", type: "error" });
      setSaving(false);
      return;
    }

    const submitData = new FormData();
    submitData.append("name", editName);
    submitData.append("bio", editBio);
    submitData.append("email", effectiveUser.email);
    submitData.append("username", editUsername);
    submitData.append("gender", editGender);
    submitData.append("show_email", editShowEmail ? 1 : 0);
    submitData.append("public_email", editPublicEmail);
    if (selectedPhoto) {
      submitData.append("profile_picture", selectedPhoto);
    }

    try {
      const res = await fetch(getApiUrl("update_creator_profile.php"), {
        method: "POST",
        credentials: "include",
        body: submitData,
      });

      const data = await res.json();
      if (res.ok && !data.error) {
        setStatusMsg({ text: "Profile details updated successfully!", type: "success" });
        setEditMode(false);
        // Refresh local cache & page details
        if (data.profile_picture) {
          localStorage.setItem("readxhub_user_picture", data.profile_picture);
        }
        fetchCreatorDetails();
      } else {
        throw new Error(data.error || "Failed to update profile details.");
      }
    } catch (err) {
      console.error(err);
      setStatusMsg({ text: "Error: " + err.message, type: "error" });
    } finally {
      setSaving(false);
    }
  };

  const handleLogout = () => {
    Cookies.remove("auth_token");
    localStorage.removeItem("readxhub_user");
    localStorage.removeItem("readxhub_user_picture");
    logout({ returnTo: window.location.origin });
  };

  return (
    <>
      <IsLogged />
      <main className="min-h-screen bg-[var(--paper)] text-[var(--ink)] selection:bg-[var(--stamp)]/30 selection:text-[var(--link)] py-16 px-6">
        <div className="max-w-2xl mx-auto">
          
          <h1 className="text-2xl md:text-3xl font-extrabold text-[var(--ink)] mb-2 tracking-tight">
            Account Management
          </h1>
          <p className="text-xs md:text-sm text-[var(--ink-soft)] mb-8 leading-relaxed">
            Manage your personal settings, view Auth0 identity tokens, and verify your credentials.
          </p>

          <AnimatePresenceWrapper>
            {effectiveAuthenticated ? (
              <motion.div
                initial={{ opacity: 0, y: 12 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.35 }}
                className="bg-[var(--paper-raised)]/40 border border-[var(--rule)] rounded-2xl p-6 md:p-8 shadow-xl space-y-6"
              >
                {/* Status message */}
                {statusMsg.text && (
                  <div className={`p-4 rounded-xl border text-xs font-semibold ${
                    statusMsg.type === "success" ? "bg-green-900/10 border-green-700/30 text-green-400" : "bg-red-900/10 border-red-700/30 text-red-400"
                  }`}>
                    {statusMsg.text}
                  </div>
                )}

                {/* Header User Avatar Block */}
                <div className="flex flex-col sm:flex-row items-center gap-5 pb-6 border-b border-[var(--rule)]">
                  <img 
                    src={resolveProfilePicture(creatorProfile?.profile_picture || localStorage.getItem("readxhub_user_picture") || effectiveUser?.picture)} 
                    alt="Profile Avatar" 
                    referrerPolicy="no-referrer" 
                    className="w-20 h-20 rounded-2xl object-cover border border-[var(--rule-strong)]/80 shadow-md bg-[var(--paper-raised)]"
                  />
                  <div className="text-center sm:text-left space-y-1">
                    <h2 className="text-xl font-bold text-[var(--ink)] tracking-tight">
                      {isCreator && creatorProfile?.name ? creatorProfile.name : effectiveUser?.name || displayEmail || "User"}
                    </h2>
                    <p className="text-xs text-[var(--ink-soft)] flex items-center justify-center sm:justify-start gap-1">
                      <FaEnvelope className="text-[var(--stamp)]" /> {displayEmail}
                    </p>
                  </div>
                  <span className="sm:ml-auto px-3 py-1 rounded-full bg-[var(--stamp)]/10 border border-[var(--stamp)]/20 text-[var(--link)] text-3xs font-bold tracking-wider uppercase">
                    Active Identity
                  </span>
                </div>

                {/* CREATOR PROFILE EDITING SYSTEM */}
                {fetchingCreator ? (
                  <div className="text-center py-6">
                    <FaSpinner className="animate-spin text-[var(--link)] text-lg mx-auto" />
                    <p className="text-slate-550 text-2xs mt-2">Checking creator credentials...</p>
                  </div>
                ) : isCreator ? (
                  <div className="p-5 rounded-2xl bg-[var(--paper-raised)]/30 border border-[var(--rule)] space-y-4">
                    <div className="flex items-center justify-between">
                      <h3 className="text-xs font-bold uppercase tracking-wider text-[var(--ink-soft)] flex items-center gap-1.5">
                        <FaUser className="text-[var(--stamp)] text-2xs" /> Writer Profile Details
                      </h3>
                      {!editMode ? (
                        <button 
                          onClick={() => setEditMode(true)}
                          className="px-3 py-1.5 rounded-lg bg-[var(--paper-raised)] border border-[var(--rule)] text-[10px] font-bold text-[var(--link)] hover:text-[var(--ink)] transition-all cursor-pointer flex items-center gap-1"
                        >
                          <FaEdit /> Edit Profile
                        </button>
                      ) : (
                        <button 
                          onClick={() => { setEditMode(false); setPhotoPreview(""); }}
                          className="px-3 py-1.5 rounded-lg bg-[var(--paper-raised)] border border-[var(--rule)] text-[10px] font-bold text-red-400 hover:text-[var(--ink)] transition-all cursor-pointer"
                        >
                          Cancel
                        </button>
                      )}
                    </div>

                    {!editMode ? (
                      <div className="space-y-4 pt-2">
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                          <div className="space-y-1">
                            <span className="text-[10px] text-[var(--ink-soft)] font-bold uppercase">Name</span>
                            <p className="text-sm font-semibold text-[var(--ink)]">{creatorProfile.name}</p>
                          </div>
                          <div className="space-y-1">
                            <span className="text-[10px] text-[var(--ink-soft)] font-bold uppercase">Username</span>
                            <p className="text-sm font-semibold text-[var(--ink)]">@{creatorProfile.username || "Not Set"}</p>
                          </div>
                          <div className="space-y-1">
                            <span className="text-[10px] text-[var(--ink-soft)] font-bold uppercase">Gender</span>
                            <p className="text-sm font-semibold text-[var(--ink)] capitalize">{creatorProfile.gender || "Male"}</p>
                          </div>
                          <div className="space-y-1">
                            <span className="text-[10px] text-[var(--ink-soft)] font-bold uppercase">Public Email</span>
                            <p className="text-sm font-semibold text-[var(--ink)]">
                              {creatorProfile.show_email ? (creatorProfile.public_email || displayEmail) : "Hidden"}
                            </p>
                          </div>
                        </div>
                        <div className="space-y-1">
                          <span className="text-[10px] text-[var(--ink-soft)] font-bold uppercase">Professional Bio</span>
                          <p className="text-xs text-slate-350 leading-relaxed">{creatorProfile.bio}</p>
                        </div>
                        <div className="pt-2 flex items-center gap-4">
                          <Link 
                            to={`/author/${creatorProfile.username || displayEmail}`} 
                            className="inline-flex items-center gap-1.5 px-4 py-2 bg-[var(--stamp)]/10 border border-[var(--stamp)]/20 text-[var(--link)] hover:bg-[var(--stamp)] hover:text-slate-950 hover:border-transparent text-xs font-bold rounded-xl transition-all shadow-md"
                          >
                            <FaLink /> Inspect Public Profile
                          </Link>
                        </div>
                      </div>
                    ) : (
                      <form onSubmit={handleProfileSubmit} className="space-y-4 pt-2">
                        {/* Photo edit */}
                        <div className="flex flex-col items-center gap-3">
                          <div className="relative group w-16 h-16 rounded-xl border border-[var(--rule)] overflow-hidden bg-[var(--paper-raised)]">
                            <img 
                              src={photoPreview || resolveProfilePicture(creatorProfile.profile_picture) || effectiveUser?.picture} 
                              alt="Preview" 
                              className="w-full h-full object-cover"
                            />
                            <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 flex items-center justify-center transition-opacity pointer-events-none">
                              <FaCamera className="text-[var(--ink)] text-xs" />
                            </div>
                          </div>

                          <input 
                            type="file"
                            id="edit-profile-photo"
                            accept="image/*"
                            onChange={handlePhotoChange}
                            className="hidden"
                          />
                          <button
                            type="button"
                            onClick={() => document.getElementById("edit-profile-photo").click()}
                            className="px-2.5 py-1 rounded bg-[var(--paper-raised)] border border-[var(--rule)] text-[9px] font-bold text-[var(--ink-soft)] hover:text-[var(--ink)]"
                          >
                            Change Photo
                          </button>
                        </div>

                        {/* Name edit */}
                        <div className="space-y-1.5">
                          <label htmlFor="edit-name" className="block text-[10px] font-bold uppercase tracking-wider text-[var(--ink-soft)]">Full Name</label>
                          <input 
                            type="text"
                            id="edit-name"
                            value={editName}
                            onChange={(e) => setEditName(e.target.value)}
                            required
                            className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl px-4 py-2.5 text-xs text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none"
                          />
                        </div>

                        {/* Username edit */}
                        <div className="space-y-1.5">
                          <label htmlFor="edit-username" className="block text-[10px] font-bold uppercase tracking-wider text-[var(--ink-soft)]">Username</label>
                          <input 
                            type="text"
                            id="edit-username"
                            value={editUsername}
                            onChange={(e) => setEditUsername(e.target.value)}
                            required
                            pattern="^[a-zA-Z0-9._-]{3,30}$"
                            title="Username must be 3-30 chars and contain only letters, numbers, underscores, dots, or dashes."
                            className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl px-4 py-2.5 text-xs text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none"
                          />
                        </div>

                        {/* Gender edit */}
                        <div className="space-y-1.5">
                          <label htmlFor="edit-gender" className="block text-[10px] font-bold uppercase tracking-wider text-[var(--ink-soft)]">Gender</label>
                          <select 
                            id="edit-gender"
                            value={editGender}
                            onChange={(e) => setEditGender(e.target.value)}
                            required
                            className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl px-4 py-2.5 text-xs text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none"
                          >
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                            <option value="trans">Transgender / Other</option>
                          </select>
                        </div>

                        {/* Email Privacy Setting */}
                        <div className="space-y-3 p-4 rounded-xl bg-[var(--paper-raised)] border border-[var(--rule)]">
                          <label className="flex items-center gap-2 cursor-pointer text-xs font-bold text-slate-350">
                            <input 
                              type="checkbox"
                              checked={editShowEmail}
                              onChange={(e) => setEditShowEmail(e.target.checked)}
                              className="rounded border-[var(--rule)] bg-[var(--paper-raised)] text-[var(--link)] focus:ring-[var(--stamp)]/20"
                            />
                            Show my email address publicly
                          </label>
                          
                          {editShowEmail && (
                            <div className="space-y-1.5 pt-1">
                              <label htmlFor="edit-public-email" className="block text-[10px] font-bold uppercase tracking-wider text-[var(--ink-soft)]">Public Contact Email (Optional)</label>
                              <input 
                                type="email"
                                id="edit-public-email"
                                value={editPublicEmail}
                                onChange={(e) => setEditPublicEmail(e.target.value)}
                                placeholder={displayEmail}
                                className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-lg px-3 py-2 text-xs text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none"
                              />
                            </div>
                          )}
                        </div>

                        {/* Bio edit */}
                        <div className="space-y-1.5">
                          <label htmlFor="edit-bio" className="block text-[10px] font-bold uppercase tracking-wider text-[var(--ink-soft)]">Bio</label>
                          <textarea 
                            id="edit-bio"
                            value={editBio}
                            onChange={(e) => setEditBio(e.target.value)}
                            required
                            rows="4"
                            className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl p-4 text-xs text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none"
                          />
                        </div>

                        <button 
                          type="submit"
                          disabled={saving}
                          className="w-full py-2.5 rounded-xl bg-[var(--stamp)] hover:bg-[var(--stamp)] text-slate-950 text-xs font-bold transition-all shadow-md flex items-center justify-center gap-1.5"
                        >
                          {saving ? (
                            <>
                              <FaSpinner className="animate-spin" /> Saving Changes...
                            </>
                          ) : (
                            <>
                              <FaCheck /> Save Profile Settings
                            </>
                          )}
                        </button>
                      </form>
                    )}
                  </div>
                ) : (
                  <div className="p-5 rounded-2xl bg-[var(--stamp)]/5 border border-[var(--stamp)]/10 text-center space-y-3">
                    <p className="text-xs text-slate-350 leading-relaxed">
                      You are not registered as a creator. Apply now to write guides, logs, and technical reports on ReadXHub.
                    </p>
                    <Link 
                      to="/beacreator" 
                      className="inline-flex items-center gap-1 px-4 py-2 bg-[var(--stamp)] text-slate-950 font-bold text-xs rounded-xl shadow-md transition-all hover:bg-[var(--stamp)]"
                    >
                      Apply to be a Creator
                    </Link>
                  </div>
                )}

                {/* DEVELOPER API SECTION */}
                {isCreator && (
                  <DeveloperAPISection userEmail={displayEmail} isCreator={isCreator} />
                )}

                {/* Grid details block */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="p-4 rounded-xl bg-slate-955 border border-[var(--rule)]">
                    <span className="text-[10px] uppercase tracking-wider font-bold text-[var(--ink-soft)] flex items-center gap-1.5 mb-1">
                      <FaShieldAlt className="text-[var(--stamp)]" /> Identity Provider
                    </span>
                    <span className="text-xs font-semibold text-slate-350">{(effectiveUser?.sub || user?.sub)?.split("|")[0]?.toUpperCase() || "AUTH0"}</span>
                  </div>

                  <div className="p-4 rounded-xl bg-slate-955 border border-[var(--rule)]">
                    <span className="text-[10px] uppercase tracking-wider font-bold text-[var(--ink-soft)] flex items-center gap-1.5 mb-1">
                      <FaKey className="text-[var(--stamp)]" /> User Reference ID
                    </span>
                    <span className="text-xs font-semibold text-slate-350 truncate block">{effectiveUser?.sub || user?.sub || "Unspecified"}</span>
                  </div>
                </div>

                {/* Operations button */}
                <div className="pt-4 flex justify-end">
                  <button 
                    className="px-5 py-2.5 rounded-xl bg-red-500/10 border border-red-500/20 hover:bg-red-500 hover:text-slate-950 hover:border-transparent text-red-400 text-xs font-bold transition-all flex items-center gap-1.5 cursor-pointer shadow-md active:scale-98" 
                    onClick={handleLogout}
                  >
                    <FaSignOutAlt /> Log out from session
                  </button>
                </div>
              </motion.div>
            ) : (
              <motion.div
                initial={{ opacity: 0, y: 12 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.35 }}
                className="bg-[var(--paper-raised)]/40 border border-[var(--rule)] rounded-2xl p-8 text-center shadow-xl space-y-6"
              >
                <FaUserCircle className="text-5xl text-[var(--rule-strong)] mx-auto" />
                <div className="space-y-2">
                  <h2 className="text-lg font-bold text-[var(--ink)]">Verification Required</h2>
                  <p className="text-[var(--ink-soft)] text-xs max-w-sm mx-auto leading-relaxed">
                    You must sign in with your Auth0 credentials to access your ReadXHub settings and dashboards.
                  </p>
                </div>
                
                <button 
                  className="px-6 py-3 rounded-xl bg-gradient-to-r from-[var(--stamp)] to-[#B47A22] hover:from-[#B47A22] hover:to-[#9A6A1C] text-slate-950 font-bold text-xs shadow-md transition-all active:scale-98 cursor-pointer" 
                  onClick={() => loginWithRedirect({ appState: { returnTo: window.location.pathname + window.location.search } })}
                >
                  Verify credentials
                </button>
              </motion.div>
            )}
          </AnimatePresenceWrapper>

        </div>
      </main>
    </>
  );
};

const AnimatePresenceWrapper = ({ children }) => {
  return <div className="relative">{children}</div>;
};

export default Profile;
