module "azurerm_resource_group" {
  source = "./modules/resource_groups"
  name     = var.resource_group_name
  location = var.location
  tags = var.tags
}
