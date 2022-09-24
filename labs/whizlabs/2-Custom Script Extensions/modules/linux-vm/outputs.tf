output "id" {
  value = azurerm_linux_virtual_machine.this.id
}

output "network_interface_id" {
  value = azurerm_network_interface.this.id
}

output "admin_username" {
  value = azurerm_linux_virtual_machine.this.admin_username
}
output "private_ip_address" {
  value = azurerm_linux_virtual_machine.this.private_ip_address
}

resource "local_file" "private_key" {
  filename        = "${var.vm_name}-private-key.pem"
  content         = tls_private_key.this.private_key_pem
  file_permission = 400
}