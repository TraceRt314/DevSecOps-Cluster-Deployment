variable "tags" {
  type = map(string)
  description = "General Tags that will be applied to all the resources generated"
}

variable "location" {
  type = string
  description = "Region/Location for the resources to be created."
}

variable "resource_group_name" {
  type = string
  description = "Name of the Resource Group to bundle all the resources."
}

variable "cluster_name" {
  type = string
  description = "Name of the kubernetes cluster to set-up."
}

