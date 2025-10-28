terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.46.0"
    }
  }
   backend "azurerm" {
    resource_group_name  = "team5-state-storage"
    storage_account_name = "storageaccjudeb4da5f92bc"
    container_name       = "terraformstate725f72d5cb"
    key                  = "terraform.tfstate"

} 

}
provider "azurerm" {
  features {
         resource_group {
       prevent_deletion_if_contains_resources = false
     }
  }

  subscription_id = var.subscription_id
}