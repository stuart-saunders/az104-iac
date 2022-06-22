resource "azurerm_virtual_network" "this" {
  name                = var.vnet.name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.vnet.address_space]
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value.address_space]
}

resource "azurerm_public_ip" "bastion_pip" {
  name                = "bastion-pip"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "example" {
  name                = "bastion"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.this["bastion"].id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}

resource "azurerm_route_table" "this" {
  name                          = "public-rt"
  location                      = azurerm_resource_group.this.location
  resource_group_name           = azurerm_resource_group.this.name
  disable_bgp_route_propagation = false

  route {
    name                   = "to-private-subnet"
    address_prefix         = azurerm_subnet.this["private"].address_prefixes[0]
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.2.4"
  }
}

resource "azurerm_subnet_route_table_association" "this" {
  subnet_id      = azurerm_subnet.this["public"].id
  route_table_id = azurerm_route_table.this.id
}