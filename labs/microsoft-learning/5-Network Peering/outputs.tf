output "vnets" {
  value = azurerm_virtual_network.this
}

output "subnets" {
  value = azurerm_subnet.this
}

output "vms" {
  value = local.vms
}

output "vm_details" {
  value     = module.win_vm
  sensitive = true
}