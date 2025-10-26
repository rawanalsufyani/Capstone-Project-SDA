

variable "rg_name" {
  type = string
  description = "resource group name"
}

variable "rg_location" {
  type = string
  description = "resource group location"
}

variable "allocation_method" {
  type = string
  default = "Static"
}

variable "sku" {
    type = string
    default = "Standard"
  
}

variable "ingress_name" {
  type = string 
  description = "ingress ip name"
}