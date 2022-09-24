data "azurerm_subscription" "this" { }

data "azuread_client_config" "this" { }

data "http" "my_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

data "azurerm_storage_account_blob_container_sas" "this" {
  connection_string = azurerm_storage_account.this.primary_connection_string
  container_name    = azurerm_storage_container.this.name
  https_only        = true

  start  = "${timeadd(timestamp(), "-24h")}"
  expiry = "${timeadd(timestamp(), "24h")}"

  permissions {
    read   = true
    add    = true
    create = false
    write  = false
    delete = true
    list   = true
  }
}