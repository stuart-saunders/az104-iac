resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg"
  location = var.location
}

module "win_vm" {
  for_each = var.vms

  source  = "./modules/windows-vm"
  vm_name = each.key

  ip_configuration_name = "ipconfig"
  subnet_id             = each.key == "nvm" ? azurerm_subnet.this["dmz"].id : azurerm_subnet.this[each.key].id
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
  enable_ip_forwarding  = each.key == "nvm" ? true : false
}

resource "azurerm_virtual_machine_extension" "winrm_listener" {
  for_each = module.win_vm

  name                 = each.key
  virtual_machine_id   = module.win_vm[each.key].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
    {
      "fileUris": [ "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1" ],
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File ConfigureRemotingForAnsible.ps1"
    }
SETTINGS
}