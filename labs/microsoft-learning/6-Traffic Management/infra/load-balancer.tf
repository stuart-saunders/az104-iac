resource "azurerm_public_ip" "lb_pip" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "this" {
  name                = "lb4"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  loadbalancer_id = azurerm_lb.this.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_backend_address_pool_address" "this" {
  for_each = var.lb_backend_pool_vms

  name                    = each.value
  backend_address_pool_id = azurerm_lb_backend_address_pool.this.id
  virtual_network_id      = azurerm_virtual_network.this["vnet1"].id
  ip_address              = module.win_vm[each.value].public_ip_address
}

resource "azurerm_lb_probe" "this" {
  loadbalancer_id = azurerm_lb.this.id
  name                = "health-probe"
  port                = 80
  protocol            = "Tcp"
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "this" {
  name                           = "lb-rule"
  loadbalancer_id                = azurerm_lb.this.id
  frontend_ip_configuration_name = "PublicIPAddress"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  backend_address_pool_ids       = [ azurerm_lb_backend_address_pool.this.id ]
  # probe_id                       = azurerm_lb_probe.this.id
  # load_distribution              = "None"
}