import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth0 } from "@auth0/auth0-react";
import { FaUserPlus, FaUserCircle, FaEnvelope, FaPhone, FaCalendarAlt, FaCamera, FaInfoCircle, FaSpinner } from "react-icons/fa";
import Logged from "../IsLogged";
import { getApiUrl } from "../utils/api.js";

const COUNTRIES = [
    { code: "+91", label: "India", flag: "🇮🇳" },
    { code: "+1", label: "USA/Canada", flag: "🇺🇸" },
    { code: "+44", label: "United Kingdom", flag: "🇬🇧" },
    { code: "+61", label: "Australia", flag: "🇦🇺" },
    { code: "+49", label: "Germany", flag: "🇩🇪" },
    { code: "+33", label: "France", flag: "🇫🇷" },
    { code: "+65", label: "Singapore", flag: "🇸🇬" },
    { code: "+971", label: "UAE", flag: "🇦🇪" },
    { code: "+966", label: "Saudi Arabia", flag: "🇸🇦" },
    { code: "+880", label: "Bangladesh", flag: "🇧🇩" },
    { code: "+977", label: "Nepal", flag: "🇳🇵" },
    { code: "+94", label: "Sri Lanka", flag: "🇱🇰" },
    { code: "+92", label: "Pakistan", flag: "🇵🇰" },
    { code: "+60", label: "Malaysia", flag: "🇲🇾" },
    { code: "+81", label: "Japan", flag: "🇯🇵" },
    { code: "+82", label: "South Korea", flag: "🇰🇷" },
    { code: "+64", label: "New Zealand", flag: "🇳🇿" },
    { code: "+27", label: "South Africa", flag: "🇿🇦" },
    { code: "+55", label: "Brazil", flag: "🇧🇷" },
    { code: "+234", label: "Nigeria", flag: "🇳🇬" }
];

const BlogCreatorForm = () => {
    const { user, isAuthenticated } = useAuth0();
    const navigate = useNavigate();

    const [formData, setFormData] = useState({
        name: "",
        phone: "",
        date_of_birth: "",
        profile_picture: null,
        bio: "",
        email: "",
        username: "",
        gender: "male",
    });
    const [countryCode, setCountryCode] = useState("+91");
    const [phoneNumber, setPhoneNumber] = useState("");
    const [submissionStatus, setSubmissionStatus] = useState({ 
        message: '', 
        type: '', // success, error, info 
    });
    const [isCheckingRegistration, setIsCheckingRegistration] = useState(true);

    // 1. Handle browser unload warning
    useEffect(() => {
        const handleBeforeUnload = (e) => {
            if (formData.name || formData.bio) {
                e.preventDefault();
                e.returnValue = "You have unsaved changes. Are you sure you want to leave?";
            }
        };

        window.addEventListener("beforeunload", handleBeforeUnload);
        return () => {
            window.removeEventListener("beforeunload", handleBeforeUnload);
        };
    }, [formData]);

    // 2. Check registration status and pre-fill email
    useEffect(() => {
        if (isAuthenticated && user?.email) {
            setFormData((prev) => ({ ...prev, email: user.email }));
            setIsCheckingRegistration(true);

            fetch(getApiUrl(`check_email.php?email=${encodeURIComponent(user.email)}`), { credentials: "include" })
                .then((res) => res.json())
                .then((data) => {
                    if (data.exists) {
                        setSubmissionStatus({
                            message: "You are already registered as a blog creator. Redirecting to dashboard...",
                            type: 'info',
                        });
                        setTimeout(() => navigate("/dashboard"), 3000);
                    }
                })
                .catch((err) => {
                    console.error("Email check failed:", err);
                    setSubmissionStatus({
                        message: "Warning: Failed to verify registration status. Please proceed with caution.",
                        type: 'error',
                    });
                })
                .finally(() => {
                    setIsCheckingRegistration(false);
                });
        } else if (!isAuthenticated) {
            setIsCheckingRegistration(false); 
        }
    }, [isAuthenticated, user, navigate]);

    const handleChange = (e) => {
        const { name, value, files } = e.target;
        setFormData((prev) => ({
            ...prev,
            [name]: files ? files[0] : value,
        }));
    };

    const validateForm = () => {
        const { name, date_of_birth, profile_picture, bio, username } = formData;
        let errors = [];

        if (!name.trim() || !phoneNumber.trim() || !date_of_birth.trim() || !bio.trim() || !username.trim()) {
            errors.push("All fields except avatar are required.");
        } else {
            const namePattern = /^[a-zA-Z\s]{2,50}$/;
            if (!namePattern.test(name)) {
                errors.push("Name must contain only letters and be between 2-50 characters.");
            }

            const usernamePattern = /^[a-zA-Z0-9._-]{3,30}$/;
            if (!usernamePattern.test(username)) {
                errors.push("Username must be between 3-30 characters and contain only letters, numbers, underscores, dots, or dashes.");
            }
    
            if (countryCode === "+91") {
                const phonePattern = /^[6-9]\d{9}$/;
                if (!phonePattern.test(phoneNumber)) {
                    errors.push("Enter a valid 10-digit Indian phone number (starting 6-9).");
                }
            } else {
                if (phoneNumber.length < 7 || phoneNumber.length > 15) {
                    errors.push("Enter a valid phone number (7-15 digits).");
                }
            }
    
            const dob = new Date(date_of_birth);
            const today = new Date();
            const age = today.getFullYear() - dob.getFullYear();
            const monthDiff = today.getMonth() - dob.getMonth();
            const dayDiff = today.getDate() - dob.getDate();
            if (
                age < 13 ||
                (age === 13 && (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)))
            ) {
                errors.push("You must be at least 13 years old to register.");
            }
    
            if (bio.length < 30) {
                errors.push(`Your bio must be at least 30 characters long (Current: ${bio.length}).`);
            }
    
            if (profile_picture) {
                const validTypes = ["image/jpeg", "image/png", "image/jpg", "image/webp"];
                if (!validTypes.includes(profile_picture.type)) {
                    errors.push("Profile picture: Only JPG, PNG, or WEBP images are allowed.");
                } else if (profile_picture.size > 2 * 1024 * 1024) {
                    errors.push("Profile picture must be under 2MB.");
                }
            }
        }

        if (errors.length > 0) {
            setSubmissionStatus({ message: errors.join(" | "), type: 'error' });
            return false;
        }
        setSubmissionStatus({ message: '', type: '' });
        return true;
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setSubmissionStatus({ message: "Submitting application details...", type: 'info' });

        if (!validateForm()) return;
        if (isCheckingRegistration) {
             setSubmissionStatus({ message: "Please wait while we verify your account status.", type: 'info' });
             return;
        }

        const submitData = new FormData();
        submitData.append("name", formData.name);
        submitData.append("phone", countryCode + phoneNumber);
        submitData.append("date_of_birth", formData.date_of_birth);
        submitData.append("bio", formData.bio);
        submitData.append("email", formData.email);
        submitData.append("username", formData.username);
        submitData.append("gender", formData.gender);
        if (formData.profile_picture) {
            submitData.append("profile_picture", formData.profile_picture);
        }

        try {
            const res = await fetch(getApiUrl("creator_Set.php"), {
                method: "POST",
                credentials: "include",
                body: submitData,
            });
            const text = await res.text();
            
            if (res.ok && !text.toLowerCase().includes("error")) {
                setSubmissionStatus({ message: "Success! Your application has been submitted and is under review.", type: 'success' });
                setTimeout(() => navigate("/dashboard"), 3000); 
            } else {
                throw new Error(text || "Unknown error occurred during submission.");
            }
        } catch (err) {
            console.error("Submission failed:", err);
            setSubmissionStatus({ message: "Submission failed: " + err.message, type: 'error' });
        }
    };

    const getStatusClass = () => {
        switch (submissionStatus.type) {
            case 'error': return "bg-red-900/10 border-red-700/30 text-red-400";
            case 'success': return "bg-green-900/10 border-green-700/30 text-green-400";
            case 'info': return "bg-cyan-900/10 border-cyan-700/30 text-[var(--link)]";
            default: return "hidden";
        }
    };

    if (isCheckingRegistration) {
        return (
            <div className="min-h-screen flex items-center justify-center bg-[var(--paper)]">
                <FaSpinner className="animate-spin text-[var(--link)] text-3xl" />
            </div>
        );
    }
    
    if (!isAuthenticated) {
        return (
            <div className="min-h-screen flex items-center justify-center bg-[var(--paper)] p-6 text-center">
                <div className="bg-[var(--paper-raised)]/40 border border-[var(--rule)] rounded-2xl p-8 max-w-md w-full shadow-2xl">
                    <h2 className="text-xl font-bold text-[var(--ink)] mb-2">Access Restriced</h2>
                    <p className="text-[var(--ink-soft)] text-xs leading-relaxed mb-6">
                        You must sign in with your Auth0 technical credentials to register as a blog creator.
                    </p>
                    <button 
                        onClick={() => navigate("/")}
                        className="px-6 py-2.5 rounded-xl bg-[var(--stamp)] hover:bg-[var(--stamp)] text-slate-950 text-xs font-bold transition-all shadow-md cursor-pointer"
                    >
                        Back to Home
                    </button>
                </div>
            </div>
        );
    }

    return (
        <div className="min-h-screen bg-[var(--paper)] text-[var(--ink)] selection:bg-[var(--stamp)]/30 selection:text-[var(--link)] py-12 px-6">
            <Logged /> 
            
            <div className="max-w-xl mx-auto">
                <form 
                    className="bg-[var(--paper-raised)]/40 border border-[var(--rule)] rounded-2xl p-6 md:p-8 shadow-xl space-y-6" 
                    encType="multipart/form-data" 
                    onSubmit={handleSubmit}
                    aria-label="Blog Creator Registration Form"
                >
                    {/* Header */}
                    <header className="text-center pb-4 border-b border-[var(--rule)]">
                        <FaUserPlus className="text-[var(--stamp)] w-10 h-10 mx-auto mb-3" aria-hidden="true" />
                        <h2 className="text-xl md:text-2xl font-extrabold text-[var(--ink)] tracking-tight">Become a Blog Creator</h2>
                        <p className="text-xs text-[var(--ink-soft)] mt-1 leading-relaxed">Join our writing cohort and distribute technical publications on ReadXHub.</p>
                    </header>

                    {/* Notification Banner */}
                    {submissionStatus.message && (
                        <div 
                            className={`p-4 rounded-xl border text-xs font-semibold leading-relaxed ${getStatusClass()}`} 
                            role={submissionStatus.type === 'error' ? 'alert' : 'status'}
                        >
                            {submissionStatus.message}
                        </div>
                    )}

                    {/* Inputs */}
                    <fieldset className="space-y-4" aria-labelledby="creator-info-legend">
                        <legend id="creator-info-legend" className="sr-only">Writers Details</legend>

                        {/* Profile Picture Upload with Preview */}
                        <div className="flex flex-col items-center gap-4 py-2">
                            <label className="block text-xs font-bold uppercase tracking-wider text-[var(--ink-soft)] text-center">Profile Avatar</label>
                            
                            <div className="relative group w-20 h-20 rounded-full border-2 border-[var(--rule)] flex items-center justify-center overflow-hidden bg-[var(--paper-raised)]">
                                {formData.profile_picture ? (
                                    <img 
                                        src={URL.createObjectURL(formData.profile_picture)} 
                                        alt="Preview" 
                                        className="w-full h-full object-cover"
                                    />
                                ) : (
                                    <FaCamera className="text-[var(--ink-soft)]" />
                                )}
                            </div>

                            <input
                                type="file"
                                id="profile_picture"
                                name="profile_picture"
                                accept="image/jpeg, image/png, image/webp"
                                onChange={handleChange}
                                className="hidden"
                            />
                            
                            <button
                                type="button"
                                onClick={() => document.getElementById("profile_picture").click()}
                                className="px-3 py-1.5 rounded-lg bg-[var(--paper-raised)] border border-[var(--rule)] text-[10px] font-bold text-slate-350 hover:text-[var(--ink)] hover:border-slate-750 transition-all cursor-pointer"
                            >
                                Select Avatar Image
                            </button>
                        </div>

                        {/* Name */}
                        <div className="space-y-1.5">
                            <label htmlFor="name" className="block text-xs font-bold uppercase tracking-wider text-[var(--ink-soft)]">Full Name</label>
                            <div className="relative flex items-center">
                                <FaUserCircle className="absolute left-3.5 text-slate-65" aria-hidden="true" />
                                <input
                                    type="text"
                                    id="name"
                                    name="name"
                                    placeholder="e.g. Alan Turing"
                                    value={formData.name}
                                    onChange={handleChange}
                                    className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl pl-10 pr-4 py-2.5 text-xs md:text-sm text-[var(--ink)] placeholder-slate-600 focus:border-[var(--stamp)]/40 focus:outline-none"
                                    required
                                />
                            </div>
                        </div>

                        {/* Username */}
                        <div className="space-y-1.5">
                            <label htmlFor="username" className="block text-xs font-bold uppercase tracking-wider text-[var(--ink-soft)]">Username</label>
                            <div className="relative flex items-center">
                                <span className="absolute left-3.5 text-xs text-[var(--ink-soft)]">@</span>
                                <input
                                    type="text"
                                    id="username"
                                    name="username"
                                    placeholder="e.g. alanturing"
                                    value={formData.username}
                                    onChange={handleChange}
                                    className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl pl-8 pr-4 py-2.5 text-xs md:text-sm text-[var(--ink)] placeholder-slate-600 focus:border-[var(--stamp)]/40 focus:outline-none"
                                    required
                                />
                            </div>
                        </div>

                        {/* Gender */}
                        <div className="space-y-1.5">
                            <label htmlFor="gender" className="block text-xs font-bold uppercase tracking-wider text-[var(--ink-soft)]">Gender</label>
                            <div className="relative flex items-center">
                                <select
                                    id="gender"
                                    name="gender"
                                    value={formData.gender}
                                    onChange={handleChange}
                                    className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl px-4 py-2.5 text-xs md:text-sm text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none"
                                    required
                                >
                                    <option value="male">Male</option>
                                    <option value="female">Female</option>
                                    <option value="trans">Transgender / Other</option>
                                </select>
                            </div>
                        </div>

                        {/* Phone */}
                        <div className="space-y-1.5">
                            <label htmlFor="phone" className="block text-xs font-bold uppercase tracking-wider text-[var(--ink-soft)]">Contact Phone Number</label>
                            <div className="relative flex items-center bg-slate-955 border border-[var(--rule)] rounded-xl focus-within:border-[var(--stamp)]/40 transition-all pl-3">
                                <FaPhone className="text-slate-65" aria-hidden="true" />
                                
                                <div className="relative flex items-center ml-2 border-r border-[var(--rule)] pr-2">
                                    <select
                                        value={countryCode}
                                        onChange={(e) => setCountryCode(e.target.value)}
                                        className="bg-transparent text-xs md:text-sm text-[var(--ink-soft)] focus:outline-none cursor-pointer appearance-none pr-3"
                                        style={{ backgroundImage: `url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="gray"><path d="M7 10l5 5 5-5H7z"/></svg>')`, backgroundPosition: 'right center', backgroundRepeat: 'no-repeat', backgroundSize: '10px' }}
                                    >
                                        {COUNTRIES.map((c) => (
                                            <option key={c.code} value={c.code} className="bg-[var(--paper-raised)] text-[var(--ink)]">
                                                {c.flag} {c.code}
                                            </option>
                                        ))}
                                    </select>
                                </div>

                                <input
                                    type="tel"
                                    id="phone"
                                    name="phone"
                                    placeholder={countryCode === "+91" ? "e.g. 9876543210" : "e.g. 1234567"}
                                    value={phoneNumber}
                                    onChange={(e) => setPhoneNumber(e.target.value.replace(/\D/g, ""))}
                                    className="w-full bg-transparent pl-3 pr-4 py-2.5 text-xs md:text-sm text-[var(--ink)] placeholder-slate-600 focus:outline-none"
                                    required
                                />
                            </div>
                        </div>

                        {/* DOB */}
                        <div className="space-y-1.5">
                            <label htmlFor="date_of_birth" className="block text-xs font-bold uppercase tracking-wider text-[var(--ink-soft)]">Date of Birth (Must be 13+)</label>
                            <div className="relative flex items-center">
                                <FaCalendarAlt className="absolute left-3.5 text-slate-65" aria-hidden="true" />
                                <input
                                    type="date"
                                    id="date_of_birth"
                                    name="date_of_birth"
                                    value={formData.date_of_birth}
                                    onChange={handleChange}
                                    className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl pl-10 pr-4 py-2.5 text-xs md:text-sm text-[var(--ink)] placeholder-slate-600 focus:border-[var(--stamp)]/40 focus:outline-none appearance-none"
                                    required
                                />
                            </div>
                        </div>
                        
                        {/* Bio */}
                        <div className="space-y-1.5">
                            <label htmlFor="bio" className="block text-xs font-bold uppercase tracking-wider text-[var(--ink-soft)]">Professional Bio (Min 30 characters)</label>
                            <textarea
                                id="bio"
                                name="bio"
                                placeholder="Explain your core technological findings, research, or interests..."
                                value={formData.bio}
                                onChange={handleChange}
                                maxLength={2000}
                                className="w-full bg-slate-955 border border-[var(--rule)] rounded-xl p-4 text-xs md:text-sm text-[var(--ink)] placeholder-slate-600 focus:border-[var(--stamp)]/40 focus:outline-none"
                                rows="4"
                                required
                            />
                            <div className="text-right text-[10px] text-[var(--ink-soft)]">
                                {formData.bio.length} / 2000 characters
                            </div>
                        </div>

                        {/* Email */}
                        <div className="space-y-1.5">
                            <label htmlFor="email" className="block text-xs font-bold uppercase tracking-wider text-[var(--ink-soft)]">Email Address (Read-only)</label>
                            <div className="relative flex items-center">
                                <FaEnvelope className="absolute left-3.5 text-slate-70" aria-hidden="true" />
                                <input
                                    type="email"
                                    id="email"
                                    name="email"
                                    value={formData.email}
                                    readOnly
                                    disabled
                                    className="w-full bg-[var(--paper-raised)]/30 border border-[var(--rule)] rounded-xl pl-10 pr-4 py-2.5 text-xs md:text-sm text-[var(--ink-soft)] cursor-not-allowed"
                                />
                            </div>
                        </div>

                    </fieldset>

                    {/* Submit */}
                    <button 
                        type="submit" 
                        className="w-full py-4 rounded-xl bg-[var(--stamp)] hover:bg-[var(--stamp)] text-slate-950 font-bold text-sm shadow-md transition-all active:scale-[0.99] cursor-pointer"
                    >
                        Submit Application
                    </button>
                </form>
            </div>
        </div>
    );
};

export default BlogCreatorForm;