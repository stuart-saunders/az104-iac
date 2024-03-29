resource "azurerm_resource_group" "this" {
  name = "${var.resource_name_prefix}-rg"
  location = var.location
}

resource "random_password" "this" {
  length = var.secret_length
  special = var.special
  override_special = var.override_special
}

resource "azurerm_windows_virtual_machine" "this" {
  name                = "${var.resource_name_prefix}-vm"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = random_password.this.result
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }
}

resource "azurerm_public_ip" "this" {
    name                         = "${var.resource_name_prefix}-public-ip"
    location                     = var.location
    resource_group_name          = azurerm_resource_group.this.name
    allocation_method            = var.private_ip_address_allocation
}