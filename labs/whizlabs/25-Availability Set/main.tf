resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_availability_set" "this" {
  name                        = "${var.prefix}-av-set"
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  platform_fault_domain_count = 2
}

module "linux_vm" {
  for_each = var.vms

  source  = "./modules/linux-vm"
  vm_name = each.value

  ip_configuration_name = "internal"
  subnet_id             = azurerm_subnet.this.id
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
  availability_set_id   = azurerm_availability_set.this.id
}