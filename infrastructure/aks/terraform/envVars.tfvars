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
vnet_address_space  = ["172.31.0.0/16"] # CIDR notation (https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-faq#what-address-ranges-can-i-use-in-my-vnets)

subnets = {
  aks_cluster        = "172.31.1.0/24"
  aks_nodes          = "172.31.2.0/24"
  dedicated_vms      = "172.31.3.0/24"
  management         = "172.31.4.0/24"
  internal_services  = "172.31.5.0/24"
}