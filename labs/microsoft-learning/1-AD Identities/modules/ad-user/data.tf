data "azuread_domains" "default" {
  only_default = true
}

locals {
  domain_name = data.azuread_domains.default.domains.0.domain_name
}