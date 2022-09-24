output "script_file" {
  # value = [ for k, v in azurerm_storage_blob.this : v.url ]
  value = azurerm_storage_blob.this.url
}

output "vm_details" {
  value     = module.win_vm
  sensitive = true
}

output "vmss_details" {
  value     = module.win_vmss
  sensitive = true
}

resource "local_file" "ansible_inventory" {
  content = templatefile("ansible_inventory.tmpl",
    {
      vms = module.win_vm
      # key_vault_name = "kv" # module.key_vault.name
    }
  )
  filename = "../config/inventory.yml"
}

resource "local_file" "host_vars" {
  for_each = module.win_vm

  content = templatefile("ansible_host_vars.tmpl",
    {
      public_ip_address = each.value.public_ip_address
      admin_username = each.value.admin_username
      admin_password = each.value.admin_password
      vm_name = each.value.name
      rg_name = each.value.resource_group_name
      location = azurerm_resource_group.this[substr(each.value.resource_group_name, -3, -1)].location
    }
  )
  filename = "../config/host_vars/${each.key}.yml"
}