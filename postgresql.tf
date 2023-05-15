# Resources to create a PostgresQl flexible server and database

resource "azurerm_postgresql_flexible_server" "this" {
  name                   = "${var.app_name}-server-${random_integer.ri.result}"
  resource_group_name    = azurerm_resource_group.this.name
  location               = azurerm_resource_group.this.location
  version                = var.postgresql_version
  delegated_subnet_id    = azurerm_subnet.this.id
  private_dns_zone_id    = azurerm_private_dns_zone.this.id
  administrator_login    = var.DB_ADMIN_USER
  administrator_password = var.DB_ADMIN_PASSWORD

  /*
  This 'zone' attribute comes from the official documentation example
  (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server),
  but it causes an error in the creation of the resource. Leave it undeclared.
  */
  #   zone                   = "1"

  storage_mb = var.postgresql_db_size

  sku_name   = var.postgresql_sku
  depends_on = [azurerm_private_dns_zone_virtual_network_link.this]

}

resource "azurerm_postgresql_flexible_server_database" "django_db" {
  name      = var.DB_NAME
  server_id = azurerm_postgresql_flexible_server.this.id
  collation = "en_US.utf8"
  charset   = "utf8"
}


# resource "azurerm_postgresql_flexible_server_firewall_rule" "example" {
#   name             = "example-fw"
#   server_id        = azurerm_postgresql_flexible_server.this.id
#   start_ip_address = "0.0.0.0"
#   end_ip_address   = "0.0.0.0"
# }
