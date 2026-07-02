import { useEffect, useState, useRef } from "react";
import { useNavigate, Link } from "react-router-dom";
import { useAuth0 } from "@auth0/auth0-react";
import React from "react";
import { 
    FaFeatherAlt, FaEdit, FaInfoCircle, FaCheckCircle, FaExclamationTriangle,
    FaHeading, FaBold, FaItalic, FaCode, FaQuoteRight, FaListUl, FaListOl, 
    FaTerminal, FaBookOpen, FaTags, FaKeyboard, FaYoutube, FaEye, FaImage, FaSearch, FaShareAlt, FaCog
} from "react-icons/fa";
import Logged from "../IsLogged"; 
import { getApiUrl } from "../utils/api.js";
import FeaturedImageUploader from "../components/FeaturedImageUploader";

import { marked } from 'marked'; 
import DOMPurify from 'dompurify';

const StatusMessage = ({ message, type }) => {
    let className = "";
    let Icon = FaInfoCircle;

    switch (type) {
        case 'success':
            className = "bg-emerald-500/10 border-emerald-500/20 text-emerald-450 shadow-[0_0_15px_rgba(16,185,129,0.05)]";
            Icon = FaCheckCircle;
            break;
        case 'error':
            className = "bg-red-900/10 border-red-700/30 text-red-400";
            Icon = FaExclamationTriangle;
            break;
        case 'info':
        default:
            className = "bg-cyan-900/10 border-cyan-700/30 text-[var(--link)]";
            Icon = FaInfoCircle;
            break;
    }

    return (
        <div 
            className={`p-4 rounded-xl border text-xs md:text-sm font-semibold mb-6 flex items-start gap-3 ${className}`} 
        >
            <Icon className="flex-shrink-0 w-5 h-5 mt-0.5" aria-hidden="true" />
            <div dangerouslySetInnerHTML={{ __html: message }} />
        </div>
    );
};

const MarkdownPreview = React.memo(({ content }) => {
    const youtubeRegex = /\[youtube:([a-zA-Z0-9_-]{11})\]/g;
    const contentWithPlaceholderHtml = content.replace(youtubeRegex, (match, videoId) => {
        return `<div class="youtube-placeholder-container" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; margin: 16px 0; border-radius: 12px; background-color: #0f172a; border: 1px solid #1e293b;">
                    <img src="https://img.youtube.com/vi/${videoId}/hqdefault.jpg" alt="YouTube Video Thumbnail" style="width: 100%; height: 100%; object-fit: cover; opacity: 0.65;" />
                </div>`;
    });
    
    let cleanHtml = "";
    try {
        const rawHtml = marked.parse(contentWithPlaceholderHtml);
        cleanHtml = DOMPurify.sanitize(rawHtml, {
            ADD_TAGS: ["iframe", "div", "img", "svg", "path", "p", "br", "h1", "h2", "h3", "code", "pre", "ul", "ol", "li", "blockquote"], 
            ADD_ATTR: ['width', 'height', 'src', 'class', 'style', 'viewBox', 'fill', 'alt'], 
        });
    } catch {
        cleanHtml = "<p>Error parsing preview content.</p>";
    }

    return (
        <div 
            className="w-full h-[400px] p-4 border border-[var(--rule)] rounded-xl bg-[var(--paper-raised)]/20 overflow-y-auto text-sm text-[var(--ink-soft)] custom-markdown-styles"
            dangerouslySetInnerHTML={{ __html: cleanHtml || "<p class='text-[var(--ink-soft)] italic'>Nothing to preview yet...</p>" }}
        />
    );
});

// Live SEO Validator
const SEOValidator = ({ formData }) => {
    const checks = [
        { label: "Title length (50-60 chars)", passed: formData.seo_title ? (formData.seo_title.length >= 50 && formData.seo_title.length <= 60) : (formData.title.length >= 50 && formData.title.length <= 60) },
        { label: "Meta description length (150-160)", passed: formData.seo_description ? (formData.seo_description.length >= 150 && formData.seo_description.length <= 160) : (formData.description.length >= 150 && formData.description.length <= 160) },
        { label: "Featured Image provided", passed: !!formData.featured_image },
        { label: "Image Alt Text provided", passed: !!formData.image_alt },
        { label: "Content contains internal links", passed: /\]\(\/|https?:\/\/(blogs\.)?readxhub\.in/i.test(formData.content) },
        { label: "Content uses H2 headings", passed: formData.content.includes("## ") },
        { label: "Content length > 300 words", passed: formData.content.split(/\s+/).length > 300 }
    ];

    const score = Math.round((checks.filter(c => c.passed).length / checks.length) * 100);
    
    return (
        <div className="bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl p-4">
            <h4 className="text-sm font-bold text-[var(--ink)] mb-3 flex items-center justify-between">
                <span>SEO Score</span>
                <span className={`px-2 py-1 rounded text-xs ${score > 80 ? 'bg-green-500/20 text-green-400' : score > 50 ? 'bg-yellow-500/20 text-yellow-400' : 'bg-red-500/20 text-red-400'}`}>
                    {score}/100
                </span>
            </h4>
            <ul className="space-y-2 text-xs">
                {checks.map((check, i) => (
                    <li key={i} className="flex items-center gap-2">
                        {check.passed ? <FaCheckCircle className="text-green-500" /> : <FaExclamationTriangle className="text-yellow-500" />}
                        <span className={check.passed ? "text-emerald-400" : "text-amber-400"}>{check.label}</span>
                    </li>
                ))}
            </ul>
        </div>
    );
};

const CreatePost = () => {
    const navigate = useNavigate();
    const { user, isAuthenticated } = useAuth0();
    
    const [creatorName, setCreatorName] = useState("");
    const [submissionStatus, setSubmissionStatus] = useState({ message: "", type: "" });
    const [saveStatus, setSaveStatus] = useState(""); // "Saved", "Saving...", "Error"
    const editorRef = useRef(null); 
    
    const [activeTab, setActiveTab] = useState("content"); // content, media, seo

    const [formData, setFormData] = useState({
        title: "", description: "", keywords: "", author: "", content: "", email: "",
        status: "published", publish_date: new Date().toISOString().slice(0,16),
        featured_image: "", featured_image_thumb: "", featured_image_medium: "", featured_image_large: "",
        image_alt: "", image_caption: "", image_credit: "", mime_type: "",
        seo_title: "", seo_description: "", focus_keyword: "", canonical_url: "", robots_override: "",
        social_title: "", social_description: "", social_image: ""
    });

    useEffect(() => {
        if (!isAuthenticated) navigate("/");
    }, [isAuthenticated, navigate]);
    
    useEffect(() => {
        if (isAuthenticated && user?.email) {
            fetch(getApiUrl(`get_creator_name.php?email=${encodeURIComponent(user.email)}`), { credentials: "include" })
            .then(res => res.json())
            .then(data => {
                if (data.name) {
                    const name = data.name.trim();
                    const capitalized = name.charAt(0).toUpperCase() + name.slice(1);
                    setCreatorName(capitalized);
                    
                    // Check for saved draft
                    const savedDraft = localStorage.getItem('blog_draft');
                    if (savedDraft) {
                        try {
                            const parsedDraft = JSON.parse(savedDraft);
                            setFormData(prev => ({ ...prev, ...parsedDraft, author: capitalized, email: user.email }));
                        } catch (e) {
                            setFormData(prev => ({ ...prev, author: capitalized, email: user.email }));
                        }
                    } else {
                        setFormData(prev => ({ ...prev, author: capitalized, email: user.email }));
                    }
                } else {
                    navigate("/beacreator");
                }
            });
        }
    }, [isAuthenticated, user, navigate]);

    useEffect(() => {
        if (formData.title || formData.content) {
            setSaveStatus("Saving...");
            localStorage.setItem('blog_draft', JSON.stringify({
                title: formData.title,
                description: formData.description,
                content: formData.content,
                keywords: formData.keywords,
                seo_title: formData.seo_title,
                seo_description: formData.seo_description
            }));
            const timer = setTimeout(() => setSaveStatus("Saved locally"), 800);
            return () => clearTimeout(timer);
        }
    }, [formData.title, formData.description, formData.content, formData.keywords, formData.seo_title, formData.seo_description]);

    const handleInputChange = (e) => setFormData(prev => ({ ...prev, [e.target.name]: e.target.value }));

    const handleImageUpload = (data) => {
        if (data) {
            setFormData(prev => ({
                ...prev,
                featured_image: data.original,
                featured_image_large: data.large,
                featured_image_medium: data.medium,
                featured_image_thumb: data.thumb,
                mime_type: data.mime
            }));
        } else {
            setFormData(prev => ({
                ...prev,
                featured_image: "", featured_image_thumb: "", featured_image_medium: "", featured_image_large: "", mime_type: ""
            }));
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        window.scrollTo({ top: 0, behavior: "smooth" });
        setSubmissionStatus({ type: 'info', message: "Publishing post securely..." });

        if (!formData.featured_image) {
            setSubmissionStatus({ type: 'error', message: "Featured Image is required for publishing." });
            return;
        }
        if (!formData.image_alt) {
            setSubmissionStatus({ type: 'error', message: "Image Alt Text is required for SEO & Accessibility." });
            return;
        }

        const postData = new FormData();
        for (const key in formData) {
            const val = formData[key];
            if (val !== null && val !== undefined && val !== 'null' && val !== 'undefined') {
                postData.append(key, val);
            }
        }

        try {
            const res = await fetch(getApiUrl("insert_new_blog.php"), {
                method: "POST", credentials: "include", body: postData,
            });
            const result = await res.json();

            if (result.status === 'success') {
                localStorage.removeItem('blog_draft');
                setSubmissionStatus({
                    type: 'success',
                    message: `Successfully ${formData.status}! View live link: <a href="${result.url}" target="_blank" class="text-[var(--link)] underline">${result.url}</a>`,
                });
            } else {
                setSubmissionStatus({ type: 'error', message: result.message || "Failed to submit." });
            }
        } catch (error) {
            setSubmissionStatus({ type: 'error', message: "Network error occurred." });
        }
    };
    
    // Markdown functions - properly wrap selection
    const insertMarkdown = (prefix, suffix = prefix) => {
        const textarea = editorRef.current;
        if (!textarea) return;
        
        const start = textarea.selectionStart;
        const end = textarea.selectionEnd;
        const selectedText = textarea.value.substring(start, end);
        const newText = prefix + selectedText + suffix;
        
        const newContent = textarea.value.substring(0, start) + newText + textarea.value.substring(end);
        
        setFormData(prev => ({ ...prev, content: newContent }));
        
        // Focus and set cursor position after update
        setTimeout(() => {
            if (editorRef.current) {
                editorRef.current.focus();
                const newCursorPos = start + prefix.length + selectedText.length + suffix.length;
                editorRef.current.selectionStart = newCursorPos;
                editorRef.current.selectionEnd = newCursorPos;
            }
        }, 0);
    };

    const insertText = (text) => {
        // Fallback simple insert at cursor
        const textarea = editorRef.current;
        if (!textarea) return;
        const start = textarea.selectionStart;
        const end = textarea.selectionEnd;
        const newContent = textarea.value.substring(0, start) + text + textarea.value.substring(end);
        setFormData(prev => ({ ...prev, content: newContent }));
        setTimeout(() => {
            if (editorRef.current) {
                editorRef.current.focus();
                editorRef.current.selectionEnd = start + text.length;
            }
        }, 0);
    };

    return (
        <main className="min-h-screen bg-[var(--paper)] text-[var(--ink)] selection:bg-[var(--stamp)]/30 py-12 px-6">
            <Logged />
            <div className="max-w-5xl mx-auto space-y-10">
                <header className="pb-6 border-b border-[var(--rule)] flex items-center justify-between">
                    <h1 className="text-3xl font-extrabold text-[var(--ink)]">Create New Publication</h1>
                    {saveStatus && (
                        <div className={`text-xs px-3 py-1 rounded-full flex items-center gap-1.5 ${saveStatus.includes("Error") ? "bg-red-500/10 text-red-400" : saveStatus.includes("Saving") ? "bg-amber-500/10 text-amber-400" : "bg-emerald-500/10 text-emerald-400"}`}>
                            <span className="w-1.5 h-1.5 rounded-full bg-current animate-pulse" /> {saveStatus}
                        </div>
                    )}
                </header>

                {submissionStatus.message && <StatusMessage message={submissionStatus.message} type={submissionStatus.type} />}

                {/* Tabs */}
                <div className="flex border-b border-[var(--rule)]">
                    <button onClick={() => setActiveTab('content')} className={`px-4 py-2 font-bold text-sm ${activeTab === 'content' ? 'border-b-2 border-[var(--stamp)] text-[var(--link)]' : 'text-[var(--ink-soft)]'}`}><FaEdit className="inline mr-2"/> Content</button>
                    <button onClick={() => setActiveTab('media')} className={`px-4 py-2 font-bold text-sm ${activeTab === 'media' ? 'border-b-2 border-[var(--stamp)] text-[var(--link)]' : 'text-[var(--ink-soft)]'}`}><FaImage className="inline mr-2"/> Media</button>
                    <button onClick={() => setActiveTab('seo')} className={`px-4 py-2 font-bold text-sm ${activeTab === 'seo' ? 'border-b-2 border-[var(--stamp)] text-[var(--link)]' : 'text-[var(--ink-soft)]'}`}><FaSearch className="inline mr-2"/> SEO & Social</button>
                    <button onClick={() => setActiveTab('publish')} className={`px-4 py-2 font-bold text-sm ${activeTab === 'publish' ? 'border-b-2 border-[var(--stamp)] text-[var(--link)]' : 'text-[var(--ink-soft)]'}`}><FaCog className="inline mr-2"/> Publish</button>
                </div>

                <form onSubmit={handleSubmit} className="space-y-8">
                    
                    {/* CONTENT TAB */}
                    <div className={activeTab === 'content' ? 'block space-y-6' : 'hidden'}>
                        <input name="title" value={formData.title} onChange={handleInputChange} placeholder="Article Title" className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl p-3 text-[var(--ink)]" />
                        <textarea name="description" value={formData.description} onChange={handleInputChange} placeholder="Short Description..." className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-xl p-3 text-[var(--ink)]" rows="2" />
                        <div className="flex justify-between items-end">
                            <label className="text-sm font-bold text-[var(--ink-soft)]">Article Content</label>
                            <Link to="/markdown-tutorial" target="_blank" className="text-[var(--link)] text-xs hover:underline flex items-center gap-1.5 font-bold bg-[var(--stamp)]/10 px-2 py-1 rounded-md">
                                <FaInfoCircle /> Markdown Tutorial
                            </Link>
                        </div>
                        
                        {/* Markdown Toolbar - FIXED: Now functional with proper wrapping */}
                        <div className="flex flex-wrap gap-1 p-2 bg-[var(--paper-raised)] border border-[var(--rule)] rounded-t-xl">
                            <button type="button" onClick={() => insertMarkdown('**', '**')} className="p-2 hover:bg-[var(--stamp)]/10 rounded text-[var(--ink-soft)] hover:text-[var(--ink)] transition-colors" title="Bold"><FaBold /></button>
                            <button type="button" onClick={() => insertMarkdown('*', '*')} className="p-2 hover:bg-[var(--stamp)]/10 rounded text-[var(--ink-soft)] hover:text-[var(--ink)] transition-colors" title="Italic"><FaItalic /></button>
                            <button type="button" onClick={() => insertMarkdown('`', '`')} className="p-2 hover:bg-[var(--stamp)]/10 rounded text-[var(--ink-soft)] hover:text-[var(--ink)] transition-colors" title="Inline Code"><FaCode /></button>
                            <button type="button" onClick={() => insertMarkdown('> ', '')} className="p-2 hover:bg-[var(--stamp)]/10 rounded text-[var(--ink-soft)] hover:text-[var(--ink)] transition-colors" title="Quote"><FaQuoteRight /></button>
                            <button type="button" onClick={() => insertMarkdown('- ', '')} className="p-2 hover:bg-[var(--stamp)]/10 rounded text-[var(--ink-soft)] hover:text-[var(--ink)] transition-colors" title="Unordered List"><FaListUl /></button>
                            <button type="button" onClick={() => insertMarkdown('1. ', '')} className="p-2 hover:bg-[var(--stamp)]/10 rounded text-[var(--ink-soft)] hover:text-[var(--ink)] transition-colors" title="Ordered List"><FaListOl /></button>
                            <button type="button" onClick={() => insertMarkdown('## ', '')} className="p-2 hover:bg-[var(--stamp)]/10 rounded text-[var(--ink-soft)] hover:text-[var(--ink)] transition-colors" title="Heading 2"><FaHeading /></button>
                            <button type="button" onClick={() => insertMarkdown('```\n', '\n```')} className="p-2 hover:bg-[var(--stamp)]/10 rounded text-[var(--ink-soft)] hover:text-[var(--ink)] transition-colors" title="Code Block"><FaTerminal /></button>
                            <button type="button" onClick={() => insertMarkdown('[youtube:VIDEO_ID_HERE]', '')} className="p-2 hover:bg-[var(--stamp)]/10 rounded text-[var(--ink-soft)] hover:text-[var(--ink)] transition-colors" title="YouTube Embed — replace VIDEO_ID_HERE with the actual 11-char YouTube ID"><FaYoutube /></button>
                            <div className="flex-1" />
                            <button type="button" onClick={() => insertText('')} className="px-3 py-1 text-xs bg-[var(--stamp)]/10 hover:bg-[var(--stamp)]/20 rounded text-[var(--ink-soft)]" title="Clear selection helper">Insert at cursor</button>
                        </div>
                        
                        <textarea ref={editorRef} name="content" value={formData.content} onChange={handleInputChange} placeholder="Markdown Content..." className="w-full h-[400px] bg-[var(--paper-raised)] border border-[var(--rule)] rounded-b-xl p-4 text-[var(--ink)] font-mono focus:outline-none focus:border-[var(--stamp)]/50" />
                    </div>

                    {/* MEDIA TAB */}
                    <div className={activeTab === 'media' ? 'block space-y-6' : 'hidden'}>
                        <FeaturedImageUploader onUploadSuccess={handleImageUpload} />
                        <div className="grid grid-cols-2 gap-4">
                            <input name="image_alt" value={formData.image_alt} onChange={handleInputChange} placeholder="Alt Text (Required)" className="bg-[var(--paper-raised)] border p-2 rounded text-[var(--ink)]" required={activeTab==='publish'} />
                            <input name="image_caption" value={formData.image_caption} onChange={handleInputChange} placeholder="Caption (Optional)" className="bg-[var(--paper-raised)] border p-2 rounded text-[var(--ink)]" />
                            <input name="image_credit" value={formData.image_credit} onChange={handleInputChange} placeholder="Image Credit (Optional)" className="col-span-2 bg-[var(--paper-raised)] border p-2 rounded text-[var(--ink)]" />
                        </div>
                    </div>

                    {/* SEO TAB */}
                    <div className={activeTab === 'seo' ? 'block grid grid-cols-1 md:grid-cols-3 gap-6' : 'hidden'}>
                        <div className="col-span-2 space-y-4">
                            <input name="seo_title" value={formData.seo_title} onChange={handleInputChange} placeholder="SEO Title Override" className="w-full bg-[var(--paper-raised)] border p-2 rounded text-[var(--ink)]" />
                            <textarea name="seo_description" value={formData.seo_description} onChange={handleInputChange} placeholder="SEO Description Override" className="w-full bg-[var(--paper-raised)] border p-2 rounded text-[var(--ink)]" rows="2" />
                            <input name="canonical_url" value={formData.canonical_url} onChange={handleInputChange} placeholder="Canonical URL (Optional)" className="w-full bg-[var(--paper-raised)] border p-2 rounded text-[var(--ink)]" />
                        </div>
                        <div>
                            <SEOValidator formData={formData} />
                        </div>
                    </div>

                    {/* PUBLISH TAB */}
                    <div className={activeTab === 'publish' ? 'block space-y-6' : 'hidden'}>
                        <div className="grid grid-cols-2 gap-6 bg-[var(--paper-raised)] p-6 rounded-xl border border-[var(--rule)]">
                            <div>
                                <label className="block text-sm text-[var(--ink-soft)] mb-2">Post Status</label>
                                <select name="status" value={formData.status} onChange={handleInputChange} className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] p-2 rounded text-[var(--ink)]">
                                    <option value="draft">Draft</option>
                                    <option value="scheduled">Scheduled</option>
                                    <option value="published">Published</option>
                                </select>
                            </div>
                            <div>
                                <label className="block text-sm text-[var(--ink-soft)] mb-2">Publish Date</label>
                                <input type="datetime-local" name="publish_date" value={formData.publish_date} onChange={handleInputChange} className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] p-2 rounded text-[var(--ink)]" />
                            </div>
                        </div>

                        <button type="submit" className="w-full py-4 bg-[var(--stamp)] hover:bg-[var(--stamp)] text-slate-900 font-bold rounded-xl" disabled={!formData.title || !formData.content}>
                            Submit Article
                        </button>
                    </div>

                </form>
            </div>
        </main>
    );
};
export default CreatePost;
