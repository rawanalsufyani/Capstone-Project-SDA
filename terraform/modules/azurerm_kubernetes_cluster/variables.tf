variable "prefix" {
  type =string
  description ="prefix"
}

variable "rg_name" {
 type = string
 description = "resource group name"
 }
variable "rg_location" {
  type = string
  description = "location of cluster"
}

variable "vm_size" {
  type = string
  description = "size of vms"
  default = "Standard_A2_v2"
}

variable "default_node_pool_name" {
  type = string
  description = "Name of system node pool"
}

variable user_node_pool_name{
  type =string
  description = "Name of user node pool"
}

 variable aks_node_count{
    type = number
    description = " number of nodes"
 }

 variable aks_subnet_id{
    type = string 
 }

 variable "service_cidr" {
  type = string
   
 }

 variable min_autoscaler{
    type = number
    description = "min number of nodes for autoscaling"

 }
 variable max_autoscaler{
  type = number 
  description = "max number of nodes for autoscaling"

 }
 variable "dns_service_ip" {
   type = string
 }



 