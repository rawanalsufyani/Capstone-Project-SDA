resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  resource_group_name = var.rg_name
  location            = var.location
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.aks_subnet_cidr]
}
#  we used only one subnet for private endpoint to (SQL, Key Vault)
resource "azurerm_subnet" "data_pe_subnet" {
  name                 = "data-pe-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.data_pe_subnet_cidr]
}

# SQL zone
resource "azurerm_private_dns_zone" "sql_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.rg_name
}
resource "azurerm_private_dns_zone_virtual_network_link" "sql_vnet_link" {
  name                  = "${var.prefix}-sql-dnslink"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.sql_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# Key Vault zone
resource "azurerm_private_dns_zone" "kv_zone" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.rg_name
}
resource "azurerm_private_dns_zone_virtual_network_link" "kv_vnet_link" {
  name                  = "${var.prefix}-kv-dnslink"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.kv_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}
