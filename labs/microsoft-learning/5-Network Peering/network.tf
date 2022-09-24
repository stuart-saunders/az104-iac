resource "azurerm_virtual_network" "this" {
  for_each = var.vnets

  name                = each.key
  location            = each.value.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [each.value.address_space]
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.value.subnet_name
  resource_group_name  = azurerm_virtual_network.this[each.value.vnet_name].resource_group_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = [each.value.address_space]
}

resource "azurerm_virtual_network_peering" "first_to_second" {
  for_each = local.peerings

  name                      = each.key
  resource_group_name       = azurerm_virtual_network.this[each.value.first].resource_group_name
  virtual_network_name      = azurerm_virtual_network.this[each.value.first].name
  remote_virtual_network_id = azurerm_virtual_network.this[each.value.second].id
}

resource "azurerm_virtual_network_peering" "second_to_first" {
  for_each = local.peerings

  name                      = each.key
  resource_group_name       = azurerm_virtual_network.this[each.value.second].resource_group_name
  virtual_network_name      = azurerm_virtual_network.this[each.value.second].name
  remote_virtual_network_id = azurerm_virtual_network.this[each.value.first].id
}