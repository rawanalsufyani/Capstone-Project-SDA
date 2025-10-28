resource "azurerm_public_ip" "ingress_ip" {
    name =var.ingress_name
    resource_group_name = var.rg_name
    location = var.rg_location
    allocation_method = var.allocation_method
    sku = var.sku
  
}