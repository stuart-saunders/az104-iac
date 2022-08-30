output "script_file" {
  # value = [ for k, v in azurerm_storage_blob.this : v.url ]
  value = azurerm_storage_blob.this.url
}

output "vm_details" {
  value     = module.win_vm
  sensitive = true
}