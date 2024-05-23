module "azurerm_resource_group" {
  source = "./modules/resource_groups"
  resource_group_name  = var.resource_group_name
  location = var.location
  tags = var.tags
}

module "azuread_group" {
  source = "./modules/entra_id_group"
  admin_group_name  = var.admin_group_name
  cluster_name = var.cluster_name
  depends_on = [
    module.azurerm_resource_group
  ]
}

module "azurerm_virtual_network" {
  source = "./modules/virtual_network"
  project_name = var.cluster_name
  location = var.location
  resource_group_name = var.resource_group_name
  vnet_name = var.vnet_name
  vnet_address_space = var.vnet_address_space
  subnets = var.subnets
  depends_on = [
    module.azurerm_resource_group
  ]
}

module "azurerm_kubernetes_cluster" {
  source = "./modules/aks_cluster"
  tags = var.tags
  location = var.location
  resource_group_name = var.resource_group_name
  admin_group_id = module.azuread_group.entra_id_group_id
  cluster_name = var.cluster_name
  kubernetes_version = var.kubernetes_version
  dns_prefix = var.dns_prefix
  agent_count = var.agent_count
  agent_vm_size = var.agent_vm_size
  node_os_disk_size_gb = var.node_os_disk_size_gb
  admin_username = var.admin_username
  client_id = var.client_id
  depends_on = [
    module.azuread_group,
    module.azurerm_virtual_network,
    module.azurerm_resource_group
  ]
}
