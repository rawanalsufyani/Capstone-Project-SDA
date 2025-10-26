resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks-cluster"
  location            = var.rg_location
  resource_group_name = var.rg_name
  dns_prefix          = "${var.prefix}-dns"
  node_resource_group = "${var.prefix}-aks-node"

  # System (default) node pool
  default_node_pool {
    name                = var.default_node_pool_name
    type                = "VirtualMachineScaleSets"  
    node_count = var.aks_node_count
    vm_size             = var.vm_size
    vnet_subnet_id      = var.aks_subnet_id

    auto_scaling_enabled = true                
    min_count           = var.min_autoscaler
    max_count           = var.max_autoscaler

  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
    outbound_type  = "loadBalancer"               
  }

  identity { type = "SystemAssigned" }

  oidc_issuer_enabled               = true
  workload_identity_enabled         = true
  role_based_access_control_enabled = true

}

# User pool 
resource "azurerm_kubernetes_cluster_node_pool" "user_node_pool" {
  name                  = var.user_node_pool_name   
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  mode                  = "User"                     
  vm_size               = var.vm_size
  vnet_subnet_id        = var.aks_subnet_id

  auto_scaling_enabled = true            
  min_count             = var.min_autoscaler
  max_count             = var.max_autoscaler


  tags = { Environment = "Production" }
}


