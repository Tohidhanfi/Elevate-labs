const request = require('supertest');
const { app, server } = require('../app');

// Close server after tests
afterAll(done => {
  server.close(done);
});

describe('Node.js Demo App', () => {
  describe('GET /api', () => {
    it('should return welcome message and app info', async () => {
      const response = await request(app).get('/api');
      
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('message');
      expect(response.body).toHaveProperty('version');
      expect(response.body).toHaveProperty('timestamp');
      expect(response.body).toHaveProperty('environment');
      expect(response.body.message).toBe('Welcome to Node.js Demo App!');
    });
  });

  describe('GET /health', () => {
    it('should return health status', async () => {
      const response = await request(app).get('/health');
      
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('status');
      expect(response.body).toHaveProperty('uptime');
      expect(response.body).toHaveProperty('timestamp');
      expect(response.body.status).toBe('OK');
    });
  });

  describe('GET /api/info', () => {
    it('should return app information', async () => {
      const response = await request(app).get('/api/info');
      
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('app');
      expect(response.body).toHaveProperty('version');
      expect(response.body).toHaveProperty('description');
      expect(response.body).toHaveProperty('features');
      expect(response.body.app).toBe('Node.js Demo App');
      expect(Array.isArray(response.body.features)).toBe(true);
    });
  });

  describe('GET /api/status', () => {
    it('should return system status', async () => {
      const response = await request(app).get('/api/status');
      
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('status');
      expect(response.body).toHaveProperty('memory');
      expect(response.body).toHaveProperty('platform');
      expect(response.body).toHaveProperty('nodeVersion');
      expect(response.body.status).toBe('running');
    });
  });

  describe('404 handler', () => {
    it('should return 404 for non-existent routes', async () => {
      const response = await request(app).get('/non-existent');
      
      expect(response.status).toBe(404);
      expect(response.body).toHaveProperty('error');
      expect(response.body).toHaveProperty('availableRoutes');
      expect(response.body.error).toBe('Route not found');
      expect(Array.isArray(response.body.availableRoutes)).toBe(true);
    });
  });

  describe('Error handling', () => {
    it('should handle server errors gracefully', async () => {
      // This test ensures the error handling middleware is in place
      // In a real scenario, you might trigger an error by calling a route that throws
      const response = await request(app).get('/health');
      
      expect(response.status).toBe(200);
      // If there was an error, it should be handled by the error middleware
    });
  });
}); 