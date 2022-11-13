data "archive_file" "app" {
  type        = "zip"
  source_dir  = "../src/func-app"
  output_path = "func-app.zip"
}

data "azurerm_storage_account_blob_container_sas" "this" {
  connection_string = azurerm_storage_account.this.primary_connection_string
  container_name    = azurerm_storage_container.this.name

  start  = local.start
  expiry = local.expiry

  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = false
  }
}

locals {
  start  = timestamp()
  expiry = timeadd(local.start, "720h") # 30 days
}