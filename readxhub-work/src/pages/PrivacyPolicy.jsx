import React from 'react';
import LegalPage from './LegalPage';

const PrivacyPolicy = () => {
  return (
    <LegalPage
      title="Privacy Policy"
      slug="privacy-policy"
      intro="This Privacy Policy explains what information ReadXHub collects, how we use it, and the choices you have when you visit the site or interact with its content."
      highlights={[
        { title: 'Collected data', text: 'We may collect basic usage data, account information, and interaction signals.' },
        { title: 'Purpose', text: 'We use collected data to improve content, support site features, and measure performance.' },
        { title: 'Your rights', text: 'You can contact us if you want to ask about the data we hold or request removal.' }
      ]}
      sections={[
        {
          heading: 'Information we collect',
          body: [
            'Basic browser and device information when you visit our website.',
            'Account-related information if you sign in or use creator features.',
            'Comments, email addresses, and profile details you submit voluntarily.'
          ]
        },
        {
          heading: 'How we use information',
          body: [
            'To deliver and improve the website experience and content quality.',
            'To support authentication, profile access, and creator features.',
            'To understand traffic and engagement patterns, including the use of advertising and analytics tools.'
          ]
        },
        {
          heading: 'Cookies and advertising',
          body: [
            'The site may use cookies and similar technologies to maintain sessions, remember preferences, and support advertising measurement.',
            'Third-party advertising providers may collect information to personalize ads and measure performance in accordance with their own privacy policies.'
          ]
        },
        {
          heading: 'Your choices',
          body: [
            'You may disable certain cookies in your browser settings where supported.',
            'If you have account-related questions, please contact us at contact@readxhub.in.'
          ]
        }
      ]}
    />
  );
};

export default PrivacyPolicy;
