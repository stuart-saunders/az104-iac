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

resource "azurerm_storage_account" "this" {
  name                     = "ssaz104msllab7${formatdate("DDMMhhmm", timestamp())}"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "this" {
  name                  = "lab7"
  storage_account_name  = azurerm_storage_account.this.name
}

resource "azurerm_storage_blob" "this" {
  name                   = "licences/LICENCE"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = "Block"
  source                 = "LICENCE"
  content_type           = "text/plain"
  access_tier            = "Hot"
}

resource "azurerm_role_assignment" "this" {
  scope                = data.azurerm_subscription.this.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_client_config.this.object_id
}

resource "azurerm_storage_share" "this" {
  name                 = "share"
  storage_account_name = azurerm_storage_account.this.name
  quota                = 50
}

resource "azurerm_storage_account_network_rules" "this" {
  storage_account_id = azurerm_storage_account.this.id

  default_action             = "Deny"
  ip_rules                   = [local.my_ip]
  virtual_network_subnet_ids = [azurerm_subnet.this.id]  
}