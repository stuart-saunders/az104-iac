output "config" {
    value = local.config
}

output "subnets" {
    value = azurerm_subnet.this
}

output "vm" {
    value = module.win_vm
    sensitive = true
}