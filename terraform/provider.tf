terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.1.0"
    }
  }
  # backend "azurerm" {
   #  resource_group_name  = "tfstate-rg-team5"
    # storage_account_name = "tfstateteam5"
    #container_name       = "tfstate"
     #key                  = "terraform.tfstate"
    //will be known after creation
#}
}
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}