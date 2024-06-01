tags = {PURPOSE = "AUTOMATION", ENVIRONMENT = "PRODUCTION"}
location = "West Europe"
resource_group_name = "DevSecOps-Cluster"
cluster_name = "devsecops-cluster"
admin_group_name = "admins"

kubernetes_version = "1.28.9"
dns_prefix = "devsecops-cluster-dns"
agent_count = 2
agent_vm_size = "Standard_D8ds_v5"
node_os_disk_size_gb = 128
admin_username = "azureuser"
client_id = "msi"

vnet_name           = "devsecops-vnet"
vnet_address_space  = ["172.40.0.0/16"]

subnets = {
  aks_cluster        = "172.40.1.0/24"
  aks_nodes          = "172.40.2.0/24"
  dedicated_vms      = "172.40.3.0/24"
  management         = "172.40.4.0/24"
  internal_services  = "172.40.5.0/24"
}