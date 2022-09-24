output "script_file" {
    value = "${azurerm_storage_blob.script.url}"
}

output "admin_password" {
    value = "${module.win_vm.admin_password}"
    sensitive = true
}