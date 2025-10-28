output "ingress_id"{
    value=azurerm_public_ip.ingress_ip.id
}
output "ingress_ip" {
    value = azurerm_public_ip.ingress_ip.ip_address
}

output "ingress_fqdn" {
    value = azurerm_public_ip.ingress_ip.fqdn 
}