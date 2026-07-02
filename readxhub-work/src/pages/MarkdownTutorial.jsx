import React from "react";
import { Link } from "react-router-dom";
import { FaArrowLeft, FaCode } from "react-icons/fa";

export default function MarkdownTutorial() {
    return (
        <main className="min-h-screen bg-[var(--paper)] text-[var(--ink)] py-16 px-6">
            <div className="max-w-4xl mx-auto space-y-10">
                <Link to="/dashboard" className="inline-flex items-center gap-1.5 text-xs text-[var(--ink-soft)] hover:text-[var(--link)] transition-colors font-medium">
                    <FaArrowLeft /> Back to Dashboard
                </Link>

                <header className="space-y-3">
                    <h1 className="text-3xl md:text-4xl font-extrabold text-[var(--ink)] tracking-tight flex items-center gap-3">
                        <FaCode className="text-[var(--stamp)]" /> Markdown Formatting Guide
                    </h1>
                    <p className="text-[var(--ink-soft)] text-sm">Learn how to easily format your articles using standard Markdown syntax.</p>
                </header>

                <div className="bg-[var(--paper-raised)]/40 border border-[var(--rule)] rounded-2xl p-6 md:p-8 space-y-8 shadow-xl">
                    
                    <section className="space-y-4">
                        <h2 className="text-xl font-bold text-[var(--link)]">Headings</h2>
                        <p className="text-sm text-[var(--ink-soft)]">Use hash symbols (#) to create headings. The number of hashes determines the heading level.</p>
                        <div className="bg-[var(--paper-raised)] border border-[var(--rule)] p-4 rounded-xl font-mono text-sm text-[var(--ink-soft)]">
                            # Main Title (Heading 1)<br/>
                            ## Section Title (Heading 2)<br/>
                            ### Sub-section (Heading 3)
                        </div>
                    </section>

                    <section className="space-y-4">
                        <h2 className="text-xl font-bold text-[var(--link)]">Text Formatting</h2>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div className="bg-[var(--paper-raised)] border border-[var(--rule)] p-4 rounded-xl font-mono text-sm text-[var(--ink-soft)]">
                                **Bold Text**<br/>
                                *Italic Text*<br/>
                                ~~Strikethrough~~
                            </div>
                            <div className="bg-[var(--paper-raised)] border border-[var(--rule)] p-4 rounded-xl text-sm flex flex-col justify-center gap-2">
                                <strong>Bold Text</strong>
                                <em>Italic Text</em>
                                <del>Strikethrough</del>
                            </div>
                        </div>
                    </section>

                    <section className="space-y-4">
                        <h2 className="text-xl font-bold text-[var(--link)]">Lists</h2>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div className="bg-[var(--paper-raised)] border border-[var(--rule)] p-4 rounded-xl font-mono text-sm text-[var(--ink-soft)]">
                                - Bullet item 1<br/>
                                - Bullet item 2<br/>
                                <br/>
                                1. Numbered item 1<br/>
                                2. Numbered item 2
                            </div>
                            <div className="bg-[var(--paper-raised)] border border-[var(--rule)] p-4 rounded-xl text-sm text-[var(--ink-soft)]">
                                <ul className="list-disc ml-5 mb-4">
                                    <li>Bullet item 1</li>
                                    <li>Bullet item 2</li>
                                </ul>
                                <ol className="list-decimal ml-5">
                                    <li>Numbered item 1</li>
                                    <li>Numbered item 2</li>
                                </ol>
                            </div>
                        </div>
                    </section>

                    <section className="space-y-4">
                        <h2 className="text-xl font-bold text-[var(--link)]">Code Blocks & Inline Code</h2>
                        <p className="text-sm text-[var(--ink-soft)]">Wrap text with single backticks (`code`) for inline code. For multi-line code blocks, use triple backticks.</p>
                        <div className="bg-[var(--paper-raised)] border border-[var(--rule)] p-4 rounded-xl font-mono text-sm text-[var(--ink-soft)]">
                            Here is an `inline code` example.<br/><br/>
                            ```javascript<br/>
                            function hello() &#123;<br/>
                                console.log("Hello World!");<br/>
                            &#125;<br/>
                            ```
                        </div>
                    </section>

                    <section className="space-y-4">
                        <h2 className="text-xl font-bold text-[var(--link)]">Links and Images</h2>
                        <div className="bg-[var(--paper-raised)] border border-[var(--rule)] p-4 rounded-xl font-mono text-sm text-[var(--ink-soft)]">
                            [Click here for Google](https://google.com)<br/>
                            ![Image Alt Text](https://example.com/image.jpg)
                        </div>
                    </section>
                    
                    <section className="space-y-4">
                        <h2 className="text-xl font-bold text-[var(--link)]">YouTube Embeds</h2>
                        <p className="text-sm text-[var(--ink-soft)]">To embed a YouTube video seamlessly into your article, simply paste this snippet using the 11-character Video ID.</p>
                        <div className="bg-[var(--paper-raised)] border border-[var(--rule)] p-4 rounded-xl font-mono text-sm text-[var(--ink-soft)]">
                            [youtube:VIDEO_ID_HERE]
                        </div>
                    </section>
                </div>
            </div>
        </main>
    );
}
