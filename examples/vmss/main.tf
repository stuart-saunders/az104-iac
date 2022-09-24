resource "azurerm_resource_group" "this" {
  name     = "vmss-tf-rg"
  location = "uksouth"
}

resource "azurerm_virtual_network" "this" {
  name                = "vmss-tf-rg-vnet"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = ["10.93.0.0/16"]
}

resource "azurerm_subnet" "this" {
  name                 = "vmss-tf-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.93.0.0/24"]
}

resource "azurerm_network_security_group" "this" {
    name                = "${var.scale_set_name}-nsg"
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_network_security_rule" "rules" {
  for_each                     = { for i, v in var.nsg_rules: i => v }
  name                         = each.value.name
  direction                    = each.value.direction
  access                       = each.value.access
  priority                     = each.value.priority
  protocol                     = each.value.protocol
  source_port_range            = each.value.source_port_range
  destination_port_range       = each.value.destination_port_range
  source_address_prefix        = each.value.source_address_prefix
  destination_address_prefix   = each.value.destination_address_prefix
  network_security_group_name  = azurerm_network_security_group.this.name
  resource_group_name          = azurerm_resource_group.this.name
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_windows_virtual_machine_scale_set" "this" {
  name                = var.scale_set_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Standard_D2s_v3"
  instances           = 2
  admin_username      = "adminuser"
  admin_password      = "Passw0rd123!"
  zones               = [1, 2, 3]
  upgrade_mode        = "Automatic"

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
    name    = "vmss-tf-nic"
    primary = true

    ip_configuration {
      name      = "ipconfig"
      subnet_id = azurerm_subnet.this.id
      public_ip_address {
        name = "vmss_pip"
      }
      load_balancer_backend_address_pool_ids = [ azurerm_lb_backend_address_pool.this.id ]
      load_balancer_inbound_nat_rules_ids    = [ azurerm_lb_nat_pool.this.id ]
    }
  }
}

resource "azurerm_virtual_machine_scale_set_extension" "this" {
  name                 = "iis"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.this.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "fileUris": ["${azurerm_storage_blob.this.url}"],
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File ${local_file.iis_script.filename}"
    }
SETTINGS
}

resource "azurerm_public_ip" "this" {
  name                = "vmss-tf-ip"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "this" {
  name                = "vmss-tf-lb"
  sku                 = "Standard"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  frontend_ip_configuration {
    name                 = "lb-frontend"
    public_ip_address_id = azurerm_public_ip.this.id
  }
}

resource "azurerm_lb_rule" "this" {
  loadbalancer_id                = azurerm_lb.this.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "lb-frontend"
  probe_id                       = azurerm_lb_probe.this.id
  backend_address_pool_ids       = [ azurerm_lb_backend_address_pool.this.id ]
}

resource "azurerm_lb_probe" "this" {
  loadbalancer_id = azurerm_lb.this.id
  name            = "tcpProbe"
  port            = 80
}

resource "azurerm_lb_backend_address_pool" "this" {
  loadbalancer_id = azurerm_lb.this.id
  name            = "bepool"
}

resource "azurerm_lb_nat_pool" "this" {
  resource_group_name            = azurerm_resource_group.this.name
  loadbalancer_id                = azurerm_lb.this.id
  name                           = "natpool"
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50003
  backend_port                   = 3389
  frontend_ip_configuration_name = "lb-frontend"
}