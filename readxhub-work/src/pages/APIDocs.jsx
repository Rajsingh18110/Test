import React, { useState } from "react";
import { motion } from "framer-motion";
import { 
  FaCode, FaCopy, FaCheck, FaArrowRight, FaKey, FaTerminal,
  FaExclamationTriangle, FaGlobe, FaUser, FaBook
} from "react-icons/fa";
import { getApiUrl } from "../utils/api.js";

const APIDocs = () => {
  const [copiedId, setCopiedId] = useState(null);

  const copyCode = (id, text) => {
    navigator.clipboard.writeText(text);
    setCopiedId(id);
    setTimeout(() => setCopiedId(null), 2000);
  };

  const codeExamples = {
    basicAuth: `curl -X GET "https://blogs.readxhub.in/api_public.php?action=all&api_key=YOUR_API_KEY"`,
    bearerAuth: `curl -X GET "https://blogs.readxhub.in/api_public.php?action=all" \\
  -H "Authorization: Bearer YOUR_API_KEY"`,
    nodeExample: `const response = await fetch('https://blogs.readxhub.in/api_public.php?action=all', {
  headers: {
    'Authorization': 'Bearer YOUR_API_KEY'
  }
});
const blogs = await response.json();`,
    pythonExample: `import requests

headers = {'Authorization': 'Bearer YOUR_API_KEY'}
response = requests.get('https://blogs.readxhub.in/api_public.php?action=all', headers=headers)
blogs = response.json()`,
    searchExample: `curl "https://blogs.readxhub.in/api_public.php?action=search&q=javascript&api_key=YOUR_API_KEY"`,
    authorExample: `curl "https://blogs.readxhub.in/api_public.php?action=author&username=john_doe&api_key=YOUR_API_KEY"`,
    singleExample: `curl "https://blogs.readxhub.in/api_public.php?action=single&slug=how-to-learn-react&api_key=YOUR_API_KEY"`,
    paginationExample: `curl "https://blogs.readxhub.in/api_public.php?action=all&limit=20&offset=0&api_key=YOUR_API_KEY"`,
    sortExample: `curl "https://blogs.readxhub.in/api_public.php?action=all&sort=views&order=DESC&limit=10&api_key=YOUR_API_KEY"`
  };

  const CodeBlock = ({ id, code, language = "bash" }) => (
    <div className="relative rounded-lg overflow-hidden bg-[var(--paper-raised)] border border-[var(--rule)]">
      <div className="absolute top-3 right-3">
        <button
          onClick={() => copyCode(id, code)}
          className="px-2 py-1 rounded-lg bg-[var(--stamp-bg)] hover:bg-[var(--stamp-bg)] text-[var(--ink-soft)] hover:text-[var(--link)] text-xs font-bold transition-all flex items-center gap-1"
        >
          {copiedId === id ? (
            <>
              <FaCheck size={12} /> Copied!
            </>
          ) : (
            <>
              <FaCopy size={12} /> Copy
            </>
          )}
        </button>
      </div>
      <pre className="p-4 pr-24 overflow-x-auto text-[11px] font-mono text-[var(--ink-soft)]">
        <code>{code}</code>
      </pre>
    </div>
  );

  const ApiEndpoint = ({ method, path, description }) => (
    <div className="p-4 rounded-lg bg-[var(--paper-raised)]/50 border border-[var(--rule)]">
      <div className="flex items-center gap-2 mb-2">
        <span className={`px-2 py-0.5 rounded-lg text-[10px] font-bold ${
          method === 'GET' ? 'bg-green-900/30 text-green-400' : 'bg-blue-900/30 text-blue-400'
        }`}>
          {method}
        </span>
        <code className="text-xs font-mono text-[var(--link)]">{path}</code>
      </div>
      <p className="text-xs text-[var(--ink-soft)]">{description}</p>
    </div>
  );

  return (
    <main className="min-h-screen bg-[var(--paper)] text-[var(--ink)] selection:bg-[var(--stamp)]/30 selection:text-[var(--link)] py-16 px-6">
      <div className="max-w-4xl mx-auto">
        
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-12 text-center space-y-4"
        >
          <h1 className="text-3xl md:text-4xl font-extrabold text-[var(--ink)] tracking-tight flex items-center justify-center gap-2">
            <FaCode className="text-[var(--link)]" /> API Documentation
          </h1>
          <p className="text-[var(--ink-soft)] max-w-2xl mx-auto">
            Integrate ReadXHub blogs into your website or application using our powerful public API. 
            No user personal data is exposed – only public blog information.
          </p>
        </motion.div>

        {/* Quick Start */}
        <motion.section
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="mb-8 p-6 rounded-2xl bg-gradient-to-r from-cyan-900/20 to-blue-900/20 border border-[var(--stamp)]/20 space-y-4"
        >
          <h2 className="text-xl font-bold text-[var(--link)] flex items-center gap-2">
            <FaTerminal /> Quick Start
          </h2>
          
          <div className="space-y-3">
            <div>
              <p className="text-sm font-semibold text-[var(--ink-soft)] mb-2">1. Get Your API Key</p>
              <p className="text-xs text-[var(--ink-soft)]">
                Go to your <span className="text-[var(--link)]">Profile → Developer API Keys</span> and generate a new API key. Save it somewhere secure!
              </p>
            </div>

            <div>
              <p className="text-sm font-semibold text-[var(--ink-soft)] mb-2">2. Make Your First Request</p>
              <CodeBlock id="quickstart" code={codeExamples.basicAuth} />
              <p className="text-xs text-[var(--ink-soft)] mt-2">
                Note: All API requests should be sent directly to <span className="text-[var(--link)]">https://blogs.readxhub.in/api_public.php</span>. Do not use the old <span className="text-[var(--link)]">/backend/</span> proxy path.
              </p>
            </div>

            <div>
              <p className="text-sm font-semibold text-[var(--ink-soft)] mb-2">3. Parse the Response</p>
              <p className="text-xs text-[var(--ink-soft)]">
                You'll receive a JSON object with blog data. Check the examples below for more details.
              </p>
            </div>
          </div>
        </motion.section>

        {/* Authentication */}
        <motion.section
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.15 }}
          className="mb-8 space-y-4"
        >
          <h2 className="text-xl font-bold text-[var(--ink)] flex items-center gap-2">
            <FaKey /> Authentication
          </h2>

          <div className="bg-[var(--paper-raised)]/40 border border-[var(--rule)] rounded-lg p-4 space-y-3">
            <p className="text-xs text-[var(--ink-soft)]">
              All API requests require your API key. You can pass it in two ways:
            </p>

            <div className="space-y-3">
              <div>
                <p className="text-sm font-semibold text-[var(--ink-soft)] mb-2">Method 1: Query Parameter</p>
                <CodeBlock id="auth1" code={codeExamples.basicAuth} />
              </div>

              <div>
                <p className="text-sm font-semibold text-[var(--ink-soft)] mb-2">Method 2: Authorization Header (Recommended)</p>
                <CodeBlock id="auth2" code={codeExamples.bearerAuth} />
                <p className="text-xs text-[var(--ink-soft)] mt-2">
                  All requests should go directly to <span className="text-[var(--link)]">https://blogs.readxhub.in</span>. Use the `Authorization` header or query parameter for API key access, and enable CORS/credentials on the backend if you need browser-based authentication.
                </p>
              </div>
            </div>
          </div>
        </motion.section>

        {/* Endpoints */}
        <motion.section
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="mb-8 space-y-4"
        >
          <h2 className="text-xl font-bold text-[var(--ink)] flex items-center gap-2">
            <FaGlobe /> API Endpoints
          </h2>

          <div className="space-y-3">
            <ApiEndpoint 
              method="GET" 
              path="/api_public.php?action=all"
              description="Get all published blogs with pagination support"
            />

            <ApiEndpoint 
              method="GET" 
              path="/api_public.php?action=search"
              description="Search blogs by title, keywords, or description"
            />

            <ApiEndpoint 
              method="GET" 
              path="/api_public.php?action=author"
              description="Get all blogs by a specific author username"
            />

            <ApiEndpoint 
              method="GET" 
              path="/api_public.php?action=single"
              description="Get a single blog by its slug"
            />
          </div>
        </motion.section>

        {/* Query Parameters */}
        <motion.section
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.25 }}
          className="mb-8 space-y-4"
        >
          <h2 className="text-xl font-bold text-[var(--ink)] flex items-center gap-2">
            <FaBook /> Query Parameters
          </h2>

          <div className="bg-[var(--paper-raised)]/40 border border-[var(--rule)] rounded-lg overflow-hidden">
            <table className="w-full text-xs">
              <thead className="bg-[var(--paper-raised)]">
                <tr className="border-b border-[var(--rule)]">
                  <th className="p-3 text-left text-[var(--ink-soft)] font-bold">Parameter</th>
                  <th className="p-3 text-left text-[var(--ink-soft)] font-bold">Type</th>
                  <th className="p-3 text-left text-[var(--ink-soft)] font-bold">Description</th>
                  <th className="p-3 text-left text-[var(--ink-soft)] font-bold">Example</th>
                </tr>
              </thead>
              <tbody>
                <tr className="border-b border-[var(--rule)]/50">
                  <td className="p-3 font-mono text-[var(--link)]">action</td>
                  <td className="p-3 text-[var(--ink-soft)]">string</td>
                  <td className="p-3 text-[var(--ink-soft)]">all, search, author, single</td>
                  <td className="p-3 font-mono text-[var(--ink-soft)]">all</td>
                </tr>
                <tr className="border-b border-[var(--rule)]/50">
                  <td className="p-3 font-mono text-[var(--link)]">api_key</td>
                  <td className="p-3 text-[var(--ink-soft)]">string</td>
                  <td className="p-3 text-[var(--ink-soft)]">Your API key (required)</td>
                  <td className="p-3 font-mono text-[var(--ink-soft)]">abc123...</td>
                </tr>
                <tr className="border-b border-[var(--rule)]/50">
                  <td className="p-3 font-mono text-[var(--link)]">limit</td>
                  <td className="p-3 text-[var(--ink-soft)]">integer</td>
                  <td className="p-3 text-[var(--ink-soft)]">Results per page (max 100)</td>
                  <td className="p-3 font-mono text-[var(--ink-soft)]">10</td>
                </tr>
                <tr className="border-b border-[var(--rule)]/50">
                  <td className="p-3 font-mono text-[var(--link)]">offset</td>
                  <td className="p-3 text-[var(--ink-soft)]">integer</td>
                  <td className="p-3 text-[var(--ink-soft)]">Pagination offset</td>
                  <td className="p-3 font-mono text-[var(--ink-soft)]">0</td>
                </tr>
                <tr className="border-b border-[var(--rule)]/50">
                  <td className="p-3 font-mono text-[var(--link)]">sort</td>
                  <td className="p-3 text-[var(--ink-soft)]">string</td>
                  <td className="p-3 text-[var(--ink-soft)]">created_at, title, views, likes</td>
                  <td className="p-3 font-mono text-[var(--ink-soft)]">views</td>
                </tr>
                <tr className="border-b border-[var(--rule)]/50">
                  <td className="p-3 font-mono text-[var(--link)]">order</td>
                  <td className="p-3 text-[var(--ink-soft)]">string</td>
                  <td className="p-3 text-[var(--ink-soft)]">ASC or DESC</td>
                  <td className="p-3 font-mono text-[var(--ink-soft)]">DESC</td>
                </tr>
                <tr className="border-b border-[var(--rule)]/50">
                  <td className="p-3 font-mono text-[var(--link)]">q</td>
                  <td className="p-3 text-[var(--ink-soft)]">string</td>
                  <td className="p-3 text-[var(--ink-soft)]">Search query (for search action)</td>
                  <td className="p-3 font-mono text-[var(--ink-soft)]">javascript</td>
                </tr>
                <tr className="border-b border-[var(--rule)]/50">
                  <td className="p-3 font-mono text-[var(--link)]">username</td>
                  <td className="p-3 text-[var(--ink-soft)]">string</td>
                  <td className="p-3 text-[var(--ink-soft)]">Author username (for author action)</td>
                  <td className="p-3 font-mono text-[var(--ink-soft)]">john_doe</td>
                </tr>
                <tr>
                  <td className="p-3 font-mono text-[var(--link)]">slug</td>
                  <td className="p-3 text-[var(--ink-soft)]">string</td>
                  <td className="p-3 text-[var(--ink-soft)]">Blog slug (for single action)</td>
                  <td className="p-3 font-mono text-[var(--ink-soft)]">my-blog-post</td>
                </tr>
              </tbody>
            </table>
          </div>
        </motion.section>

        {/* Examples */}
        <motion.section
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          className="mb-8 space-y-4"
        >
          <h2 className="text-xl font-bold text-[var(--ink)] flex items-center gap-2">
            <FaCode /> Code Examples
          </h2>

          <div className="space-y-6">
            {/* JavaScript */}
            <div className="space-y-2">
              <h3 className="font-bold text-[var(--ink-soft)] text-sm">JavaScript / Node.js</h3>
              <CodeBlock id="node" code={codeExamples.nodeExample} />
            </div>

            {/* Python */}
            <div className="space-y-2">
              <h3 className="font-bold text-[var(--ink-soft)] text-sm">Python</h3>
              <CodeBlock id="python" code={codeExamples.pythonExample} />
            </div>

            {/* Search Example */}
            <div className="space-y-2">
              <h3 className="font-bold text-[var(--ink-soft)] text-sm">Search Blogs</h3>
              <CodeBlock id="search" code={codeExamples.searchExample} />
            </div>

            {/* Author Example */}
            <div className="space-y-2">
              <h3 className="font-bold text-[var(--ink-soft)] text-sm">Get Author's Blogs</h3>
              <CodeBlock id="author" code={codeExamples.authorExample} />
            </div>

            {/* Single Blog */}
            <div className="space-y-2">
              <h3 className="font-bold text-[var(--ink-soft)] text-sm">Get Single Blog by Slug</h3>
              <CodeBlock id="single" code={codeExamples.singleExample} />
            </div>

            {/* Pagination */}
            <div className="space-y-2">
              <h3 className="font-bold text-[var(--ink-soft)] text-sm">Pagination</h3>
              <CodeBlock id="pagination" code={codeExamples.paginationExample} />
            </div>

            {/* Sorting */}
            <div className="space-y-2">
              <h3 className="font-bold text-[var(--ink-soft)] text-sm">Sort by Views (Descending)</h3>
              <CodeBlock id="sort" code={codeExamples.sortExample} />
            </div>
          </div>
        </motion.section>

        {/* Response Format */}
        <motion.section
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.35 }}
          className="mb-8 space-y-4"
        >
          <h2 className="text-xl font-bold text-[var(--ink)]">Response Format</h2>

          <div className="space-y-3">
            <p className="text-sm text-[var(--ink-soft)]">
              All successful responses return a JSON object with the following structure:
            </p>

            <CodeBlock 
              id="response" 
              code={`{
  "success": true,
  "data": [
    {
      "id": 1,
      "title": "How to Learn React",
      "description": "A beginner's guide to React",
      "slug": "how-to-learn-react",
      "author": "John Doe",
      "author_username": "john_doe",
      "featured_image": "/uploads/image.jpg",
      "featured_image_thumb": "/uploads/image-thumb.jpg",
      "views": 1250,
      "likes": 45,
      "dislikes": 2,
      "created_at": "2024-01-15T10:30:00Z",
      "reading_time": 5,
      "word_count": 1200,
      "excerpt": "Lorem ipsum dolor sit amet..."
    }
  ],
  "pagination": {
    "limit": 10,
    "offset": 0,
    "total": 150
  }
}`}
            />
          </div>
        </motion.section>

        {/* Rate Limiting */}
        <motion.section
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4 }}
          className="mb-8 space-y-4"
        >
          <h2 className="text-xl font-bold text-[var(--ink)] flex items-center gap-2">
            <FaExclamationTriangle /> Important Information
          </h2>

          <div className="space-y-3 bg-[var(--paper-raised)]/40 border border-[var(--rule)] rounded-lg p-4">
            <div>
              <h3 className="font-bold text-amber-400 text-sm mb-1">No Personal Data Exposed</h3>
              <p className="text-xs text-[var(--ink-soft)]">
                Our API never returns user email addresses, phone numbers, or other personal information. 
                Only public blog content and author names are shared.
              </p>
            </div>

            <div>
              <h3 className="font-bold text-amber-400 text-sm mb-1">API Key Security</h3>
              <p className="text-xs text-[var(--ink-soft)]">
                Keep your API key secure. Don't share it publicly or expose it in client-side code. 
                Use server-side requests whenever possible.
              </p>
            </div>

            <div>
              <h3 className="font-bold text-amber-400 text-sm mb-1">Rate Limiting</h3>
              <p className="text-xs text-[var(--ink-soft)]">
                Currently, there's no strict rate limit. However, we monitor usage and may implement 
                limits if abuse is detected.
              </p>
            </div>

            <div>
              <h3 className="font-bold text-amber-400 text-sm mb-1">Usage Tracking</h3>
              <p className="text-xs text-[var(--ink-soft)]">
                All API requests are logged and associated with your API key. You can view your 
                API usage statistics in your developer dashboard.
              </p>
            </div>
          </div>
        </motion.section>

        {/* Support */}
        <motion.section
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.45 }}
          className="text-center p-6 rounded-2xl bg-gradient-to-r from-cyan-900/10 to-blue-900/10 border border-[var(--stamp)]/20"
        >
          <h2 className="text-lg font-bold text-[var(--link)] mb-2">Need Help?</h2>
          <p className="text-sm text-[var(--ink-soft)] mb-4">
            For API support, issues, or feature requests, please contact us at support@readxhub.com
          </p>
          <div className="flex gap-3 justify-center">
            <a
              href="/contact"
              className="px-4 py-2 rounded-lg bg-[var(--stamp)] text-slate-950 text-sm font-bold hover:bg-[var(--stamp)] transition-all inline-flex items-center gap-2"
            >
              Contact Us <FaArrowRight />
            </a>
          </div>
        </motion.section>

      </div>
    </main>
  );
};

export default APIDocs;
