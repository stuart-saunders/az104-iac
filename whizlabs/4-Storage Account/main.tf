resource "azurerm_resource_group" "this" {
  name     = "${var.resource_name_prefix}-rg"
  location = var.location
}

resource "azurerm_storage_account" "this" {
  name                     = "ssaz104whizlab4${formatdate("DDMMhhmm", timestamp())}"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "this" {
  name                  = "lab4"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "blob"
}

resource "local_file" "blob" {
    content  = "<h1>Whizlabs AZ-104 Lab4</h1>"
    filename = "./${var.blob_name}"
}

resource "azurerm_storage_blob" "this" {
  name                   = var.blob_name
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = "Block"
  source                 = var.blob_name
  content_type           = "text/html"
}

resource "azurerm_storage_share" "this" {
  name                 = "lab4-share"
  storage_account_name = azurerm_storage_account.this.name
  quota                = 50
}

resource "azurerm_storage_share_file" "this" {
  name             = var.blob_name
  storage_share_id = azurerm_storage_share.this.id
  source           = var.blob_name
  content_type           = "text/html"
}