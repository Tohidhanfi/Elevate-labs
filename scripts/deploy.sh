#!/bin/bash

# DevOps Git Project Deployment Script
# This script handles deployment of the application

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="devops-git-project"
DEPLOYMENT_ENV=${DEPLOYMENT_ENV:-"production"}
PORT=${PORT:-3000}

# Logging function
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    log "Checking prerequisites..."
    
    # Check if Node.js is installed
    if ! command -v node &> /dev/null; then
        error "Node.js is not installed"
    fi
    
    # Check if npm is installed
    if ! command -v npm &> /dev/null; then
        error "npm is not installed"
    fi
    
    # Check if Git is installed
    if ! command -v git &> /dev/null; then
        error "Git is not installed"
    fi
    
    success "Prerequisites check passed"
}

# Get Git information
get_git_info() {
    log "Getting Git information..."
    
    if [ -d ".git" ]; then
        BRANCH=$(git rev-parse --abbrev-ref HEAD)
        COMMIT=$(git rev-parse HEAD | cut -c1-8)
        AUTHOR=$(git log -1 --pretty=format:"%an")
        DATE=$(git log -1 --pretty=format:"%ad" --date=short)
        
        log "Branch: $BRANCH"
        log "Commit: $COMMIT"
        log "Author: $AUTHOR"
        log "Date: $DATE"
    else
        warning "Not a Git repository"
    fi
}

# Install dependencies
install_dependencies() {
    log "Installing dependencies..."
    
    if [ -f "src/package.json" ]; then
        cd src
        npm ci --production=false
        cd ..
        success "Dependencies installed successfully"
    else
        error "package.json not found in src directory"
    fi
}

# Run tests
run_tests() {
    log "Running tests..."
    
    if [ -f "src/package.json" ]; then
        cd src
        npm test
        cd ..
        success "Tests passed"
    else
        warning "No tests found"
    fi
}

# Build application
build_application() {
    log "Building application..."
    
    # Create build directory
    mkdir -p build
    
    # Copy source files
    cp -r src/* build/
    
    # Copy documentation
    cp -r docs build/
    cp README.md build/
    cp .gitignore build/
    
    success "Application built successfully"
}

# Start application
start_application() {
    log "Starting application..."
    
    cd src
    
    # Set environment variables
    export NODE_ENV=$DEPLOYMENT_ENV
    export PORT=$PORT
    
    # Start the application
    nohup npm start > ../logs/app.log 2>&1 &
    APP_PID=$!
    
    # Save PID to file
    echo $APP_PID > ../logs/app.pid
    
    # Wait a moment for app to start
    sleep 3
    
    # Check if app is running
    if kill -0 $APP_PID 2>/dev/null; then
        success "Application started successfully (PID: $APP_PID)"
        log "Application is running on port $PORT"
        log "Logs available at: logs/app.log"
    else
        error "Failed to start application"
    fi
    
    cd ..
}

# Stop application
stop_application() {
    log "Stopping application..."
    
    if [ -f "logs/app.pid" ]; then
        PID=$(cat logs/app.pid)
        if kill -0 $PID 2>/dev/null; then
            kill $PID
            rm logs/app.pid
            success "Application stopped successfully"
        else
            warning "Application is not running"
        fi
    else
        warning "No PID file found"
    fi
}

# Check application health
check_health() {
    log "Checking application health..."
    
    # Wait for app to be ready
    sleep 2
    
    # Check if app responds
    if curl -f http://localhost:$PORT/api/health > /dev/null 2>&1; then
        success "Application is healthy"
        log "Health check endpoint: http://localhost:$PORT/api/health"
    else
        error "Application health check failed"
    fi
}

# Create logs directory
create_logs_directory() {
    log "Creating logs directory..."
    mkdir -p logs
    success "Logs directory created"
}

# Cleanup function
cleanup() {
    log "Cleaning up..."
    
    # Remove build directory if it exists
    if [ -d "build" ]; then
        rm -rf build
    fi
    
    success "Cleanup completed"
}

# Show deployment information
show_deployment_info() {
    log "Deployment Information:"
    echo "  Project: $PROJECT_NAME"
    echo "  Environment: $DEPLOYMENT_ENV"
    echo "  Port: $PORT"
    echo "  Node.js: $(node --version)"
    echo "  npm: $(npm --version)"
    echo "  Git: $(git --version)"
}

# Main deployment function
deploy() {
    log "Starting deployment process..."
    
    show_deployment_info
    check_prerequisites
    get_git_info
    create_logs_directory
    install_dependencies
    run_tests
    build_application
    start_application
    check_health
    
    success "Deployment completed successfully!"
    log "Application is now running at: http://localhost:$PORT"
}

# Rollback function
rollback() {
    log "Starting rollback process..."
    
    stop_application
    cleanup
    
    success "Rollback completed successfully!"
}

# Show usage
usage() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  deploy     Deploy the application"
    echo "  stop       Stop the application"
    echo "  restart    Restart the application"
    echo "  status     Check application status"
    echo "  logs       Show application logs"
    echo "  rollback   Rollback the deployment"
    echo "  help       Show this help message"
    echo ""
    echo "Environment variables:"
    echo "  DEPLOYMENT_ENV  Deployment environment (default: production)"
    echo "  PORT            Application port (default: 3000)"
}

# Check application status
check_status() {
    log "Checking application status..."
    
    if [ -f "logs/app.pid" ]; then
        PID=$(cat logs/app.pid)
        if kill -0 $PID 2>/dev/null; then
            success "Application is running (PID: $PID)"
            log "Health check: http://localhost:$PORT/api/health"
        else
            warning "Application is not running (stale PID file)"
        fi
    else
        warning "Application is not running (no PID file)"
    fi
}

# Show logs
show_logs() {
    log "Showing application logs..."
    
    if [ -f "logs/app.log" ]; then
        tail -f logs/app.log
    else
        warning "No log file found"
    fi
}

# Restart application
restart() {
    log "Restarting application..."
    
    stop_application
    sleep 2
    start_application
    check_health
    
    success "Application restarted successfully!"
}

# Main script logic
case "${1:-deploy}" in
    "deploy")
        deploy
        ;;
    "stop")
        stop_application
        ;;
    "restart")
        restart
        ;;
    "status")
        check_status
        ;;
    "logs")
        show_logs
        ;;
    "rollback")
        rollback
        ;;
    "help"|"-h"|"--help")
        usage
        ;;
    *)
        error "Unknown command: $1"
        usage
        exit 1
        ;;
esac 