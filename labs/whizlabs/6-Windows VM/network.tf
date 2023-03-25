resource "azurerm_virtual_network" "this" {
  name                = "${var.resource_name_prefix}-vnet"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.99.0.0/16"]
}

resource "azurerm_subnet" "this" {
  name                 = "${var.resource_name_prefix}-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.99.99.0/24"]
}

resource "azurerm_network_interface" "this" {
  name                = "${var.resource_name_prefix}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

resource "azurerm_network_security_group" "this" {
    name                = "${var.resource_name_prefix}-nsg"
    location            = var.location
    resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_network_security_rule" "rules" {
  for_each                     = { for i, v in var.nsg_rules: i => v }
  name                         = each.value.name
  direction                    = each.value.direction
  access                       = each.value.access
  priority                     = each.value.priority
  protocol                     = each.value.protocol
  source_port_range            = each.value.source_port_range
  destination_port_range       = each.value.destination_port_range
  source_address_prefix        = each.value.source_address_prefix
  destination_address_prefix   = each.value.destination_address_prefix
  network_security_group_name  = azurerm_network_security_group.this.name
  resource_group_name          = azurerm_resource_group.this.name
}