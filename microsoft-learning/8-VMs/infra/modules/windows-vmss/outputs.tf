output "id" {
  value = azurerm_windows_virtual_machine_scale_set.this.id
}

output "admin_username" {
  value = azurerm_windows_virtual_machine_scale_set.this.admin_username
}

output "admin_password" {
  value = random_password.this.result
}