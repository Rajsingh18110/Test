import React, { useEffect, useState } from 'react';
import { useAuth0 } from '@auth0/auth0-react';
import LegalPage from './LegalPage';
import { getApiUrl } from '../utils/api.js';

const Contact = () => {
  const { user, isAuthenticated } = useAuth0();
  const whatsappNumber = '+917042569188';
  const waLink = `https://wa.me/${whatsappNumber.replace(/\D/g, '')}`;

  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [subject, setSubject] = useState('General inquiry from website');
  const [message, setMessage] = useState('');
  const [statusMessage, setStatusMessage] = useState(null);
  const [statusType, setStatusType] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  useEffect(() => {
    if (isAuthenticated) {
      if (user?.name) setName(user.name);
      if (user?.email) setEmail(user.email);
    }
  }, [isAuthenticated, user]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setStatusMessage(null);
    setStatusType('');

    if (!name.trim() || !email.trim() || !message.trim()) {
      setStatusMessage('Please enter your name, email, and a message.');
      setStatusType('error');
      return;
    }

    setIsSubmitting(true);

    try {
      const res = await fetch(getApiUrl('contact.php'), {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          name: name.trim(),
          email: email.trim(),
          subject: subject.trim(),
          message: message.trim()
        })
      });

      const data = await res.json();
      if (res.ok && data.success) {
        setStatusMessage('Your message was sent successfully. We will respond as soon as possible.');
        setStatusType('success');
        setMessage('');
      } else {
        throw new Error(data.error || 'Unable to send message right now.');
      }
    } catch (err) {
      setStatusMessage(err.message);
      setStatusType('error');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <LegalPage
      title="Contact Us"
      slug="contact"
      intro="We welcome feedback and inquiries. Use the form below or connect with us directly via WhatsApp or email."
      highlights={[
        { title: 'Email', text: 'contact@readxhub.in' },
        { title: 'WhatsApp', text: whatsappNumber },
        { title: 'Admin email', text: 'adarsh.singhvishnu@gmail.com' }
      ]}
      sections={[
        {
          heading: 'How to reach us',
          body: [
            `For quick replies message on WhatsApp: ${whatsappNumber} (click: ${waLink}).`,
            'For formal or detailed communication email contact@readxhub.in.'
          ]
        },
        {
          heading: 'Reporting abuse or policy violations',
          body: [
            'If you need to report abusive or policy-violating content, email contact@readxhub.in with the content URL and your reason for reporting.',
            'Do not use the contact page for legal notices. Legal requests should be sent to our designated email address with proper documentation.'
          ]
        }
      ]}
    >
      <div className="rounded-3xl border border-[var(--rule)] bg-[var(--paper-raised)]/80 p-6 shadow-xl">
        <h2 className="text-xl font-semibold text-[var(--ink)] mb-4">Send us a message</h2>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <label className="space-y-2 text-xs text-[var(--ink-soft)]">
              <span>Name</span>
              <input
                type="text"
                value={name}
                onChange={(e) => setName(e.target.value)}
                placeholder="Your name"
                className="w-full rounded-2xl border border-[var(--rule)] bg-[var(--paper-raised)]/80 px-4 py-3 text-sm text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none"
                required
              />
            </label>

            <label className="space-y-2 text-xs text-[var(--ink-soft)]">
              <span>Email</span>
              <input
                type="email"
                value={email}
                onChange={(e) => isAuthenticated ? null : setEmail(e.target.value)}
                placeholder="you@example.com"
                className={`w-full rounded-2xl border border-[var(--rule)] bg-[var(--paper-raised)]/80 px-4 py-3 text-sm text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none ${isAuthenticated ? 'opacity-60 cursor-not-allowed' : ''}`}
                required
                readOnly={isAuthenticated}
              />
              {isAuthenticated && (
                <p className="text-[10px] text-[var(--ink-soft)]">Your verified login email is prefilled and cannot be changed.</p>
              )}
            </label>
          </div>

          <label className="space-y-2 text-xs text-[var(--ink-soft)] block">
            <span>Subject</span>
            <input
              type="text"
              value={subject}
              onChange={(e) => setSubject(e.target.value)}
              placeholder="Subject (optional)"
              className="w-full rounded-2xl border border-[var(--rule)] bg-[var(--paper-raised)]/80 px-4 py-3 text-sm text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none"
            />
          </label>

          <label className="space-y-2 text-xs text-[var(--ink-soft)] block">
            <span>Message</span>
            <textarea
              value={message}
              onChange={(e) => setMessage(e.target.value)}
              placeholder="Write your question, feedback, or report here..."
              rows={6}
              className="w-full rounded-2xl border border-[var(--rule)] bg-[var(--paper-raised)]/80 px-4 py-3 text-sm text-[var(--ink)] focus:border-[var(--stamp)]/40 focus:outline-none resize-none"
              required
            />
          </label>

          {statusMessage && (
            <div className={`rounded-2xl border p-4 text-sm ${statusType === 'success' ? 'bg-emerald-950/20 border-emerald-800 text-emerald-300' : 'bg-rose-950/20 border-rose-800 text-rose-300'}`}>
              {statusMessage}
            </div>
          )}

          <button
            type="submit"
            disabled={isSubmitting}
            className="inline-flex items-center justify-center rounded-2xl bg-[var(--stamp)] px-6 py-3 text-sm font-bold text-slate-950 transition hover:bg-[var(--stamp)] disabled:cursor-not-allowed disabled:opacity-60"
          >
            {isSubmitting ? 'Sending...' : 'Send Message'}
          </button>
        </form>
      </div>
    </LegalPage>
  );
};

export default Contact;
