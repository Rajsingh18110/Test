import React from 'react';
import LegalPage from './LegalPage';

const About = () => {
  return (
    <LegalPage
      title="About ReadXHub"
      slug="about"
      intro="ReadXHub is a technology publication focused on practical insights, technical explainers, AI notes, development tutorials, and cybersecurity guidance."
      highlights={[
        { title: 'Mission', text: 'Help readers learn fast with clear explanations and trustworthy guidance.' },
        { title: 'Audience', text: 'Developers, builders, students, and curious minds exploring modern technology.' },
        { title: 'Content style', text: 'Readable, useful, and designed to support both learning and search discovery.' }
      ]}
      sections={[
        {
          heading: 'What we publish',
          body: [
            'Technical tutorials and how-to articles for software development and product building.',
            'Practical AI notes, workflow tips, and modern engineering patterns.',
            'Cybersecurity awareness content, software security explainers, and web safety guidance.'
          ]
        },
        {
          heading: 'How we operate',
          body: [
            'We aim to keep articles accurate, transparent, and useful for real-world readers.',
            'Some pages may feature advertisements to support publishing costs and maintain free access to content.',
            'We value user trust, feedback, and responsible publishing practices.'
          ]
        },
        {
          heading: 'Contact',
          body: 'For editorial feedback, collaborations, or general questions, please visit our contact page or email contact@readxhub.in.'
        }
      ]}
    />
  );
};

export default About;
