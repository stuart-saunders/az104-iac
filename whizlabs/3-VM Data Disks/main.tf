resource "azurerm_resource_group" "this" {
  name     = "${var.resource_name_prefix}-rg"
  location = var.location
}

locals {
  vm_name = "win-vm"
}

module "win_vm" {
  source  = "./modules/windows-vm"
  vm_name = local.vm_name

  ip_configuration_name = "internal"
  subnet_id             = azurerm_subnet.this.id
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
}

resource "azurerm_managed_disk" "this" {
  name                 = "${local.vm_name}-disk1"
  location             = azurerm_resource_group.this.location
  resource_group_name  = azurerm_resource_group.this.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  managed_disk_id    = azurerm_managed_disk.this.id
  virtual_machine_id = module.win_vm.id
  lun                = "10"
  caching            = "ReadWrite"
}

resource "azurerm_virtual_machine_extension" "this" {
  name                 = "initialise-disk"
  virtual_machine_id   = module.win_vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  # TODO: Refactor to something like... "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File ${var.script_filename}"
  settings = <<SETTINGS
    {
      "fileUris": ["${azurerm_storage_blob.script.url}"]
      "commandToExecute": "powershell Get-Disk ^| Where-Object PartitionStyle -eq 'raw' ^| Initialize-Disk -PartitionStyle MBR -PassThru ^| New-Partition -AssignDriveLetter -UseMaximumSize ^| Format-Volume -FileSystem NTFS -NewFileSystemLabel 'disk2' -Confirm:$false"
    }
  SETTINGS

  depends_on = [
    azurerm_virtual_machine_data_disk_attachment.this
  ]
}