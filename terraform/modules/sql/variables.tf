variable "prefix" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "db_name" {
  type = string
}

variable "sql_admin_login" {
  type = string
}

variable "sql_admin_password" {
  type      = string
  sensitive = true
}

variable "data_pe_subnet_id" {
  type = string
}

variable "sql_private_dns_zone_id" {
  type = string
}
variable "vnet_id"  {   type = string}