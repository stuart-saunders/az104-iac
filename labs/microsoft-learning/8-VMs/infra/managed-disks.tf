# resource "azurerm_managed_disk" "this" {
#   for_each = local.vm_disks

#   name                 = each.key
#   resource_group_name  = azurerm_resource_group.this[each.value.resource_group_name].name
#   location             = azurerm_resource_group.this[each.value.resource_group_name].location
#   storage_account_type = "Premium_LRS"
#   create_option        = "Empty"
#   disk_size_gb         = "1100"
#   zone                 = each.value.zone
# }

# resource "azurerm_virtual_machine_data_disk_attachment" "this" {
#   for_each = local.vm_disks
  
#   managed_disk_id    = azurerm_managed_disk.this["${each.value.vm_name}-${each.value.disk_name}"].id
#   virtual_machine_id = module.win_vm[each.value.vm_name].id
#   lun                = index(keys(local.vm_disks), each.key) + 1
#   caching            = "ReadWrite"
# }