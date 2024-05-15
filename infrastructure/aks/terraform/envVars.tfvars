tags = {PURPOSE = "AUTOMATION", ENVIRONMENT = "PRODUCTION"}
location = "West Europe"
resource_group_name = "devsecops-cluster"
cluster_name = "devsecops-cluster"
admin_group_name = "admins"

kubernetes_version = "1.28.9"
dns_prefix = "devsecops-cluster-dns"
agent_count = 2
agent_vm_size = "Standard_D8ds_v5"
node_os_disk_size_gb = 128
admin_username = "azureuser"
client_id = "msi"