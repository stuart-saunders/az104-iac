resource "azurerm_resource_group" "rg0" {
  name     = "${var.prefix}-rg0"
  location = var.location
}

resource "azurerm_resource_group" "rg1" {
  name     = "${var.prefix}-rg1"
  location = var.location
}

module "win_vm" {
  source  = "./modules/windows-vm"
  vm_name = "vm0"

  ip_configuration_name = "ipconfig"
  subnet_id             = azurerm_subnet.this.id
  location              = azurerm_resource_group.rg0.location
  resource_group_name   = azurerm_resource_group.rg0.name
}