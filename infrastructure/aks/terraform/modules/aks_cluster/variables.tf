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

variable "admin_group_id" {
  type = string
  description = "ID for the admin group."
}

variable "cluster_name" {
  type = string
  description = "Name of the kubernetes cluster to set-up."
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use."
  type        = string
  default     = "1.28.9"
}

variable "dns_prefix" {
  description = "The DNS prefix to use for the AKS cluster."
  type        = string
}

variable "agent_count" {
  description = "The number of agent nodes for the default node pool."
  type        = number
  default     = 2
}

variable "agent_vm_size" {
  description = "The size of the VMs to use for the agent pool."
  type        = string
  default     = "Standard_D8ds_v5"
}

variable "node_os_disk_size_gb" {
  description = "The size of the OS disk in GB."
  type        = number
  default     = 128
}

variable "admin_username" {
  description = "Admin username for Windows profile."
  type        = string
  default     = "azureuser"
}

variable "client_id" {
  description = "Client ID for the service principal."
  type        = string
  default     = "msi"
}