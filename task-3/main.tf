terraform {
  required_version = ">= 1.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Configure Docker provider
provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

# Create a Docker network for our containers
resource "docker_network" "task3_network" {
  name   = var.network_name
  driver = "bridge"
}

# Create a Docker volume for persistent data
resource "docker_volume" "task3_volume" {
  name = var.volume_name
}

# Create a simple web application container
resource "docker_container" "web_app" {
  name  = var.web_app_name
  image = docker_image.web_app.image_id
  
  networks_advanced {
    name = docker_network.task3_network.name
  }
  
  volumes {
    volume_name    = docker_volume.task3_volume.name
    container_path = "/app/data"
  }
  
  ports {
    internal = var.web_app_internal_port
    external = var.web_app_port
  }
  
  env = [
    "NODE_ENV=production",
    "PORT=${var.web_app_internal_port}"
  ]
  
  restart = "unless-stopped"
  
  # Health check
  healthcheck {
    test         = ["CMD", "curl", "-f", "http://localhost:${var.web_app_internal_port}/health"]
    interval     = "30s"
    timeout      = "10s"
    retries      = 3
    start_period = "40s"
  }
}

# Build custom nginx image for Task 3
resource "docker_image" "web_app" {
  name = "task3-custom-nginx:latest"
  build {
    context = "${path.module}/custom-nginx"
    dockerfile = "Dockerfile"
  }
}

# Create a database container (example)
resource "docker_container" "database" {
  name  = var.database_name
  image = docker_image.database.image_id
  
  networks_advanced {
    name = docker_network.task3_network.name
  }
  
  volumes {
    volume_name    = docker_volume.task3_volume.name
    container_path = "/var/lib/mysql"
  }
  
  env = [
    "MYSQL_ROOT_PASSWORD=${var.db_root_password}",
    "MYSQL_DATABASE=${var.db_name}",
    "MYSQL_USER=${var.db_user}",
    "MYSQL_PASSWORD=${var.db_password}"
  ]
  
  restart = "unless-stopped"
  
  # Health check for database
  healthcheck {
    test         = ["CMD", "mysqladmin", "ping", "-h", "localhost"]
    interval     = "30s"
    timeout      = "10s"
    retries      = 3
    start_period = "40s"
  }
}

# Pull the database image
resource "docker_image" "database" {
  name = var.database_image
} 