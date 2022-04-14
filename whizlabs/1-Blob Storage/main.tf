resource "azurerm_resource_group" "this" {
  name     = "${var.resource_name_prefix}-rg"
  location = "UK South"
}

resource "azurerm_storage_account" "this" {
  name                     = "sswhizlabs1${formatdate("DDMMhhmm", timestamp())}"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "this" {
  name                  = "whizlabs1${formatdate("DDMMhhmm", timestamp())}"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "blob"
}

resource "local_file" "lab1_file" {
    content  = "<h1>Whizlabs AZ-104 Lab1</h1>"
    filename = "./lab1_blob.html"
}

resource "azurerm_storage_blob" "lab1_blob" {
  name                   = "lab1_blob.html"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = "Block"
  source                 = "lab1_blob.html"
  content_type           = "text/html"
}