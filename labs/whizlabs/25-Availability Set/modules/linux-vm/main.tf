resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  
  availability_set_id = var.availability_set_id

  admin_ssh_key {
    username   = var.ssh_username
    public_key = tls_private_key.this.public_key_openssh
  }
  
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

  tags = var.tags
}

resource "azurerm_public_ip" "this" {
    name                         = "${var.vm_name}-public-ip"
    location                     = var.location
    resource_group_name          = var.resource_group_name
    allocation_method            = var.private_ip_address_allocation
}