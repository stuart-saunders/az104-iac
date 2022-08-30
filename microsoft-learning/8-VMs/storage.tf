# resource "azurerm_storage_account" "rg1_sa" {
#   name                     = "az104msllab8rg1${formatdate("DDMMhhmm", timestamp())}"
#   resource_group_name      = azurerm_resource_group.this["rg1"].name
#   location                 = azurerm_resource_group.this["rg1"].location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

# resource "azurerm_storage_container" "rg1_scripts" {
#   name                  = "scripts"
#   storage_account_name  = azurerm_storage_account.rg1.name
#   container_access_type = "blob"
# }

# resource "azurerm_storage_blob" "rg1_script" {
#   name                   = var.script_filename
#   storage_account_name   = azurerm_storage_account.rg1.name
#   storage_container_name = azurerm_storage_container.rg1.name
#   type                   = "Block"
#   source                 = var.script_filename
#   content_type           = "text/plain"
# }

# resource "azurerm_storage_account" "rg2_sa" {
#   name                     = "az104msllab8rg2${formatdate("DDMMhhmm", timestamp())}"
#   resource_group_name      = azurerm_resource_group.this["rg2"].name
#   location                 = azurerm_resource_group.this["rg2"].location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

# resource "azurerm_storage_container" "rg2_scripts" {
#   name                  = "scripts"
#   storage_account_name  = module.win_vmss[0].boot_diagnostics_storage_account_name
#   container_access_type = "blob"
# }

# resource "azurerm_storage_blob" "rg2_script" {
#   name                   = var.script_filename
#   storage_account_name   = azurerm_storage_account.rg2.name
#   storage_container_name = azurerm_storage_container.rg2.name
#   type                   = "Block"
#   source                 = var.script_filename
#   content_type           = "text/plain"
# }

# Create a storage account for each Resource Group
# Create a scripts container, and upload the IIS config script
# resource "azurerm_storage_account" "this" {
#   for_each = var.resource_groups

#   name                     = "az104msllab8${each.value}${formatdate("DDMMhhmm", timestamp())}"
#   resource_group_name      = azurerm_resource_group.this[each.value].name
#   location                 = azurerm_resource_group.this[each.value].location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

resource "azurerm_storage_account" "this" {
  name                     = "az104msllab8${formatdate("DDMMhhmm", timestamp())}"
  resource_group_name      = azurerm_resource_group.this[local.resource_groups[0]].name
  location                 = azurerm_resource_group.this[local.resource_groups[0]].location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "this" {
  # for_each = var.resource_groups

  name                  = "scripts"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "this" {
  # for_each = var.resource_groups

  name                   = var.iis_script_filename
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = "Block"
  source                 = var.iis_script_filename
  content_type           = "text/plain"
}