resource "azurerm_resource_group" "this" {
  name     = "${var.resource_name_prefix}-rg"
  location = var.location
}

module "win_vm" {
  source  = "./modules/windows-vm"
  vm_name = "win-vm"

  ip_configuration_name = "internal"
  subnet_id             = azurerm_subnet.this.id
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
}

//TODO: Review this
resource "azurerm_virtual_machine_extension" "this" {
  name                 = "Network Watcher"
  virtual_machine_id   = module.win_vm.id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentWindows"
  type_handler_version = "1.4"
  settings             = "{}"
}