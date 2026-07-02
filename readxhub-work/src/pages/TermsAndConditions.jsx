import React from 'react';
import LegalPage from './LegalPage';

const TermsAndConditions = () => {
  return (
    <LegalPage
      title="Terms and Conditions"
      slug="terms-and-conditions"
      intro="By using ReadXHub, you agree to the terms below. These terms help protect readers, contributors, and the site itself."
      highlights={[
        { title: 'Use of site', text: 'The site is for informational and educational purposes.' },
        { title: 'User content', text: 'User-submitted content must be lawful and respectful.' },
        { title: 'Ads', text: 'Advertising may appear on pages to support the publication.' }
      ]}
      sections={[
        {
          heading: 'Acceptable use',
          body: [
            'Do not post harmful, misleading, or unlawful content.',
            'Do not attempt to interfere with the website, its features, or its security.',
            'Respect the rights of authors, readers, and other users.'
          ]
        },
        {
          heading: 'Content and intellectual property',
          body: [
            'Articles, media, and design elements are owned or licensed by ReadXHub unless otherwise noted.',
            'Do not copy or redistribute site content without permission.',
            'If you submit content, you remain responsible for its accuracy and legality.'
          ]
        },
        {
          heading: 'Account termination and enforcement',
          body: [
            'ReadXHub may suspend or terminate accounts, remove content, or restrict access at our discretion where users violate these Terms or engage in suspicious or harmful activity.',
            'Suspension or termination may follow reports from other users, automated detection of suspicious activity, repeated policy violations, or threats to site security or community safety.',
            'We may take interim actions (including content removal and access restriction) while investigating reports or suspicious activity.',
            'Account holders are responsible for maintaining the security of their credentials; we are not liable for harms arising from compromised accounts.'
          ]
        },
        {
          heading: 'Reporting and takedown',
          body: [
            'To report content or account activity, email contact@readxhub.in or message the site administrators on the published WhatsApp number with the content URL and reason for the report.',
            'We will review reports promptly and take action in accordance with these Terms.'
          ]
        },
        {
          heading: 'Indemnification',
          body: 'To the fullest extent permitted by law, you agree to indemnify and hold harmless ReadXHub and its officers, directors, employees, and agents from any claims, damages, liabilities, and expenses arising from your use of the site or any content you submit.'
        },
        {
          heading: 'Limitation of liability',
          body: 'ReadXHub is provided as-is. We are not liable for any indirect, incidental, or consequential losses arising from your use of the site.'
        },
        {
          heading: 'Changes to these terms',
          body: 'We may update these terms from time to time. Continued use of the site means you accept the latest version.'
        }
      ]}
    />
  );
};

export default TermsAndConditions;
