variable "app_name" {
  description = "Application name"
  type        = string
  default     = "django-images-test"
}

variable "app_repo" {
  description = "The GitHub URL for the application repository"
  type        = string
  default     = "https://github.com/G-Sarkadi/django-test"
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
