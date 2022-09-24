output "vmss_details" {
  value = azurerm_windows_virtual_machine_scale_set.this
  sensitive = true
}