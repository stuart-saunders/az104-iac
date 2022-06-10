output "id" {
  value = azurerm_windows_virtual_machine.this.id
}

output "name" {
  value = azurerm_windows_virtual_machine.this.name
}

output "admin_user" {
  value = azurerm_windows_virtual_machine.this.admin_username
}

output "admin_password" {
  value = random_password.this.result
}

output "private_ip_address" {
  value = azurerm_windows_virtual_machine.this.private_ip_address
}

output "public_ip_address" {
  value = azurerm_windows_virtual_machine.this.public_ip_address
}