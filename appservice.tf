# Resources to create an Azure Web Service

resource "azurerm_service_plan" "service_plan" {
  name                = "service_plan-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = var.service_plan_os
  sku_name            = var.service_plan_sku
}

resource "azurerm_linux_web_app" "django_images" {
  name                = "${var.app_name}-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_service_plan.service_plan.location
  service_plan_id     = azurerm_service_plan.service_plan.id
  https_only          = true

  site_config {
    application_stack {
      python_version = var.python_version
    }
  }

  # Environmetal variables to the application
  app_settings = {
    "DBNAME"                            = var.DB_NAME
    "DBHOST"                            = "${azurerm_postgresql_flexible_server.this.name}.postgres.database.azure.com"
    "DBUSER"                            = var.DB_ADMIN_USER
    "DBPASS"                            = var.DB_ADMIN_PASSWORD
    "AZURE_POSTGRESQL_CONNECTIONSTRING" = "dbname=${var.DB_NAME} host=${azurerm_postgresql_flexible_server.this.name}.postgres.database.azure.com port=5432 sslmode=require user=${var.DB_ADMIN_USER} password=${var.DB_ADMIN_PASSWORD}"
    "DEBUG"                             = 0
    "SECRET_KEY"                        = var.SECRET_KEY
    "ALLOWED_HOSTS"                     = "localhost 127.0.0.1 [::1] ${var.app_name}-${random_integer.ri.result}.azurewebsites.net"
    "CSRF_TRUSTED_ORIGINS"              = "https://${var.app_name}-${random_integer.ri.result}.azurewebsites.net"
    "SECURE_SSL_REDIRECT"               = 0
    "AZURE_ACCOUNT_NAME"                = azurerm_storage_account.this.name
    "AZURE_ACCOUNT_KEY"                 = azurerm_storage_account.this.primary_access_key
  }

  storage_account {
    account_name = azurerm_storage_account.this.name
    access_key   = azurerm_storage_account.this.primary_access_key
    name         = "django-storage-account"
    share_name   = "static"
    type         = "AzureBlob"
  }
}

# Declares the GitHub repo and branch for the application code
resource "azurerm_app_service_source_control" "this" {
  app_id   = azurerm_linux_web_app.django_images.id
  repo_url = var.app_repo
  branch   = var.app_branch
}
