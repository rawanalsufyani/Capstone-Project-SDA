module "rg" {
  source   = "./modules/resource_group"
  rg_name  = var.rg_name
  location = var.location
}

module "vent" {
  source              = "./modules/vnet"
  prefix              = var.prefix
  rg_name             = module.rg.name
  location            = module.rg.location
  vnet_cidr           = var.vnet_cidr
  appgw_subnet_cidr   = var.appgw_subnet_cidr
  aks_subnet_cidr     = var.aks_subnet_cidr
  data_pe_subnet_cidr = var.data_pe_subnet_cidr  
}

module "sql" {
  source                  = "./modules/sql"
  prefix                  = var.prefix
  rg_name                 = module.rg.name
  location                = module.rg.location
  db_name                 = var.db_name
  sql_admin_login         = var.sql_admin_login
  sql_admin_password      = var.sql_admin_password

  data_pe_subnet_id       = module.vent.data_pe_subnet_id
  sql_private_dns_zone_id = module.vent.sql_private_dns_zone_id
}

module "keyvault" {
  source                 = "./modules/keyvault"
  prefix                 = var.prefix
  rg_name                = module.rg.name
  location               = module.rg.location

  pe_subnet_id           = module.vent.data_pe_subnet_id
  kv_private_dns_zone_id = module.vent.kv_private_dns_zone_id

  sql_admin_login    = var.sql_admin_login
  sql_admin_password = var.sql_admin_password
  sql_server_fqdn    = module.sql.sql_fqdn
  db_name            = var.db_name
}

module "ingress_ip"{
    source = "./modules/ingress"
    ingress_name = "${var.prefix}${var.ingress_name}"
    rg_name = module.rg.name
    rg_location = module.resource_group.rg_location
}

module "cluster"{
    source = "./modules/azurerm_kubernetes_cluster"
    prefix = var.prefix
    rg_name = module.rg.name
    rg_location = module.resource_group.rg_location
    default_node_pool_name= "${var.prefix}${var.default_node_pool_name}"
    user_node_pool_name = "${var.prefix}${var.user_node_pool_name}"
    vm_size = var.vm_size
    service_cidr = var.service_cidr
    dns_service_ip = var.dns_service_ip
    aks_node_count = var.node_count
    min_autoscaler = var.min_autoscaler
    max_autoscaler = var.max_autoscaler
    aks_subnet_id = module.vent.aks_subnet_id
}