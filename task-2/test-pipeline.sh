#!/bin/bash

# Test script for Jenkins Pipeline
# This script validates the pipeline configuration and tests basic functionality

set -e

echo "🧪 Testing Jenkins Pipeline Configuration..."

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

print_error() {
    echo -e "${RED}[FAIL]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

# Test 1: Check if Jenkinsfile exists
test_jenkinsfile() {
    if [ -f "Jenkinsfile" ]; then
        print_status "Jenkinsfile exists"
    else
        print_error "Jenkinsfile not found"
        return 1
    fi
}

# Test 2: Validate Jenkinsfile syntax
test_jenkinsfile_syntax() {
    if grep -q "pipeline" Jenkinsfile; then
        print_status "Jenkinsfile has valid pipeline structure"
    else
        print_error "Jenkinsfile missing pipeline declaration"
        return 1
    fi
    
    if grep -q "stages" Jenkinsfile; then
        print_status "Jenkinsfile has stages defined"
    else
        print_error "Jenkinsfile missing stages"
        return 1
    fi
}

# Test 3: Check required stages
test_pipeline_stages() {
    local required_stages=("Checkout" "Build" "Test" "Deploy" "Cleanup")
    local missing_stages=()
    
    for stage in "${required_stages[@]}"; do
        if grep -q "stage('$stage')" Jenkinsfile; then
            print_status "Stage '$stage' found"
        else
            missing_stages+=("$stage")
        fi
    done
    
    if [ ${#missing_stages[@]} -eq 0 ]; then
        print_status "All required stages present"
    else
        print_error "Missing stages: ${missing_stages[*]}"
        return 1
    fi
}

# Test 4: Check Docker integration
test_docker_integration() {
    if grep -q "docker build" Jenkinsfile; then
        print_status "Docker build command found"
    else
        print_error "Docker build command missing"
        return 1
    fi
    
    if grep -q "docker run" Jenkinsfile; then
        print_status "Docker run command found"
    else
        print_error "Docker run command missing"
        return 1
    fi
}

# Test 5: Check environment variables
test_environment_vars() {
    local required_vars=("DOCKER_IMAGE" "DOCKER_TAG" "CONTAINER_NAME")
    local missing_vars=()
    
    for var in "${required_vars[@]}"; do
        if grep -q "$var" Jenkinsfile; then
            print_status "Environment variable '$var' defined"
        else
            missing_vars+=("$var")
        fi
    done
    
    if [ ${#missing_vars[@]} -eq 0 ]; then
        print_status "All required environment variables present"
    else
        print_error "Missing environment variables: ${missing_vars[*]}"
        return 1
    fi
}

# Test 6: Check Docker Compose configuration
test_docker_compose() {
    if [ -f "docker-compose.yml" ]; then
        print_status "Docker Compose file exists"
    else
        print_error "Docker Compose file not found"
        return 1
    fi
    
    if grep -q "jenkins/jenkins:lts" docker-compose.yml; then
        print_status "Jenkins LTS image configured"
    else
        print_error "Jenkins image not configured"
        return 1
    fi
    
    if grep -q "8080:8080" docker-compose.yml; then
        print_status "Jenkins port mapping configured"
    else
        print_error "Jenkins port mapping missing"
        return 1
    fi
}

# Test 7: Check if Task 1 application exists
test_task1_integration() {
    if [ -d "../task-1" ]; then
        print_status "Task 1 directory exists"
    else
        print_error "Task 1 directory not found"
        return 1
    fi
    
    if [ -f "../task-1/Dockerfile" ]; then
        print_status "Task 1 Dockerfile exists"
    else
        print_error "Task 1 Dockerfile not found"
        return 1
    fi
    
    if [ -f "../task-1/src/package.json" ]; then
        print_status "Task 1 package.json exists"
    else
        print_error "Task 1 package.json not found"
        return 1
    fi
}

# Test 8: Validate README documentation
test_documentation() {
    if [ -f "README.md" ]; then
        print_status "README.md exists"
    else
        print_error "README.md not found"
        return 1
    fi
    
    if [ -f "QUICK_START.md" ]; then
        print_status "QUICK_START.md exists"
    else
        print_error "QUICK_START.md not found"
        return 1
    fi
}

# Run all tests
run_tests() {
    local tests=(
        "test_jenkinsfile"
        "test_jenkinsfile_syntax"
        "test_pipeline_stages"
        "test_docker_integration"
        "test_environment_vars"
        "test_docker_compose"
        "test_task1_integration"
        "test_documentation"
    )
    
    local passed=0
    local failed=0
    
    echo ""
    echo "Running pipeline tests..."
    echo "=========================="
    
    for test in "${tests[@]}"; do
        if $test; then
            ((passed++))
        else
            ((failed++))
        fi
    done
    
    echo ""
    echo "=========================="
    echo "Test Results:"
    echo "Passed: $passed"
    echo "Failed: $failed"
    echo "=========================="
    
    if [ $failed -eq 0 ]; then
        echo ""
        print_status "All tests passed! Pipeline is ready for deployment."
        echo ""
        echo "Next steps:"
        echo "1. Start Jenkins: docker-compose up -d"
        echo "2. Access Jenkins: http://localhost:8080"
        echo "3. Configure pipeline job"
        echo "4. Run the pipeline!"
    else
        echo ""
        print_error "Some tests failed. Please fix the issues before proceeding."
        exit 1
    fi
}

# Main execution
main() {
    echo "=========================================="
    echo "🧪 Jenkins Pipeline Test Suite"
    echo "=========================================="
    
    run_tests
}

# Run main function
main "$@" 