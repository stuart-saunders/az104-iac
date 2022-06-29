resource "azurerm_virtual_network" "this" {
  name                = "vnet0"
  location            = azurerm_resource_group.rg0.location
  resource_group_name = azurerm_resource_group.rg0.name
  address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "this" {
  name                 = "subnet0"
  resource_group_name  = azurerm_resource_group.rg0.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.subnet_address_space]
}