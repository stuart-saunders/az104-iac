resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg"
  location = var.location
}

module "win_vm" {  
  for_each = local.config

  source  = "./modules/windows-vm"
  vm_name = each.value.vm_name

  ip_configuration_name = "ipconfig${each.key}"
  subnet_id             = azurerm_subnet.this[each.key].id
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
  network_interface_id  = azurerm_network_interface.this[each.key].id
}