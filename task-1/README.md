# Task 1: CI/CD Pipeline with GitHub Actions

## 🎯 What We're Building

A complete **CI/CD (Continuous Integration/Continuous Deployment) pipeline** that automatically builds, tests, and deploys a Node.js web application using GitHub Actions and Docker.

### 🏗️ Project Overview
- **Web Application**: Node.js Express server with REST API endpoints
- **CI/CD Pipeline**: Automated testing, building, and deployment
- **Containerization**: Docker image with multi-stage build
- **Security**: Automated vulnerability scanning
- **Deployment**: Automatic push to DockerHub

## 📁 Folder Structure

```
task-1/
├── .github/
│   └── workflows/
│       └── main.yml          # GitHub Actions CI/CD pipeline
├── src/
│   ├── app.js               # Main Node.js Express application
│   ├── package.json         # Dependencies and scripts
│   └── __tests__/
│       └── app.test.js      # Unit tests for the application
├── Dockerfile               # Multi-stage Docker build
├── .dockerignore           # Docker optimization
├── docker-compose.yml      # Local development (optional)
├── nginx.conf             # Basic reverse proxy config
├── images/                 # Screenshots and demo images
│   └── dashboard-screenshot.png # Dashboard screenshot
├── .gitignore            # Version control exclusions
└── README.md             # This documentation
```

## 🚀 How It Works

### 1. **Application Layer** (`src/`)
- **`app.js`**: Express server with health checks and API endpoints
- **`package.json`**: Dependencies (Express, CORS, Helmet) and scripts
- **`__tests__/app.test.js`**: Comprehensive test suite
- **`public/index.html`**: Beautiful interactive dashboard interface

### 2. **CI/CD Pipeline** (`.github/workflows/main.yml`)
- **Test Job**: Runs Node.js tests in Ubuntu runner
- **Build Job**: Creates Docker image with multi-stage build
- **Security Job**: Scans for vulnerabilities with Trivy
- **Deploy Job**: Pushes to DockerHub and simulates deployment

### 3. **Containerization** (`Dockerfile`)
- Simple single-stage build
- Easy to understand and explain
- Standard Node.js application container
- Production-ready configuration

### 4. **Reverse Proxy** (`nginx.conf`)
- Basic nginx reverse proxy setup
- Forwards requests from port 80 to Node.js app
- Simple and easy to explain
- Load balancing ready

## 🛠️ Setup Steps

### Step 1: Create GitHub Repository
```bash
# Create new repository on GitHub
# Clone to your local machine
git clone <your-repo-url>
cd <your-repo-name>
```

### Step 2: Add Project Files
```bash
# Copy all files from task-1/ to your repository
# Commit and push
git add .
git commit -m "Initial commit: CI/CD pipeline setup"
git push origin main
```

### Step 3: Configure GitHub Secrets
1. Go to your repository → Settings → Secrets and variables → Actions
2. Add these secrets:
   - `DOCKERHUB_USERNAME`: Your DockerHub username
   - `DOCKERHUB_TOKEN`: Your DockerHub access token

### Step 4: Watch the Pipeline Run
- Push triggers GitHub Actions automatically
- Check Actions tab to monitor progress
- Pipeline runs in Ubuntu runners (no local setup needed)

## 🎯 What Happens in the Pipeline

### 1. **Environment Setup** (Ubuntu Runner)
```yaml
- Node.js 18 installation
- Docker setup with Buildx
- All tools pre-installed
```

### 2. **Testing Phase**
```yaml
- Install npm dependencies
- Run comprehensive test suite
- Validate code quality
```

### 3. **Building Phase**
```yaml
- Multi-stage Docker build
- Optimize image size
- Security hardening
```

### 4. **Deployment Phase**
```yaml
- Push to DockerHub
- Security scanning with Trivy
- Production deployment simulation
```

## 🌐 Running the Application

### After Pipeline Success:
```bash
# Pull the built image from DockerHub
docker pull tohidazure/elevate-labs-task1:latest

# Run the application
docker run -p 3000:3000 tohidazure/elevate-labs-task1:latest
```

### Available Endpoints:
- `GET /` - **Beautiful interactive dashboard** 🎨
- `GET /api` - Welcome message and app info
- `GET /health` - Health check status
- `GET /api/info` - Application information
- `GET /api/status` - System status

## 🖼️ Application Screenshots

### Interactive Dashboard (Local Demo)
When you run the application locally, you'll see a beautiful interactive dashboard:

![CI/CD Pipeline Demo Dashboard](./images/dashboard-screenshot.png)

**Features of the Dashboard:**
- ✅ **Real-time health monitoring** - Check application status
- ✅ **System resource display** - Memory, platform, Node.js version
- ✅ **Interactive API testing** - Test all endpoints with buttons
- ✅ **CI/CD pipeline visualization** - Shows the complete workflow
- ✅ **Professional UI/UX** - Modern design with animations
- ✅ **Responsive design** - Works on all devices

### Dashboard Components:
1. **Application Health Card** - Real-time health checks
2. **System Status Card** - Performance monitoring
3. **Application Info Card** - Feature showcase
4. **CI/CD Features List** - Pipeline capabilities

**Perfect for demonstrating to invigilators!** 🎨✨

## 🔧 Key Features

### ✅ **Runner-Only Approach**
- No local Node.js installation needed
- No local Docker installation needed
- Everything runs in GitHub Actions runners
- Cross-platform compatibility

### ✅ **Security First**
- Multi-stage Docker builds
- Non-root container user
- Automated vulnerability scanning
- Security headers with Helmet

### ✅ **Automated Testing**
- Comprehensive test suite
- Health check validation
- API endpoint testing
- Error handling verification

### ✅ **Production Ready**
- Optimized Docker images
- Health checks and monitoring
- Proper logging and error handling
- Scalable architecture

## 📊 Monitoring

### GitHub Actions Dashboard
- Real-time pipeline execution
- Detailed logs for each job
- Success/failure tracking
- Performance metrics

### Application Health
- Health check endpoint: `/health`
- System status endpoint: `/api/status`
- Memory and performance monitoring

## 🎓 Learning Outcomes

By completing this task, you will understand:
- **CI/CD Pipeline Design**: Complete automation workflow
- **GitHub Actions**: Cloud-based CI/CD execution
- **Docker Containerization**: Multi-stage builds and optimization
- **Security Best Practices**: Vulnerability scanning and hardening
- **DevOps Automation**: End-to-end deployment pipeline
- **Modern Web Development**: Node.js, Express, and testing

## 🎯 Demonstration Guide for Invigilator

### How to Show Your CI/CD Pipeline:

1. **Start the Application Locally:**
   ```bash
   cd task-1
   docker-compose up
   ```

2. **Open the Dashboard:**
   - Visit: `http://localhost` (port 80 via nginx)
   - Or: `http://localhost:3000` (direct to app)

3. **Demonstrate Features:**
   - **Click "Check Health"** - Shows real-time application status
   - **Click "Check Status"** - Displays system resources
   - **Click "Get Info"** - Shows application features
   - **Point to CI/CD Pipeline** - Explain the visual workflow

4. **Show GitHub Actions:**
   - Go to: https://github.com/Tohidhanfi/Elevate-labs/actions
   - Show the automated pipeline execution

5. **Show DockerHub:**
   - Go to: https://hub.docker.com/r/tohidazure/elevate-labs-task1
   - Show the deployed Docker image

### What the Invigilator Will See:
- ✅ **Beautiful interactive dashboard** with animations
- ✅ **Real-time API testing** with live results
- ✅ **Professional CI/CD pipeline** visualization
- ✅ **Complete automation** from code to deployment
- ✅ **Modern web development** practices

## 🚀 Next Steps

After mastering this pipeline, you can:
1. **Add Database Integration** (MongoDB, PostgreSQL)
2. **Implement Frontend** (React, Vue.js)
3. **Add Monitoring** (Prometheus, Grafana)
4. **Enhance Security** (OAuth, JWT)
5. **Scale Infrastructure** (Kubernetes, AWS)

---

**🎯 Mission Accomplished**: Complete CI/CD pipeline running entirely in GitHub Actions runners! 