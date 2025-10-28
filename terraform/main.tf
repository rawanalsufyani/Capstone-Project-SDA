module "rg" {
  source   = "./modules/rg"
  rg_name  = var.rg_name
  location = var.location
}

module "vent" {
  source              = "./modules/vnet"
  prefix              = var.prefix
  rg_name             = module.rg.name
  location            = module.rg.location
  vnet_cidr           = var.vnet_cidr
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
  vnet_id                  = module.vent.vnet_id
  data_pe_subnet_id       = module.vent.data_pe_subnet_id
  sql_private_dns_zone_id = module.vent.sql_private_dns_zone_id

    depends_on = [module.vent]
}

#module "keyvault" {
  #source                 = "./modules/keyvault"
  #prefix                 = var.prefix
  #rg_name                = module.rg.name
#  location               = module.rg.location
 #aks_subnet_id = module.vent.aks_subnet_id
  
    # SQL secrets
#  sql_admin_login    = var.sql_admin_login
#  sql_admin_password = var.sql_admin_password
#  sql_server_fqdn    = module.sql.sql_fqdn
  #db_name            = var.db_name

   # CI/CD Service Principal secrets
#  client_id     = var.client_id
#  client_secret = var.client_secret
#  tenant_id     = var.tenant_id
#  subscription_id  = var.subscription_id
  
  # Docker Hub secrets
#  dockerhub_username = var.dockerhub_username
#  dockerhub_token    = var.dockerhub_token
#}

module "ingress_ip"{
    source = "./modules/ingress"
      prefix                  = var.prefix
    ingress_name = "${var.prefix}${var.ingress_name}"
    rg_name = module.rg.name
    rg_location = module.rg.location
    ingress_dns_label = coalesce(var.ingress_dns_label, "${var.prefix}-ingress")
}




module "aks" {

  source =  "./modules/azurerm_kubernetes_cluster"

  name = "${var.prefix}-aks"

  resource_group_name = module.rg.name

  location = module.rg.location

  dns_prefix = "${var.prefix}-dns"

  vnet_subnet_id = module.vent.aks_subnet_id

  identity_type = "SystemAssigned"

  node_resource_group_name = "${var.prefix}-aks"

  default_node_pool_name = "systempool"

}