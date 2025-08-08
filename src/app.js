const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      scriptSrc: ["'self'", "'unsafe-inline'"],
    },
  },
}));
app.use(cors());
app.use(morgan('combined'));
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// Utility functions
const { getGitInfo, getProjectStats } = require('./utils/projectUtils');

// Routes
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/api', (req, res) => {
  res.json({
    message: 'Welcome to Task 4 - Version-Controlled DevOps Project!',
    version: '1.0.0',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'development',
    features: [
      'Git version control',
      'Branching strategies',
      'Pull request workflows',
      'Commit conventions',
      'Tagging system'
    ]
  });
});

app.get('/api/health', (req, res) => {
  res.json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    memory: process.memoryUsage()
  });
});

app.get('/api/git-info', async (req, res) => {
  try {
    const gitInfo = await getGitInfo();
    res.json(gitInfo);
  } catch (error) {
    res.status(500).json({ error: 'Failed to get Git information' });
  }
});

app.get('/api/project-stats', async (req, res) => {
  try {
    const stats = await getProjectStats();
    res.json(stats);
  } catch (error) {
    res.status(500).json({ error: 'Failed to get project statistics' });
  }
});

app.get('/api/features', (req, res) => {
  res.json({
    completed: [
      'Git repository setup',
      'Branching strategy',
      'Commit conventions',
      'Pull request workflow',
      'Documentation structure'
    ],
    inProgress: [
      'User authentication',
      'API endpoints',
      'Database integration'
    ],
    planned: [
      'Admin dashboard',
      'Reporting system',
      'Email notifications'
    ]
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    error: 'Something went wrong!',
    message: process.env.NODE_ENV === 'development' ? err.message : 'Internal server error'
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    error: 'Not Found',
    message: 'The requested resource was not found'
  });
});

const server = app.listen(PORT, () => {
  console.log(`🚀 DevOps Git Project server running on port ${PORT}`);
  console.log(`📊 Health check: http://localhost:${PORT}/api/health`);
  console.log(`📈 Project stats: http://localhost:${PORT}/api/project-stats`);
});

module.exports = { app, server }; 