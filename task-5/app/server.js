const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(express.json());
app.use(express.static('public'));

// Routes
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/public/index.html');
});

app.get('/health', (req, res) => {
    res.status(200).json({
        status: 'healthy',
        timestamp: new Date().toISOString(),
        pod: process.env.HOSTNAME || 'unknown',
        version: '1.0.0'
    });
});

app.get('/api/info', (req, res) => {
    res.json({
        message: 'Welcome to Task 5 Kubernetes App!',
        environment: process.env.NODE_ENV || 'development',
        pod: process.env.HOSTNAME || 'unknown',
        uptime: process.uptime(),
        memory: process.memoryUsage()
    });
});

// Start server
app.listen(port, '0.0.0.0', () => {
    console.log(`Task 5 App running on port ${port}`);
    console.log(`Pod: ${process.env.HOSTNAME || 'unknown'}`);
    console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
}); 