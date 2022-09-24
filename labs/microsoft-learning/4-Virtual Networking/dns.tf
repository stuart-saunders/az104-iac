resource "azurerm_private_dns_zone" "this" {
  name                = "contoso.org"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "contoso-vnet-link"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = azurerm_virtual_network.this.id
  registration_enabled  = true
}

resource "azurerm_dns_zone" "this" {
  name                = "stuarts.dev"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_dns_a_record" "example" {
  for_each = azurerm_public_ip.this

  name                = "${var.prefix}-vm${each.key}"
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = azurerm_resource_group.this.name
  ttl                 = 3600
  records             = [ each.value.ip_address ]
}