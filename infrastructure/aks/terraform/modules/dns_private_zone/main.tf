resource "azurerm_private_dns_zone" "dns_private_zone" {
  name                = var.dns_private_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_a_record" "wildcard" {
  name                = "*"
  zone_name           = azurerm_private_dns_zone.dns_private_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = ["${var.load_balancer_ip}"]
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_virtual_network_link" {
  name                  = "dns-link-${var.dns_private_zone_name}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.dns_private_zone_name
  virtual_network_id    = var.vnet_id
  depends_on = [ azurerm_private_dns_zone.dns_private_zone ]
}

/* resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_virtual_network_link_old" {
  name                  = "dns-link-${var.dns_private_zone_name}-old"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.dns_private_zone_name
  virtual_network_id    = var.old_vnet_id
  depends_on = [ azurerm_private_dns_zone.dns_private_zone ]
} */