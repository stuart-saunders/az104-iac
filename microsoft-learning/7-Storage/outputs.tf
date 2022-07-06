output "vm_details" {
  value     = module.win_vm
  sensitive = true
}

output "sas_url_query_string" {
  value     = data.azurerm_storage_account_blob_container_sas.this.sas
  sensitive = true
}