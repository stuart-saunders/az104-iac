resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg"
  location = var.location
}

module "win_vm" {
  for_each = local.vms

  source  = "./modules/windows-vm"
  vm_name = each.key

  ip_configuration_name = "ipconfig"
  subnet_id             = azurerm_subnet.this[each.value[0].subnet_key].id
  location              = each.value[0].location
  resource_group_name   = azurerm_resource_group.this.name
}