const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet({
  contentSecurityPolicy: false // Allow inline styles for demo
}));
app.use(cors());
app.use(express.json());

// Serve static files
app.use(express.static(path.join(__dirname, 'public')));

// Routes
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/api', (req, res) => {
  res.json({
    message: 'Welcome to Node.js Demo App!',
    version: '1.0.0',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'development'
  });
});

app.get('/health', (req, res) => {
  res.json({
    status: 'OK',
    uptime: process.uptime(),
    timestamp: new Date().toISOString()
  });
});

app.get('/api/info', (req, res) => {
  res.json({
    app: 'Node.js Demo App',
    version: '1.0.0',
    description: 'A simple Node.js application for CI/CD pipeline demonstration',
    features: [
      'Express.js framework',
      'CORS enabled',
      'Security headers with Helmet',
      'Health check endpoint',
      'Docker containerization',
      'GitHub Actions CI/CD'
    ]
  });
});

app.get('/api/status', (req, res) => {
  res.json({
    status: 'running',
    memory: process.memoryUsage(),
    platform: process.platform,
    nodeVersion: process.version
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    error: 'Something went wrong!',
    message: err.message
  });
});

// 404 handler
app.use('*', (req, res) => {
  res.status(404).json({
    error: 'Route not found',
    availableRoutes: [
      'GET /',
      'GET /api',
      'GET /health',
      'GET /api/info',
      'GET /api/status'
    ]
  });
});

// Start server
const server = app.listen(PORT, () => {
  console.log(`🚀 Server is running on port ${PORT}`);
  console.log(`📱 Health check available at http://localhost:${PORT}/health`);
  console.log(`ℹ️  API info available at http://localhost:${PORT}/api/info`);
});

module.exports = { app, server }; 