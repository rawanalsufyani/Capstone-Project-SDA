data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                         = "${var.prefix}-kv"
  location                     = var.location
  resource_group_name          = var.rg_name
  tenant_id                    = data.azurerm_client_config.current.tenant_id
  sku_name                     = "standard"
  enable_rbac_authorization  = false
  purge_protection_enabled    = true
  public_network_access_enabled = true 

  access_policy {
    object_id = data.azurerm_client_config.current.object_id
    tenant_id = data.azurerm_client_config.current.tenant_id

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"
    ]
  }
   network_acls {
    bypass                    = "AzureServices"         
    default_action            = "Deny"                
    virtual_network_subnet_ids = [var.aks_subnet_id]    
    
  }

}


# Service Principal (CI/CD) Credentials  


resource "azurerm_key_vault_secret" "client_id" {
  name         = "ci-client-id"
  value        = var.client_id
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "client_secret" {
  name         = "ci-client-secret"
  value        = var.client_secret
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "tenant_id" {
  name         = "ci-tenant-id"
  value        = var.tenant_id
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "subscription_id" {
  name         = "ci-subscription-id"
  value        = var.subscription_id
  key_vault_id = azurerm_key_vault.kv.id
}

# sql secret
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

# docker hub secret
resource "azurerm_key_vault_secret" "dockerhub_username" {
  name         = "dockerhub-username"
  value        = var.dockerhub_username
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "dockerhub_token" {
  name         = "dockerhub-token"
  value        = var.dockerhub_token
  key_vault_id = azurerm_key_vault.kv.id
}
