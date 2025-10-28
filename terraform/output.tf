output "ingress_ip" {
  value= module.ingress_ip.ingress_ip
}

output "ingress_ip_id" {
  value = module.ingress_ip.ingress_id
}

output "ingress_fqdn" {
  value = module.ingress_ip.ingress_fqdn 
}