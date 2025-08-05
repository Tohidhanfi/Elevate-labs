#!/bin/bash

# Task 2: Jenkins CI/CD Pipeline Setup Script
# This script sets up Jenkins with Docker integration for the Elevate Labs project

set -e

echo "🚀 Setting up Jenkins CI/CD Pipeline for Elevate Labs..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is installed
check_docker() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! docker info &> /dev/null; then
        print_error "Docker daemon is not running. Please start Docker."
        exit 1
    fi
    
    print_status "Docker is installed and running"
}

# Check if Docker Compose is installed
check_docker_compose() {
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    
    print_status "Docker Compose is installed"
}

# Start Jenkins using Docker Compose
start_jenkins() {
    print_status "Starting Jenkins with Docker Compose..."
    
    # Create webhook nginx config if it doesn't exist
    if [ ! -f "webhook-nginx.conf" ]; then
        cat > webhook-nginx.conf << 'EOF'
events {
    worker_connections 1024;
}

http {
    server {
        listen 80;
        server_name localhost;
        
        location / {
            return 200 "Webhook Server Running\n";
            add_header Content-Type text/plain;
        }
        
        location /health {
            return 200 "OK\n";
            add_header Content-Type text/plain;
        }
    }
}
EOF
    fi
    
    # Start services
    docker-compose up -d
    
    print_status "Jenkins is starting up..."
    print_status "Please wait a moment for Jenkins to initialize..."
    
    # Wait for Jenkins to be ready
    echo "Waiting for Jenkins to be ready..."
    while ! curl -s http://localhost:8080 > /dev/null; do
        sleep 5
        echo -n "."
    done
    echo ""
    
    print_status "Jenkins is now running at http://localhost:8080"
}

# Get Jenkins initial admin password
get_admin_password() {
    print_status "Getting Jenkins initial admin password..."
    
    # Wait a bit more for Jenkins to fully initialize
    sleep 10
    
    # Try to get password from container
    PASSWORD=$(docker exec jenkins-server cat /var/jenkins_home/secrets/initialAdminPassword 2>/dev/null || echo "Password not available yet")
    
    if [ "$PASSWORD" != "Password not available yet" ]; then
        print_status "Jenkins initial admin password: $PASSWORD"
        echo ""
        print_warning "Please save this password - you'll need it for initial setup!"
    else
        print_warning "Password not available yet. Please check Jenkins logs or wait a moment and run:"
        echo "docker exec jenkins-server cat /var/jenkins_home/secrets/initialAdminPassword"
    fi
}

# Display setup instructions
show_instructions() {
    echo ""
    echo "=========================================="
    echo "🎉 Jenkins Setup Complete!"
    echo "=========================================="
    echo ""
    echo "📋 Next Steps:"
    echo "1. Open http://localhost:8080 in your browser"
    echo "2. Enter the admin password shown above"
    echo "3. Install suggested plugins"
    echo "4. Create an admin user"
    echo "5. Install additional plugins:"
    echo "   - Docker Pipeline"
    echo "   - Git Integration"
    echo "   - Pipeline Utility Steps"
    echo ""
    echo "🔧 Pipeline Configuration:"
    echo "1. Create new Pipeline job named 'Elevate-Labs-CI-CD'"
    echo "2. Configure Pipeline script from SCM"
    echo "3. Set repository URL: https://github.com/Tohidhanfi/Elevate-labs.git"
    echo "4. Set script path: task-2/Jenkinsfile"
    echo "5. Configure triggers for automatic builds"
    echo ""
    echo "🐳 Docker Integration:"
    echo "- Jenkins container has access to Docker socket"
    echo "- Can build and run Docker containers"
    echo "- Pipeline will use Docker for builds and deployments"
    echo ""
    echo "📚 Documentation:"
    echo "- See task-2/README.md for detailed instructions"
    echo "- Jenkinsfile contains the complete CI/CD pipeline"
    echo ""
    echo "🛠️ Useful Commands:"
    echo "- View logs: docker-compose logs jenkins"
    echo "- Stop services: docker-compose down"
    echo "- Restart services: docker-compose restart"
    echo "- Update Jenkins: docker-compose pull && docker-compose up -d"
    echo ""
}

# Main execution
main() {
    echo "=========================================="
    echo "🔧 Jenkins CI/CD Pipeline Setup"
    echo "=========================================="
    echo ""
    
    # Check prerequisites
    check_docker
    check_docker_compose
    
    # Start Jenkins
    start_jenkins
    
    # Get admin password
    get_admin_password
    
    # Show instructions
    show_instructions
}

# Run main function
main "$@" 