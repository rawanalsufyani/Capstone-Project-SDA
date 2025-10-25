output "vnet_id"            { value = azurerm_virtual_network.vnet.id }
output "aks_subnet_id"      { value = azurerm_subnet.aks_subnet.id }
output "data_pe_subnet_id"  { value = azurerm_subnet.data_pe_subnet.id } 
output "sql_private_dns_zone_id" { value = azurerm_private_dns_zone.sql_zone.id }
output "kv_private_dns_zone_id"  { value = azurerm_private_dns_zone.kv_zone.id }

