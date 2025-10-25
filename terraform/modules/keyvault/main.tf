data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                         = "${var.prefix}-kv"
  location                     = var.location
  resource_group_name          = var.rg_name
  tenant_id                    = data.azurerm_client_config.current.tenant_id
  sku_name                     = "standard"

  enable_rbac_authorization     = true
  purge_protection_enabled      = true
  public_network_access_enabled = false
}

resource "azurerm_private_endpoint" "kv_pe" {
  name                = "${var.prefix}-kv-pe"
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.pe_subnet_id   

  private_service_connection {
    name                           = "kv-psc"
    private_connection_resource_id = azurerm_key_vault.kv.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_zone_group" "kv_pe_dns" {
  name                = "kv-pe-dns-group"
  private_endpoint_id = azurerm_private_endpoint.kv_pe.id

  private_dns_zone_configs {
    name                = "kv-zone"
    private_dns_zone_id = var.kv_private_dns_zone_id 
  }
}


resource "azurerm_key_vault_secret" "sql_admin_login" {
  name         = "sql-admin-login"
  value        = var.sql_admin_login
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-password"
  value        = var.sql_admin_password
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "sql_connection_string" {
  name         = "sql-connection-string"
  value        = "Server=tcp:${var.sql_server_fqdn},1433;Database=${var.db_name};User ID=${var.sql_admin_login};Password=${var.sql_admin_password};Encrypt=true;Connection Timeout=30;"
  key_vault_id = azurerm_key_vault.kv.id
}
