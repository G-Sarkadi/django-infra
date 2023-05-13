variable "app_name" {
  description = "Application name"
  type        = string
  default     = "django-images-test"
}

variable "app_repo" {
  description = "The GitHub URL for the application repository"
  type        = string
  default     = "https://github.com/G-Sarkadi/django-image-app"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "West Europe"
}

variable "SECRET_KEY" {
  description = "Secret key for the application"
  type        = string
  sensitive   = true
}

variable "DB_ADMIN_USER" {
  description = "PostgresQL database admin user name"
  type        = string
  sensitive   = true
}

variable "DB_ADMIN_PASSWORD" {
  description = "PostgresQL database admin password"
  type        = string
  sensitive   = true
}

variable "DB_NAME" {
  description = "PostgresQL database name"
  type        = string
  default     = "django-images"
}

variable "python_version" {
  description = "Python version number"
  type        = number
  default     = 3.11
}
