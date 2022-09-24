resource "azurerm_resource_group" "rg1" {
  name     = "${var.prefix}-rg1"
  location = var.location
}

module "win_vm" {
  for_each = var.vms

  source  = "./modules/windows-vm"
  vm_name = each.key

  ip_configuration_name = "ipconfig"
  subnet_id             = azurerm_subnet.this[each.value.subnet_key].id
  location              = azurerm_resource_group.rg1.location
  resource_group_name   = azurerm_resource_group.rg1.name
  enable_ip_forwarding  = lookup(each.value, "enable_ip_forwarding", null)
}

resource "azurerm_virtual_machine_extension" "winrm_listener" {
  for_each = module.win_vm

  name                 = each.value.name
  virtual_machine_id   = each.value.id
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

# resource "azurerm_virtual_machine_extension" "iis" {
#   for_each = module.win_vm

#   name                 = each.value.name
#   virtual_machine_id   = each.value.id
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.7"

#   settings = <<SETTINGS
#     {
#       "commandToExecute": "powershell.exe Install-WindowsFeature -name Web-Server -IncludeManagementTools && powershell.exe remove-item 'C:\\inetpub\\wwwroot\\iisstart.htm' && powershell.exe Add-Content -Path 'C:\\inetpub\\wwwroot\\iisstart.htm' -Value $('Hello World from ' + $env:computername)"
#     }
# SETTINGS
# }

# resource "azurerm_virtual_machine_extension" "network_watcher" {
#   for_each = module.win_vm

#   name                 = each.value.name
#   virtual_machine_id   = each.value.id
#   publisher            = "Microsoft.Azure.NetworkWatcher"
#   type                 = "NetworkWatcherAgentWindows"
#   type_handler_version = "1.4"
# }