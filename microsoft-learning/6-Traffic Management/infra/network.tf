resource "azurerm_virtual_network" "this" {
  for_each = var.vnets

  name                = each.key
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = [each.value.address_space]
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.value.subnet_name
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.this[each.value.vnet_name].name
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

resource "azurerm_route_table" "this" {
  for_each = var.route_table

  name                          = each.key
  location                      = azurerm_resource_group.rg1.location
  resource_group_name           = azurerm_resource_group.rg1.name
  disable_bgp_route_propagation = false

  route {
    name                   = each.value.route_name
    address_prefix         = each.value.route_address_prefix
    next_hop_type          = each.value.route_next_hop_type
    next_hop_in_ip_address = each.value.route_next_hop_address
  }
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each = var.route_table

  subnet_id      = azurerm_subnet.this[each.value.subnet].id
  route_table_id = azurerm_route_table.this[each.key].id
}