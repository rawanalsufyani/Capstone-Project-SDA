resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks-cluster"
  location            = var.rg_location
  resource_group_name = var.rg_name
  dns_prefix          = "${var.prefix}-dns"
  node_resource_group = "${var.prefix}-aks-node"

  default_node_pool {
    name       = var.default_node_pool_name
    type =  VirtualMachineScaleSets
    node_count = var.aks_node_count
    vm_size    = var.vm_size
    vnet_subnet_id = var.aks_subnet_id
    auto_scaling_enabled = true
    min_count = var.min_autoscaler
    max_count =var.max_autoscaler
  }
  network_profile {
    network_plugin = "azure"
    service_cidr = var.service_cidr
    dns_service_ip = var.dns_service_ip
  }

  identity {
    type = "SystemAssigned"
  }
    depends_on = [ azurerm_role_assignment.aks_ACR, azurerm_role_assignment.aks_disk_contributor]
}
resource "azurerm_kubernetes_cluster_node_pool" "user_node_pool" {
  name                  = var.user_node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.vm_size
  node_count            = var.aks_node_count
  auto_scaling_enabled = true
  min_count = var.min_autoscaler
  max_count =var.max_autoscaler
  vnet_subnet_id = var.aks_subnet_id
  tags = {
    Environment = "Production"
  }
}

resource "azurerm_role_assignment" "aks_disk_contributor" {
  scope                = var.rg_name
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.id
}

# resource "azurerm_role_assignment" "aks_ACR" {
#   scope                = azurerm_resource_group.rg.id
#   role_definition_name = "Contributor"
#   principal_id         = azurerm_kubernetes_cluster.aks.id
# }


# #for sql
# resource "azurerm_private_dns_zone" "example" {
#   name                = "privatelink.eastus2.azmk8s.io"
#   resource_group_name = var.resource_group_name
# }