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
docker pull your-username/your-repo:latest

# Run the application
docker run -p 3000:3000 your-username/your-repo:latest
```

### Available Endpoints:
- `GET /` - **Beautiful interactive dashboard** 🎨
- `GET /api` - Welcome message and app info
- `GET /health` - Health check status
- `GET /api/info` - Application information
- `GET /api/status` - System status

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

## 🚀 Next Steps

After mastering this pipeline, you can:
1. **Add Database Integration** (MongoDB, PostgreSQL)
2. **Implement Frontend** (React, Vue.js)
3. **Add Monitoring** (Prometheus, Grafana)
4. **Enhance Security** (OAuth, JWT)
5. **Scale Infrastructure** (Kubernetes, AWS)

---

**🎯 Mission Accomplished**: Complete CI/CD pipeline running entirely in GitHub Actions runners! 