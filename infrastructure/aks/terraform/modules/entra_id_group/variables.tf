variable "admin_group_name" {
  type = string
  description = "Name of the Microsoft Entra ID group created with Cluster Admin role mapping."
}

variable "cluster_name" {
  type = string
  description = "Name of the kubernetes cluster to set-up."
}