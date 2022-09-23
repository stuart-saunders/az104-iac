resource "random_password" "this" {
  length = var.secret_length
  special = var.special
  override_special = var.override_special
}

# resource "azurerm_public_ip" "vmss_ip" {
#     name                         = "${var.scale_set_name}-pip"
#     location                     = var.location
#     resource_group_name          = var.resource_group_name
#     allocation_method            = var.private_ip_address_allocation
#     sku                          = "Standard"
#     zones                        = var.zones
# }

resource "azurerm_windows_virtual_machine_scale_set" "this" {
  name                = var.scale_set_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.vm_sku
  instances           = var.instances
  admin_username      = var.admin_username
  admin_password      = random_password.this.result
  zones               = var.zones
  upgrade_mode        = var.upgrade_mode

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  os_disk {
    storage_account_type = var.os_disk_storage_account_type
    caching              = var.os_disk_caching
  }

  network_interface {
    name    = "${var.scale_set_name}-nic"
    primary = true

    ip_configuration {
      name      = var.ip_configuration_name
      subnet_id = var.subnet_id
      public_ip_address {
        name = "vmss_pip_config"
      }
      load_balancer_backend_address_pool_ids = [ azurerm_lb_backend_address_pool.this.id ]
      load_balancer_inbound_nat_rules_ids    = [ azurerm_lb_nat_pool.this.id ]
    }

    network_security_group_id = azurerm_network_security_group.this.id
  }

  boot_diagnostics {
    # storage_account_uri = azurerm_storage_account.boot_diagnostics_sa.primary_blob_endpoint
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }
}

resource "azurerm_virtual_machine_scale_set_extension" "this" {

  name                         = "iis"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.this.id
  publisher                    = "Microsoft.Compute"
  type                         = "CustomScriptExtension"
  type_handler_version         = "1.10"

  settings = <<SETTINGS
    {
        "fileUris": ["${var.vmss_extension_file_uri}"],
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File ${var.vmss_extension_file_name}"
    }
SETTINGS
}

# resource "azurerm_virtual_machine_scale_set_extension" "this" {

#   name                         = "iis"
#   virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.this.id
#   publisher                    = "Microsoft.Compute"
#   type                         = "CustomScriptExtension"
#   type_handler_version         = "1.10"

#   settings = <<SETTINGS
#     {
#         "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File ${local_file.iis_script.filename}"
#     }
# SETTINGS
# }