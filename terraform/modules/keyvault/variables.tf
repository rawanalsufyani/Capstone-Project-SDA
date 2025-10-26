variable "prefix"        { type = string }
variable "rg_name"       { type = string }
variable "location"      { type = string }



variable "sql_admin_login"    { type = string }
variable "sql_admin_password" { 
  type = string 
   sensitive = true
   }
variable "sql_server_fqdn"    { type = string }
variable "db_name"            { type = string }

variable "client_id" {
  type        = string
  description = "Client ID of the Service Principal used by CI/CD"
}

variable "client_secret" {
  type        = string
  description = "Client Secret of the Service Principal used by CI/CD"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID of the Service Principal"
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID for the CI/CD Service Principal"
}
variable "dockerhub_username" {
  type        = string
}
variable "dockerhub_token" {
  type        = string
}

 variable aks_subnet_id{
    type = string 
 }