resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_storage_account" "this" {
  name                     = "ssaz104whizlab9${formatdate("DDMMhhmm", timestamp())}"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "this" {
  name                  = "lab9"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "blob"
}

resource "azurerm_service_plan" "this" {
  name                = "${var.prefix}-plan"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Windows"
  sku_name            = "Y1"
}

resource "azurerm_windows_function_app" "this" {
  name                = "${var.prefix}-function-app"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  service_plan_id      = azurerm_service_plan.this.id
  storage_account_name = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"    = "https://${azurerm_storage_account.this.name}.blob.core.windows.net/${azurerm_storage_container.this.name}/${azurerm_storage_blob.func_app.name}${data.azurerm_storage_account_blob_container_sas.this.sas}",
    "FUNCTIONS_WORKER_RUNTIME"    = "dotnet",
    "AzureWebJobsDisableHomepage" = "true",
  }

  site_config {}
}