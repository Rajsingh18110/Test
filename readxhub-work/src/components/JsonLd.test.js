import { generateBlogSchema } from './JsonLd';

test('uses ReadXHub branding in generated schema defaults', () => {
  const schema = generateBlogSchema({}, 'https://readxhub.in/blog/test', 'https://readxhub.in');

  expect(schema.author.name).toBe('ReadXHub Author');
  expect(schema.publisher.name).toBe('ReadXHub');
});
