variable "app_name" {
  type    = string
  default = "django-images-test"
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "SECRET_KEY" {
  description = "Secret key for the application"
  type        = string
  sensitive   = true
}
