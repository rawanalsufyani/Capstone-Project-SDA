# 1) SQL Server
resource "azurerm_mssql_server" "sql_server" {
  name                          = "${var.prefix}-sqlserver"
  resource_group_name           = var.rg_name
  location                      = var.location
  version                       = "12.0"
  administrator_login           = var.sql_admin_login
  administrator_login_password  = var.sql_admin_password
  public_network_access_enabled = false
  minimum_tls_version           = "1.2"
}

# 2) SQL Database
resource "azurerm_mssql_database" "sql_db" {
  name                = var.db_name
  server_id           = azurerm_mssql_server.sql_server.id
  sku_name            = "Basic"
  storage_account_type = "Zone"
  max_size_gb         = 2
}

# 3) Private Endpoint
resource "azurerm_private_endpoint" "sql_pe" {
  name                = "${var.prefix}-sql-pe"
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.data_pe_subnet_id

  private_service_connection {
    name                           = "sql-psc"
    private_connection_resource_id = azurerm_mssql_server.sql_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
}


resource "azurerm_private_dns_zone" "sql_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.rg_name
}


resource "azurerm_private_dns_zone_virtual_network_link" "sql_link" {
  name                  = "${var.prefix}-sql-vnet-link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.sql_zone.name
  virtual_network_id    = var.vnet_id 
}
