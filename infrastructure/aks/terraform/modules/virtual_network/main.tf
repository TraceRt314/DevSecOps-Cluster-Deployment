resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space

  dynamic "subnet" {
    for_each = var.subnets
    content {
      name           = "snet_${subnet.key}"
      address_prefix = subnet.value
    }
  }
}

# VNet Peering from new VNet to old VNet
# resource "azurerm_virtual_network_peering" "peering_to_old_vnet" {
#   name                      = "peering-${var.vnet_name}-to-${var.old_vnet_name}"
#   resource_group_name       = var.resource_group_name
#   virtual_network_name      = azurerm_virtual_network.vnet.name
#   remote_virtual_network_id = var.old_vnet_id
#   allow_virtual_network_access = true
#   allow_forwarded_traffic      = true
#   depends_on = [ azurerm_virtual_network.vnet ]
# }

# VNet Peering from old VNet to new VNet
# IMPORTANT: This peering is needed to allow the old VNet to access the new VNet.
# Here we are managing resources from other resource group, be careful.
# resource "azurerm_virtual_network_peering" "peering_from_old_vnet" {
#   name                      = "peering-${var.old_vnet_name}-to-${var.vnet_name}"
#   resource_group_name       = var.old_vnet_resource_group
#   virtual_network_name      = var.old_vnet_name
#   remote_virtual_network_id = azurerm_virtual_network.vnet.id
#   allow_virtual_network_access = true
#   allow_forwarded_traffic      = true
#   depends_on = [ azurerm_virtual_network.vnet ]
# }

# resource "azurerm_public_ip" "nat_gateway_public_ip" {
#   name                = "natgw-pip-${var.project_name}"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }
# 
# resource "azurerm_nat_gateway" "nat_gateway" {
#   name                = "natgw-${var.project_name}"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   sku_name            = "Standard"
# }
# 
# resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_public_ip_association" {
#   nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
#   public_ip_address_id = azurerm_public_ip.nat_gateway_public_ip.id
# }
# 
# resource "azurerm_subnet_nat_gateway_association" "nat_gateway_association_management" {
#   subnet_id      = {for s in azurerm_virtual_network.vnet.subnet : s.name => s.id}["snet-${var.project_name}-management"]
#   nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
# }
# 
# resource "azurerm_subnet_nat_gateway_association" "nat_gateway_association_workers" {
#   subnet_id      = {for s in azurerm_virtual_network.vnet.subnet : s.name => s.id}["snet-${var.project_name}-workers"]
#   nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
# }
# 
# resource "azurerm_subnet_nat_gateway_association" "nat_gateway_association_loadbalancer" {
#   subnet_id      = {for s in azurerm_virtual_network.vnet.subnet : s.name => s.id}["snet-${var.project_name}-lb"]
#   nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
# }
# 
# resource "azurerm_subnet_nat_gateway_association" "nat_gateway_association_machines" {
#   subnet_id      = {for s in azurerm_virtual_network.vnet.subnet : s.name => s.id}["snet-${var.project_name}-machines"]
#   nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
# }
# 
# resource "azurerm_subnet" "inbound_dns_subnet" {
#   name                 = "snet-${var.project_name}-inbound-dns"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = var.vnet_name
#   address_prefixes     = [var.subnet_prefixes[6]]
# 
#   delegation {
#     name = "Microsoft.Network.dnsResolvers"
#     service_delegation {
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
#       name    = "Microsoft.Network/dnsResolvers"
#     }
#   }
#   depends_on = [ azurerm_virtual_network.vnet ]
# }

# resource "azurerm_virtual_network_gateway" "vpn_gateway" {
#   name                = var.vpn_gateway_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
# 
#   type     = "Vpn"
#   vpn_type = "RouteBased"
# 
#   active_active      = false
#   enable_bgp         = false
#   sku                = "VpnGw2"
# 
#   ip_configuration {
#     name                          = "vnetGatewayConfig"
#     public_ip_address_id          = azurerm_public_ip.vpn_gateway_public_ip.id
#     private_ip_address_allocation = "Dynamic"
#     subnet_id                     = azurerm_subnet.gateway_subnet.id
#   }
# 
#   vpn_client_configuration {
#     address_space = [var.vpn_client_address_pool]
# 
#     azure_active_directory_authentication {
#       audience                    = "YOUR_AUDIENCE"
#       issuer                      = "YOUR_ISSUER"
#       tenant                      = "YOUR_TENANT_ID"
#     }
# 
#     root_certificate {
#       name     = "YOUR_ROOT_CERT_NAME"
#       public_cert_data = "YOUR_ROOT_CERT_DATA"
#     }
# 
#   }
# }