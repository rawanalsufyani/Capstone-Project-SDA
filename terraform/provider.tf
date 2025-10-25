terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.1.0"
    }
  }
   backend "azurerm" {
    # resource_group_name  = "devops-project3-storageaccount"
    # storage_account_name = "devopsweekstorage1006"
    # container_name       = "terraformstate"
    # key                  = "terraform.tfstate"
    //will be known after creation
}
}
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}