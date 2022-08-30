resource "azurerm_virtual_network" "vnet" {
  for_each = var.network_resources

  name                = each.key
  address_space       = [ each.value.address_space ]
  location            = azurerm_resource_group.this[each.value.resource_group_name].location
  resource_group_name = azurerm_resource_group.this[each.value.resource_group_name].name
}

resource "azurerm_subnet" "this" {
  for_each = local.vnet_subnet_map

  name                 = each.value.subnet_name
  resource_group_name  = "${var.prefix}-${each.value.resource_group_name}"
  virtual_network_name = azurerm_virtual_network.vnet[each.value.vnet_name].name
  address_prefixes     = [each.value.subnet_address_space]

  enforce_private_link_endpoint_network_policies = true
}