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
  
