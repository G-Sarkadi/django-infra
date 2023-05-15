# Application variables
variable "app_name" {
  description = "Application name"
  type        = string
  default     = "django-images"
}

variable "python_version" {
  description = "Python version number"
  type        = number
  default     = 3.11
}

variable "service_plan_os" {
  description = "Operating system for the service plan"
  type        = string
  default     = "Linux"
}

variable "service_plan_sku" {
  description = "SKU name for the service plan"
  type        = string
  default     = "B1"
}

variable "app_repo" {
  description = "The public GitHub URL for the application repository"
  type        = string
  default     = "https://github.com/G-Sarkadi/django-image-app"
}

variable "app_branch" {
  description = "The branch of the application repository"
  type        = string
  default     = "main"
}

variable "location" {
  description = "Azure region to deploy the application"
  type        = string
  default     = "West Europe"
}

variable "SECRET_KEY" {
  description = "Secret key for the application"
  type        = string
  sensitive   = true
}

# PostgreSQL server and database variables
variable "postgresql_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "12"
}

variable "postgresql_db_size" {
  description = "Size of PostgreSQL server"
  type        = number
  default     = 32768
}

variable "postgresql_sku" {
  description = "SKU name for the PostgreSQL server"
  type        = string
  default     = "GP_Standard_D4s_v3"
}

variable "DB_ADMIN_USER" {
  description = "PostgreSQL database admin user name"
  type        = string
  sensitive   = true
}

variable "DB_ADMIN_PASSWORD" {
  description = "PostgreSQL database admin password"
  type        = string
  sensitive   = true
}

variable "DB_NAME" {
  description = "PostgreSQL database name"
  type        = string
  default     = "django-images"
}

# Data storage variables
variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "djangostorageaccountname"
}

variable "storage_account_tier" {
  description = "Tier of the storage account"
  type        = string
  default     = "Standard"
}

variable "storage_account_type" {
  description = "Type of replication for the storage account"
  type        = string
  default     = "GRS"
}

variable "container_access_type" {
  description = "The access level of the container"
  type        = string
  default     = "blob"
}
