# Task 3: Variables for Infrastructure as Code

# Container configuration variables
variable "web_app_image" {
  description = "Docker image for the web application"
  type        = string
  default     = "task3-custom-nginx:latest"
}

variable "database_image" {
  description = "Docker image for the database"
  type        = string
  default     = "mysql:8.0"
}

variable "web_app_port" {
  description = "External port for the web application"
  type        = number
  default     = 8080
}

variable "web_app_internal_port" {
  description = "Internal port for the web application"
  type        = number
  default     = 80
}

variable "network_name" {
  description = "Name of the Docker network"
  type        = string
  default     = "task3-network"
}

variable "volume_name" {
  description = "Name of the Docker volume"
  type        = string
  default     = "task3-data"
}

variable "web_app_name" {
  description = "Name of the web application container"
  type        = string
  default     = "task3-web-app"
}

variable "database_name" {
  description = "Name of the database container"
  type        = string
  default     = "task3-database"
}

# Database environment variables
variable "db_root_password" {
  description = "MySQL root password"
  type        = string
  default     = "task3password"
  sensitive   = true
}

variable "db_name" {
  description = "MySQL database name"
  type        = string
  default     = "task3db"
}

variable "db_user" {
  description = "MySQL username"
  type        = string
  default     = "task3user"
}

variable "db_password" {
  description = "MySQL password"
  type        = string
  default     = "task3pass"
  sensitive   = true
} 