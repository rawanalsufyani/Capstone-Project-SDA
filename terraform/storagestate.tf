resource "azurerm_resource_group" "team5_tfstate" {
  name     = "tfstate-rg-team5"
  location = "West US"
}

resource "azurerm_storage_account" "tfstate_acc" {
  name                     = "tfstateftoon"
  resource_group_name      = azurerm_resource_group.team5_tfstate.name
  location                 = azurerm_resource_group.team5_tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate_container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate_acc.name
  container_access_type = "private"
}