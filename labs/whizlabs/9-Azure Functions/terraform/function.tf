resource "azurerm_storage_blob" "func_app" {
  # name                   = "${filesha256(data.archive_file.file_function_app.output_path)}.zip"
  name                   = "lab9_app.zip"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = "Block"
  source                 = data.archive_file.app.output_path
}