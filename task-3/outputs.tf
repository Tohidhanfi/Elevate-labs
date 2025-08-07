# Task 3: Outputs for Infrastructure as Code

# Output web application container information
output "web_app_info" {
  description = "Information about the web application container"
  value = {
    name         = docker_container.web_app.name
    ip_address   = docker_container.web_app.network_data[0].ip_address
    external_port = docker_container.web_app.ports[0].external
    image        = docker_image.web_app.name
  }
}

# Output database container information
output "database_info" {
  description = "Information about the database container"
  value = {
    name       = docker_container.database.name
    ip_address = docker_container.database.network_data[0].ip_address
    image      = docker_image.database.name
  }
}

# Output network information
output "network_info" {
  description = "Information about the Docker network"
  value = {
    name   = docker_network.task3_network.name
    driver = docker_network.task3_network.driver
  }
}

# Output volume information
output "volume_info" {
  description = "Information about the Docker volume"
  value = {
    name = docker_volume.task3_volume.name
  }
}

# Output access URLs
output "access_urls" {
  description = "URLs to access the application"
  sensitive = true
  value = {
    web_app_url = "http://localhost:${var.web_app_port}"
    database_url = "mysql://${var.db_user}:${var.db_password}@${docker_container.database.network_data[0].ip_address}:3306/${var.db_name}"
  }
}

# Output infrastructure summary
output "infrastructure_summary" {
  description = "Summary of created infrastructure"
  value = {
    containers_created = 2
    networks_created   = 1
    volumes_created    = 1
    images_used        = [docker_image.web_app.name, docker_image.database.name]
    total_resources    = 5
  }
} 