output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "ID of the virtual network."
}

output "subnet_ids" {
  value = { for subnet in azurerm_virtual_network.vnet.subnet : subnet.name => subnet.id }
  description = "IDs of the subnets."
}

# output "dns_resolver_subnet_id" {
#   value       = azurerm_subnet.inbound_dns_subnet.id
#   description = "ID of the DNS resolver subnet."
# }
