variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "vnet_name" {
  description = "Name of the VNet"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space of the VNet"
  type        = list(string)
}

# variable "old_vnet_name" {
#   description = "Name of the old VNet"
#   type        = string
# }
# 
# variable "old_vnet_resource_group" {
#   description = "Name of the Resource Group where the old VNet is located"
#   type        = string
# }
# 
# variable "old_vnet_id" {
#   description = "ID of the old VNet"
#   type        = string
# }

variable "subnets" {
  description = "Map of subnets"
  type        = map(string)
}
