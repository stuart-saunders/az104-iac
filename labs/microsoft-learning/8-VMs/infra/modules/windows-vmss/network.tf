# resource "azurerm_network_interface" "this" {
#   name                = "${var.scale_set_name}-nic"
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   enable_ip_forwarding = var.enable_ip_forwarding

#   ip_configuration {
#     name                          = var.ip_configuration_name
#     subnet_id                     = var.subnet_id
#     private_ip_address_allocation = var.private_ip_address_allocation
#     private_ip_address            = var.private_ip_address
#     public_ip_address_id          = azurerm_public_ip.vmss_ip.id
#   }
# }

resource "azurerm_network_security_group" "this" {
    name                = "${var.scale_set_name}-nsg"
    location            = var.location
    resource_group_name = var.resource_group_name
}

# resource "azurerm_network_interface_security_group_association" "this" {
#   network_interface_id      = azurerm_network_interface.this.id
#   network_security_group_id = azurerm_network_security_group.this.id
# }

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
  resource_group_name          = var.resource_group_name
}

resource "azurerm_public_ip" "lb_ip" {
    name                         = "${var.scale_set_name}-lb-pip"
    location                     = var.location
    resource_group_name          = var.resource_group_name
    allocation_method            = var.private_ip_address_allocation
    sku                          = "Standard"
    zones                        = var.zones
}

resource "azurerm_lb" "this" {
  name                = "${var.scale_set_name}-lb"
  sku                 = "Standard"
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = var.lb_frontend_ip_config_name
    public_ip_address_id = azurerm_public_ip.lb_ip.id
  }
}

resource "azurerm_lb_rule" "this" {
  loadbalancer_id                = azurerm_lb.this.id
  name                           = "lb-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.lb_frontend_ip_config_name
  probe_id                       = azurerm_lb_probe.this.id
  backend_address_pool_ids       = [ azurerm_lb_backend_address_pool.this.id ]
}

resource "azurerm_lb_probe" "this" {
  loadbalancer_id = azurerm_lb.this.id
  name            = "tcp-probe"
  port            = 80
}

resource "azurerm_lb_backend_address_pool" "this" {
  loadbalancer_id = azurerm_lb.this.id
  name            = "bepool"
}

resource "azurerm_lb_nat_pool" "this" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.this.id
  name                           = "natpool"
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50003
  backend_port                   = 3389
  frontend_ip_configuration_name = var.lb_frontend_ip_config_name
}