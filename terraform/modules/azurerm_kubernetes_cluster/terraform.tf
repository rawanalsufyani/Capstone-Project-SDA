resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  node_resource_group = var.node_resource_group_name

  default_node_pool {
    name       = var.default_node_pool_name
    node_count = var.node_count
    vm_size    = var.vm_size
   type       = "VirtualMachineScaleSets"
    vnet_subnet_id = var.vnet_subnet_id
    temporary_name_for_rotation = "temprotate"

  }
  network_profile {
  network_plugin = "azure"
  service_cidr   = "10.240.0.0/16"   # <-- changed to non-overlapping range
  dns_service_ip = "10.240.0.10"     # <-- must be within service_cidr
  outbound_type  = "loadBalancer"
}

  identity {
    type = var.identity_type
  }

  # Lifecycle rule to ignore changes to key_vault_secrets_provider
  # This prevents Terraform from trying to remove the add-on when it's managed outside Terraform
  lifecycle {
    ignore_changes = [
      key_vault_secrets_provider,
      default_node_pool[0].upgrade_settings
    ]
  }
}
