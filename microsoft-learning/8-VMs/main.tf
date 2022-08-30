resource "azurerm_resource_group" "this" {
  for_each = var.resource_groups

  name     = "${var.prefix}-${each.value}"
  location = var.location
}

module "win_vm" {
  for_each = local.vm_map

  source  = "./modules/windows-vm"
  vm_name = each.key
  vm_size = "Standard_DS1_v2"

  ip_configuration_name         = "ipconfig"
  private_ip_address_allocation = "Static"
  private_ip_address            = each.value.private_ip_address
  
  boot_diagnostics_storage_account_uri = azurerm_storage_account.this.primary_blob_endpoint

  subnet_id             = azurerm_subnet.this[each.value.subnet_name].id
  location              = azurerm_resource_group.this[each.value.resource_group_name].location
  resource_group_name   = azurerm_resource_group.this[each.value.resource_group_name].name
  zone                  = each.value.zone
}

resource "azurerm_virtual_machine_extension" "this" {
  for_each = local.vm_map
  
  name                 = "iis"
  virtual_machine_id   = module.win_vm[each.key].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "fileUris": ["${azurerm_storage_blob.this.url}"],
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File ${local_file.iis_script.filename}"
    }
SETTINGS
}

# module "win_vmss" {
#   for_each = local.vmss_map

#   source         = "./modules/windows-vmss"
#   scale_set_name = each.key
#   vm_sku         = "Standard_DS1_v2"
#   instances      = each.value.instances

#   ip_configuration_name         = "ipconfig"
#   private_ip_address_allocation = "Static"
#   private_ip_address            = each.value.private_ip

#   subnet_id             = azurerm_subnet.this[each.value.subnet_name].id
#   location              = azurerm_resource_group.this[each.value.resource_group_name].location
#   resource_group_name   = azurerm_resource_group.this[each.value.resource_group_name].name
#   zones                 = each.value.zones

#   boot_diagnostics_storage_account_uri = azurerm_storage_account.this[each.value.resource_group_name].primary_blob_endpoint
# }

# resource "azurerm_virtual_machine_scale_set_extension" "this" {
#   for_each = local.vmss_map

#   name                         = "iis"
#   virtual_machine_scale_set_id = module.win_vmss[each.key].id
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.10"

#   settings = <<SETTINGS
#     {
#         "fileUris": ["${azurerm_storage_blob.this[each.value.resource_group_name].url}"],
#         "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File ${local_file.iis_script.filename}"
#     }
# SETTINGS
# }