import React from 'react';
import { Link } from 'react-router-dom';
import SEO from '../components/SEO';

const LegalPage = ({ title, intro, highlights = [], sections = [], slug = '', description = intro, children }) => {
  return (
    <>
      <SEO title={`${title} | ReadXHub`} description={description} canonicalUrl={`/${slug}`} noindex />
      <main className="min-h-screen bg-[var(--paper)] text-[var(--ink)]">
      <section className="mx-auto max-w-5xl px-4 py-16 sm:px-6 lg:px-8">
        <div className="rounded-3xl border border-[var(--rule)] bg-[var(--paper-raised)]/70 p-8 shadow-2xl shadow-black/20 backdrop-blur">
          <div className="mb-8">
            <Link to="/" className="inline-flex items-center text-sm font-medium text-[var(--link)] transition hover:text-[var(--link)]">
              ← Back to home
            </Link>
            <h1 className="mt-4 text-3xl font-black tracking-tight text-[var(--ink)] sm:text-4xl">{title}</h1>
            <p className="mt-4 max-w-3xl text-base leading-7 text-[var(--ink-soft)]">{intro}</p>
          </div>

          {highlights.length > 0 && (
            <div className="mb-8 grid gap-4 md:grid-cols-3">
              {highlights.map((item) => (
                <div key={item.title} className="rounded-2xl border border-[var(--rule)] bg-[var(--paper-raised)]/70 p-4">
                  <h2 className="text-sm font-semibold uppercase tracking-wider text-[var(--link)]">{item.title}</h2>
                  <p className="mt-2 text-sm leading-6 text-[var(--ink-soft)]">{item.text}</p>
                </div>
              ))}
            </div>
          )}

          <div className="space-y-8">
            {sections.map((section, index) => (
              <section key={`${section.heading}-${index}`} className="rounded-2xl border border-[var(--rule)]/70 bg-[var(--paper-raised)]/50 p-6">
                <h2 className="text-xl font-semibold text-[var(--ink)]">{section.heading}</h2>
                {Array.isArray(section.body) ? (
                  <ul className="mt-4 space-y-3 text-sm leading-7 text-[var(--ink-soft)]">
                    {section.body.map((item) => (
                      <li key={item} className="flex gap-2"><span className="mt-2 h-2 w-2 rounded-full bg-[var(--stamp)]" /> <span>{item}</span></li>
                    ))}
                  </ul>
                ) : (
                  <div className="mt-4 text-sm leading-7 text-[var(--ink-soft)]">
                    {typeof section.body === 'string' ? section.body : section.body}
                  </div>
                )}
              </section>
            ))}
          </div>

          {children && <div className="mt-8 space-y-8">{children}</div>}
        </div>
      </section>
      </main>
    </>
  );
};

export default LegalPage;
