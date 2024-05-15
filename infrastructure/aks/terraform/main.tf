module "azurerm_resource_group" {
  source = "./modules/resource_groups"
  resource_group_name  = var.resource_group_name
  location = var.location
  tags = var.tags
}

module "azuread_group" {
  source = "./modules/entra_id_group"
  admin_group_name  = var.admin_group_name
}
