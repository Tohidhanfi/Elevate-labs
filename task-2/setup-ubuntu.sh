#!/bin/bash

# Ubuntu Jenkins CI/CD Setup Script
# Native installation on host level with JDK 17

set -e

echo "🚀 Setting up Jenkins CI/CD Pipeline on Ubuntu (Native Installation)..."

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Update system
print_status "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install JDK 17
print_status "Installing OpenJDK 17..."
sudo apt install -y openjdk-17-jdk

# Verify Java installation
print_status "Verifying Java installation..."
java -version

# Install Docker
print_status "Installing Docker..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add user to docker group
sudo usermod -aG docker $USER

# Install Docker Compose
print_status "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Jenkins
print_status "Installing Jenkins..."
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install -y jenkins

# Add jenkins user to docker group
sudo usermod -aG docker jenkins

# Start Jenkins
print_status "Starting Jenkins..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Wait for Jenkins to start
print_status "Waiting for Jenkins to start..."
sleep 30

# Get Jenkins admin password
PASSWORD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

# Get server IP
SERVER_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "=========================================="
echo "🎉 Jenkins Setup Complete!"
echo "=========================================="
echo ""
echo "📋 Access Information:"
echo "Jenkins URL: http://$SERVER_IP:8080"
echo "Admin Password: $PASSWORD"
echo ""
echo "📋 Next Steps:"
echo "1. Open Jenkins in browser: http://$SERVER_IP:8080"
echo "2. Enter admin password: $PASSWORD"
echo "3. Install suggested plugins"
echo "4. Create admin user"
echo "5. Install additional plugins:"
echo "   - Docker Pipeline"
echo "   - Git Integration"
echo "6. Create pipeline job:"
echo "   - Name: Elevate-Labs-CI-CD"
echo "   - Type: Pipeline"
echo "   - Script: Copy from Jenkinsfile"
echo ""
echo "🔧 Pipeline Configuration:"
echo "- Repository: https://github.com/Tohidhanfi/Elevate-labs.git"
echo "- Script Path: task-2/Jenkinsfile"
echo ""
echo "🛠️ Useful Commands:"
echo "- Check Jenkins status: sudo systemctl status jenkins"
echo "- View Jenkins logs: sudo tail -f /var/log/jenkins/jenkins.log"
echo "- Restart Jenkins: sudo systemctl restart jenkins"
echo "- Check Docker: docker --version"
echo "- Check Java: java -version"
echo ""
echo "==========================================" 