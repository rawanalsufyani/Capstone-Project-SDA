variable "prefix"        { type = string }
variable "rg_name"       { type = string }
variable "location"      { type = string }

variable "pe_subnet_id"          { type = string }  # من network module
variable "kv_private_dns_zone_id"{ type = string }  # من network module

variable "sql_admin_login"    { type = string }
variable "sql_admin_password" { 
  type = string 
   sensitive = true
   }
variable "sql_server_fqdn"    { type = string }
variable "db_name"            { type = string }
