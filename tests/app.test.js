const request = require('supertest');
const { app, server } = require('../src/app');

describe('DevOps Git Project API', () => {
  afterAll((done) => {
    server.close(done);
  });

  describe('GET /', () => {
    it('should serve the dashboard HTML', async () => {
      const response = await request(app).get('/');
      expect(response.status).toBe(200);
      expect(response.type).toMatch(/html/);
      expect(response.text).toContain('DevOps Git Project Dashboard');
    });
  });

  describe('GET /api', () => {
    it('should return project information', async () => {
      const response = await request(app).get('/api');
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('message');
      expect(response.body).toHaveProperty('version');
      expect(response.body).toHaveProperty('timestamp');
      expect(response.body).toHaveProperty('environment');
      expect(response.body).toHaveProperty('features');
      expect(Array.isArray(response.body.features)).toBe(true);
    });

    it('should include Git-related features', async () => {
      const response = await request(app).get('/api');
      expect(response.body.features).toContain('Git version control');
      expect(response.body.features).toContain('Branching strategies');
      expect(response.body.features).toContain('Pull request workflows');
    });
  });

  describe('GET /api/health', () => {
    it('should return health status', async () => {
      const response = await request(app).get('/api/health');
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('status');
      expect(response.body).toHaveProperty('timestamp');
      expect(response.body).toHaveProperty('uptime');
      expect(response.body).toHaveProperty('memory');
      expect(response.body.status).toBe('healthy');
    });

    it('should have valid memory usage data', async () => {
      const response = await request(app).get('/api/health');
      expect(response.body.memory).toHaveProperty('heapUsed');
      expect(response.body.memory).toHaveProperty('heapTotal');
      expect(response.body.memory).toHaveProperty('external');
      expect(response.body.memory).toHaveProperty('rss');
    });
  });

  describe('GET /api/git-info', () => {
    it('should return Git information or error gracefully', async () => {
      const response = await request(app).get('/api/git-info');
      expect(response.status).toBe(200);
      
      // Either returns Git info or error message
      if (response.body.error) {
        expect(response.body).toHaveProperty('error');
        expect(response.body).toHaveProperty('message');
      } else {
        expect(response.body).toHaveProperty('branch');
        expect(response.body).toHaveProperty('commit');
        expect(response.body).toHaveProperty('author');
        expect(response.body).toHaveProperty('lastCommitDate');
        expect(response.body).toHaveProperty('repository');
      }
    });
  });

  describe('GET /api/project-stats', () => {
    it('should return project statistics', async () => {
      const response = await request(app).get('/api/project-stats');
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('totalFiles');
      expect(response.body).toHaveProperty('fileTypes');
      expect(response.body).toHaveProperty('directories');
      expect(response.body).toHaveProperty('lastModified');
      expect(typeof response.body.totalFiles).toBe('number');
      expect(Array.isArray(response.body.directories)).toBe(true);
    });
  });

  describe('GET /api/features', () => {
    it('should return feature lists', async () => {
      const response = await request(app).get('/api/features');
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('completed');
      expect(response.body).toHaveProperty('inProgress');
      expect(response.body).toHaveProperty('planned');
      expect(Array.isArray(response.body.completed)).toBe(true);
      expect(Array.isArray(response.body.inProgress)).toBe(true);
      expect(Array.isArray(response.body.planned)).toBe(true);
    });

    it('should include Git-related completed features', async () => {
      const response = await request(app).get('/api/features');
      expect(response.body.completed).toContain('Git repository setup');
      expect(response.body.completed).toContain('Branching strategy');
      expect(response.body.completed).toContain('Commit conventions');
      expect(response.body.completed).toContain('Pull request workflow');
    });
  });

  describe('Error handling', () => {
    it('should return 404 for unknown routes', async () => {
      const response = await request(app).get('/api/unknown');
      expect(response.status).toBe(404);
      expect(response.body).toHaveProperty('error');
      expect(response.body).toHaveProperty('message');
    });

    it('should handle malformed requests gracefully', async () => {
      const response = await request(app).post('/api');
      expect(response.status).toBe(404);
    });
  });

  describe('Security headers', () => {
    it('should include security headers', async () => {
      const response = await request(app).get('/api');
      expect(response.headers).toHaveProperty('x-frame-options');
      expect(response.headers).toHaveProperty('x-content-type-options');
      expect(response.headers).toHaveProperty('x-xss-protection');
    });
  });
}); 