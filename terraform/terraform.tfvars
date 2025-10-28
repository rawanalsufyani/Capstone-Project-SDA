prefix             = "team5"
rg_name            = "team5-rg"
location           = "indonesiacentral"
subscription_id    = "80646857-9142-494b-90c5-32fea6acbc41"
vnet_cidr          = "10.0.0.0/16"
appgw_subnet_cidr  = "10.0.1.0/24"
aks_subnet_cidr    = "10.0.2.0/24"
data_pe_subnet_cidr = "10.0.3.0/24"
db_name            = "team5-db"
sql_admin_login    = "azure"
sql_admin_password = "YourSecurePassword123!"
node_count      = 2
#vm_size         = "Standard_B2s"
service_cidr    = "10.2.0.0/16"
dns_service_ip  = "10.2.0.10"
#default_node_pool_name= "systempool"
user_node_pool_name = "node"
ingress_name ="ingress-ip"
min_autoscaler = 2
max_autoscaler = 3
#client_id        = ""
#client_secret    = ""
#tenant_id        =  ""
dockerhub_username = "placeholder-user"
dockerhub_token    = "placeholder-token"


