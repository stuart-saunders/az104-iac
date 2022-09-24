resource "azurerm_resource_group" "this" {
  name     = "${var.resource_name_prefix}-rg"
  location = var.location
}

module "linux_vm" {
  source  = "./modules/linux-vm"
  vm_name = "linux-vm"

  ip_configuration_name = "internal"
  subnet_id             = azurerm_subnet.this.id
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
}

resource "azurerm_virtual_machine_extension" "this" {
  name                 = "nginx"
  virtual_machine_id   = module.linux_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "fileUris": ["${azurerm_storage_blob.script.url}"],
        "commandToExecute": "sh ${local_file.script.filename}"
    }
SETTINGS
}