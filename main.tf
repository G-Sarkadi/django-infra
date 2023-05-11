resource "azurerm_service_plan" "service_plan" {
  name                = "service_plan"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "django_images_test" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_service_plan.service_plan.location
  service_plan_id     = azurerm_service_plan.service_plan.id
  https_only          = true

  site_config {
    application_stack {
      python_version = 3.11
    }
  }

  # Add environmetal variables to the application
  app_settings = {
    "DBNAME"               = ""
    "DBHOST"               = ""
    "DBUSER"               = ""
    "DBPASS"               = ""
    "DEBUG"                = 1
    "SECRET_KEY"           = var.SECRET_KEY
    "ALLOWED_HOSTS"        = "localhost 127.0.0.1 [::1] ${var.app_name}.azurewebsites.net"
    "CSRF_TRUSTED_ORIGINS" = "https://${var.app_name}.azurewebsites.net}"
    "SECURE_SSL_REDIRECT"  = 0
    "AZURE_ACCOUNT_NAME"   = ""
    "AZURE_ACCOUNT_KEY"    = ""
  }

  storage_account {
    account_name = azurerm_storage_account.this.name
    access_key   = azurerm_storage_account.this.primary_access_key
    name         = "hello"
    share_name   = "static"
    type         = "AzureBlob"
  }
}

resource "azurerm_app_service_source_control" "example" {
  app_id   = azurerm_linux_web_app.django_images_test.id
  repo_url = "https://github.com/G-Sarkadi/django-test"
  branch   = "main"
}
