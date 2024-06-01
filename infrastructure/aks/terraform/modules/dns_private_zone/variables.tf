variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "dns_private_zone_name" {
  description = "DNS Private Zone Name"
  type        = string
}

variable "load_balancer_ip" {
  description = "Load Balancer IP"
  type        = string
}

variable "vnet_id" {
  description = "vnet id"
  type        = string
}

variable "old_vnet_id" {
  description = "old vnet id"
  type        = string
}