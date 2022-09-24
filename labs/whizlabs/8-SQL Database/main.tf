resource "azurerm_resource_group" "this" {
  name     = "${var.resource_name_prefix}-rg"
  location = var.location
}

resource "random_password" "db_admin" {
  length = var.secret_length
  special = var.special
  override_special = var.override_special
}

resource "azurerm_storage_account" "this" {
  name                     = "ssaz104whizlab8${formatdate("DDMMhhmm", timestamp())}"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_mssql_server" "this" {
  name                         = "ssaz104whizlab8${formatdate("DDMMhhmm", timestamp())}"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = azurerm_resource_group.this.location
  version                      = "12.0"
  administrator_login          = var.db_administrator_login
  administrator_login_password = random_password.db_admin.result
}

resource "azurerm_mssql_database" "this" {
  name           = "WhizDb"
  server_id      = azurerm_mssql_server.this.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "BC_Gen5_2"
  zone_redundant = false
}

resource "azurerm_mssql_firewall_rule" "my_ip" {
  name             = "My IP"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = local.my_ip_json.ip
  end_ip_address   = local.my_ip_json.ip
}