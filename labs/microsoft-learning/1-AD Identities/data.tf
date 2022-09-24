data "azuread_client_config" "current" {}

data "azuread_domains" "default" {
  only_default = true
}

locals {
  users = csvdecode(file("${path.module}/users.csv"))
}