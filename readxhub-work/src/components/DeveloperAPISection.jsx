import React, { useEffect, useState } from "react";
import { motion } from "framer-motion";
import { 
  FaKey, FaPlus, FaTrash, FaSync, FaEye, FaEyeSlash, 
  FaCopy, FaCheck, FaSpinner, FaCode, FaLock, FaLink 
} from "react-icons/fa";
import { getApiUrl } from "../utils/api.js";

const DeveloperAPISection = ({ userEmail, isCreator }) => {
  const [apiKeys, setApiKeys] = useState([]);
  const [loading, setLoading] = useState(false);
  const [showCreateModal, setShowCreateModal] = useState(false);
  const [description, setDescription] = useState("");
  const [creatingKey, setCreatingKey] = useState(false);
  const [newKey, setNewKey] = useState(null);
  const [copiedKeyId, setCopiedKeyId] = useState(null);
  const [statusMsg, setStatusMsg] = useState({ text: "", type: "" });
  const [visibleKeys, setVisibleKeys] = useState({});

  useEffect(() => {
    if (isCreator) {
      fetchApiKeys();
    }
  }, [isCreator, userEmail]);

  const fetchApiKeys = async () => {
    if (!isCreator) return;
    
    setLoading(true);
    try {
      const response = await fetch(
        getApiUrl(`api_keys_manage.php?action=list&email=${encodeURIComponent(userEmail)}`),
        { credentials: "include" }
      );
      const data = await response.json();
      
      if (data.success) {
        setApiKeys(data.keys || []);
      } else {
        setStatusMsg({ text: data.error || "Failed to load API keys", type: "error" });
      }
    } catch (err) {
      console.error("Error loading API keys:", err);
      setStatusMsg({ text: "Failed to load API keys", type: "error" });
    } finally {
      setLoading(false);
    }
  };

  const handleCreateKey = async (e) => {
    e.preventDefault();
    setCreatingKey(true);
    setStatusMsg({ text: "", type: "" });

    try {
      const response = await fetch(
        getApiUrl("api_keys_manage.php?action=create"),
        {
          method: "POST",
          credentials: "include",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            email: userEmail,
            description: description || "My API Key"
          })
        }
      );

      const data = await response.json();
      
      if (data.success) {
        setNewKey(data.api_key);
        setDescription("");
        setStatusMsg({ 
          text: "API key created successfully! Save it now - you won't see it again.", 
          type: "success" 
        });
        setTimeout(() => {
          setShowCreateModal(false);
          fetchApiKeys();
          setNewKey(null);
        }, 3000);
      } else {
        setStatusMsg({ text: data.error || "Failed to create API key", type: "error" });
      }
    } catch (err) {
      console.error("Error creating API key:", err);
      setStatusMsg({ text: "Error creating API key", type: "error" });
    } finally {
      setCreatingKey(false);
    }
  };

  const handleRegenerateKey = async (keyId) => {
    if (!window.confirm("Regenerating will invalidate your current key. Continue?")) return;

    try {
      const response = await fetch(
        getApiUrl("api_keys_manage.php?action=regenerate"),
        {
          method: "POST",
          credentials: "include",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ key_id: keyId })
        }
      );

      const data = await response.json();
      
      if (data.success) {
        setNewKey(data.api_key);
        setStatusMsg({ text: "Key regenerated! Save the new key now.", type: "success" });
        setTimeout(() => {
          fetchApiKeys();
          setNewKey(null);
        }, 3000);
      } else {
        setStatusMsg({ text: data.error || "Failed to regenerate key", type: "error" });
      }
    } catch (err) {
      setStatusMsg({ text: "Error regenerating key", type: "error" });
    }
  };

  const handleDeleteKey = async (keyId) => {
    if (!window.confirm("Are you sure? This action cannot be undone.")) return;

    try {
      const response = await fetch(
        getApiUrl("api_keys_manage.php?action=delete"),
        {
          method: "DELETE",
          credentials: "include",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ key_id: keyId })
        }
      );

      const data = await response.json();
      
      if (data.success) {
        setStatusMsg({ text: "API key deleted successfully", type: "success" });
        fetchApiKeys();
      } else {
        setStatusMsg({ text: data.error || "Failed to delete key", type: "error" });
      }
    } catch (err) {
      setStatusMsg({ text: "Error deleting key", type: "error" });
    }
  };

  const toggleKeyVisibility = (keyId) => {
    setVisibleKeys(prev => ({
      ...prev,
      [keyId]: !prev[keyId]
    }));
  };

  const copyToClipboard = (text, keyId) => {
    navigator.clipboard.writeText(text);
    setCopiedKeyId(keyId);
    setTimeout(() => setCopiedKeyId(null), 2000);
  };

  if (!isCreator) {
    return (
      <div className="p-5 rounded-2xl bg-[var(--paper-raised)]/30 border border-[var(--rule)] text-center">
        <FaCode className="text-[var(--ink-soft)] text-2xl mx-auto mb-3" />
        <p className="text-xs text-[var(--ink-soft)]">
          Become a creator to access the developer API section
        </p>
      </div>
    );
  }

  return (
    <motion.div
      initial={{ opacity: 0, y: 12 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.35 }}
      className="p-5 rounded-2xl bg-[var(--paper-raised)]/30 border border-[var(--rule)] space-y-4"
    >
      {/* Header */}
      <div className="flex items-center justify-between">
        <h3 className="text-xs font-bold uppercase tracking-wider text-[var(--ink-soft)] flex items-center gap-1.5">
          <FaCode className="text-[var(--stamp)] text-2xs" /> Developer API Keys
        </h3>
        <button
          onClick={() => setShowCreateModal(true)}
          className="px-3 py-1.5 rounded-lg bg-[var(--stamp)] text-slate-950 text-[10px] font-bold hover:bg-[var(--stamp)] transition-all flex items-center gap-1"
        >
          <FaPlus /> Generate Key
        </button>
      </div>

      {/* Status message */}
      {statusMsg.text && (
        <div className={`p-3 rounded-lg border text-[10px] font-semibold ${
          statusMsg.type === "success" 
            ? "bg-green-900/10 border-green-700/30 text-green-400" 
            : "bg-red-900/10 border-red-700/30 text-red-400"
        }`}>
          {statusMsg.text}
        </div>
      )}

      {/* New Key Display */}
      {newKey && (
        <motion.div
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          className="p-4 rounded-lg bg-green-900/10 border border-green-700/30 space-y-2"
        >
          <p className="text-[10px] font-bold text-green-400 uppercase">Your New API Key</p>
          <div className="flex items-center gap-2">
            <code className="flex-1 bg-[var(--paper-raised)] border border-[var(--rule)] px-3 py-2 rounded-lg text-[10px] font-mono text-green-400 break-all">
              {newKey}
            </code>
            <button
              onClick={() => copyToClipboard(newKey, "new")}
              className="px-2 py-2 rounded-lg bg-[var(--paper-raised)] border border-[var(--rule)] text-[var(--ink-soft)] hover:text-[var(--link)] transition-all"
            >
              {copiedKeyId === "new" ? <FaCheck /> : <FaCopy />}
            </button>
          </div>
          <p className="text-[9px] text-[var(--ink-soft)]">
            ⚠️ Save this key somewhere safe. You won't be able to see it again!
          </p>
        </motion.div>
      )}

      {/* API Keys List */}
      {loading ? (
        <div className="text-center py-6">
          <FaSpinner className="animate-spin text-[var(--link)] text-lg mx-auto" />
        </div>
      ) : apiKeys.length === 0 ? (
        <div className="text-center py-6 text-[var(--ink-soft)]">
          <FaKey className="text-2xl mx-auto mb-2 opacity-50" />
          <p className="text-xs">No API keys yet. Create one to get started!</p>
        </div>
      ) : (
        <div className="space-y-3">
          {apiKeys.map(key => (
            <div 
              key={key.id}
              className="p-3 rounded-lg bg-[var(--paper-raised)]/50 border border-[var(--rule)] space-y-2"
            >
              <div className="flex items-center justify-between gap-2">
                <div className="flex-1 min-w-0">
                  <p className="text-[10px] font-bold text-[var(--ink-soft)] truncate">
                    {key.description || "Unnamed API Key"}
                  </p>
                </div>
                <span className={`px-2 py-0.5 rounded text-[8px] font-bold uppercase ${
                  key.is_active 
                    ? "bg-green-900/30 text-green-400" 
                    : "bg-red-900/30 text-red-400"
                }`}>
                  {key.is_active ? "Active" : "Inactive"}
                </span>
              </div>

              <div className="flex items-center gap-2 bg-[var(--paper-raised)] px-2 py-1.5 rounded-lg">
                <code className="flex-1 text-[10px] font-mono text-[var(--ink-soft)] truncate">
                  {visibleKeys[key.id] ? key.api_key : key.api_key.replace(/./g, '•')}
                </code>
                <button
                  onClick={() => toggleKeyVisibility(key.id)}
                  className="px-2 text-[var(--ink-soft)] hover:text-[var(--link)] transition-all"
                >
                  {visibleKeys[key.id] ? <FaEyeSlash size={12} /> : <FaEye size={12} />}
                </button>
                <button
                  onClick={() => copyToClipboard(key.api_key, key.id)}
                  className="px-2 text-[var(--ink-soft)] hover:text-[var(--link)] transition-all"
                >
                  {copiedKeyId === key.id ? <FaCheck size={12} /> : <FaCopy size={12} />}
                </button>
              </div>

              <div className="grid grid-cols-2 gap-2 text-[9px] text-[var(--ink-soft)]">
                <div>Requests: <span className="text-[var(--ink-soft)] font-bold">{key.requests_count}</span></div>
                <div>Created: <span className="text-[var(--ink-soft)] font-bold">{new Date(key.created_at).toLocaleDateString()}</span></div>
              </div>

              <div className="flex items-center gap-2 pt-2">
                <button
                  onClick={() => handleRegenerateKey(key.id)}
                  className="flex-1 px-2 py-1.5 rounded-lg bg-[var(--stamp-bg)] border border-[var(--rule-strong)] text-[9px] font-bold text-yellow-400 hover:bg-yellow-400 hover:text-slate-950 transition-all flex items-center justify-center gap-1"
                >
                  <FaSync size={10} /> Regenerate
                </button>
                <button
                  onClick={() => handleDeleteKey(key.id)}
                  className="flex-1 px-2 py-1.5 rounded-lg bg-[var(--stamp-bg)] border border-[var(--rule-strong)] text-[9px] font-bold text-red-400 hover:bg-red-400 hover:text-slate-950 transition-all flex items-center justify-center gap-1"
                >
                  <FaTrash size={10} /> Delete
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Create Key Modal */}
      {showCreateModal && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          className="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4"
          onClick={() => setShowCreateModal(false)}
        >
          <motion.div
            initial={{ scale: 0.95 }}
            animate={{ scale: 1 }}
            onClick={(e) => e.stopPropagation()}
            className="bg-[var(--paper-raised)] border border-[var(--rule)] rounded-2xl p-6 max-w-md w-full space-y-4"
          >
            <h4 className="text-sm font-bold text-[var(--ink)]">Generate New API Key</h4>
            
            <form onSubmit={handleCreateKey} className="space-y-3">
              <div>
                <label className="block text-[10px] font-bold uppercase tracking-wider text-[var(--ink-soft)] mb-1.5">
                  Description (Optional)
                </label>
                <input
                  type="text"
                  value={description}
                  onChange={(e) => setDescription(e.target.value)}
                  placeholder="e.g., Website Integration, Mobile App"
                  className="w-full bg-[var(--paper-raised)] border border-[var(--rule)] rounded-lg px-3 py-2 text-xs text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none"
                />
              </div>

              <div className="bg-cyan-900/10 border border-cyan-700/20 rounded-lg p-3 text-[9px] text-[var(--link)]">
                <p className="font-bold mb-1">📋 Key Information:</p>
                <ul className="space-y-0.5 text-cyan-200">
                  <li>• Keys are limited to 5 per account</li>
                  <li>• Save your key immediately - you won't see it again</li>
                  <li>• Use Bearer token in Authorization header</li>
                  <li>• Track usage and regenerate anytime</li>
                </ul>
              </div>

              <div className="flex gap-2 pt-2">
                <button
                  type="button"
                  onClick={() => setShowCreateModal(false)}
                  className="flex-1 px-3 py-2 rounded-lg bg-[var(--stamp-bg)] border border-[var(--rule-strong)] text-[10px] font-bold text-[var(--ink-soft)] hover:text-[var(--ink)] transition-all"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={creatingKey}
                  className="flex-1 px-3 py-2 rounded-lg bg-[var(--stamp)] text-slate-950 text-[10px] font-bold hover:bg-[var(--stamp)] transition-all disabled:opacity-50 flex items-center justify-center gap-1"
                >
                  {creatingKey ? (
                    <>
                      <FaSpinner className="animate-spin" /> Creating...
                    </>
                  ) : (
                    <>
                      <FaPlus /> Generate
                    </>
                  )}
                </button>
              </div>
            </form>
          </motion.div>
        </motion.div>
      )}

      {/* Documentation Link */}
      <div className="mt-4 p-3 rounded-lg bg-blue-900/10 border border-blue-700/20 flex items-center gap-2">
        <FaCode className="text-blue-400 text-sm" />
        <div className="flex-1">
          <p className="text-[10px] font-bold text-blue-400">Want to use the API?</p>
          <p className="text-[9px] text-blue-300">Check our comprehensive API documentation</p>
        </div>
        <a
          href="/api-docs"
          className="px-2 py-1 rounded-lg bg-blue-500 text-slate-950 text-[9px] font-bold hover:bg-blue-400 transition-all flex items-center gap-1"
        >
          <FaLink size={10} /> Docs
        </a>
      </div>
    </motion.div>
  );
};

export default DeveloperAPISection;
