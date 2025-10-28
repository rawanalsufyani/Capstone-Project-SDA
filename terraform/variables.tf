variable "prefix" {}
variable "rg_name" {}
variable "location" {}

variable "vnet_cidr" {}
variable "appgw_subnet_cidr" {}
variable "aks_subnet_cidr" {}
variable "data_pe_subnet_cidr" {}

variable "db_name" {}
variable "sql_admin_login" {}
variable "sql_admin_password" {
  type = string
  sensitive = true
}

variable "node_count" { default = 2 }
variable "vm_size" { default = "Standard_DS2_v2" }
variable "service_cidr" { default = "10.2.0.0/16" }
variable "dns_service_ip" { default = "10.2.0.10" }
variable "subscription_id" {type = string}

variable "user_node_pool_name" {type = string}


variable "ingress_name"{type =string}
variable "min_autoscaler" {type = number}
variable "max_autoscaler" {type = number}

#variable "client_id" {
  #type        = string
  #description = "Client ID of the Service Principal used by CI/CD"
#}

#variable "client_secret" {
 # type        = string
  #description = "Client Secret of the Service Principal used by CI/CD"
  #sensitive   = true
#}

#variable "tenant_id" {
 # type        = string
#  description = "Tenant ID of the Service Principal"
#}


variable "dockerhub_username" {
  type        = string
}
variable "dockerhub_token" {
  type        = string
}

variable "ingress_dns_label" {
  description = "The DNS label for the Ingress Public IP. Optional, defaults to prefix-ingress."
  type        = string
  default     = null 
}