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


resource "azurerm_private_dns_zone_group" "sql_pe_dns" {
  name                 = "sql-pe-dns-group"
  private_endpoint_id  = azurerm_private_endpoint.sql_pe.id

  private_dns_zone_configs {
    name                  = "sql-zone"
    private_dns_zone_id   = var.sql_private_dns_zone_id
  }
}

