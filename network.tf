resource "azurerm_virtual_network" "example" {
  name                = "example-vn"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "example" {
  name                 = "example-sn"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}
resource "azurerm_private_dns_zone" "example" {
  name                = "example.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "exampleVnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = azurerm_virtual_network.example.id
  resource_group_name   = azurerm_resource_group.this.name
}

resource "azurerm_app_service_connection" "example" {
  name               = "example_serviceconnector"
  app_service_id     = azurerm_linux_web_app.django_images_test.id
  target_resource_id = azurerm_postgresql_flexible_server_database.django_db.id
  client_type        = "python"
  authentication {
    type   = "secret"
    name   = var.DB_ADMIN_USER
    secret = var.DB_ADMIN_PASSWORD
  }
}

