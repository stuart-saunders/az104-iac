data "azurerm_policy_definition" "require_tag_value_on_resources" {
  display_name = "Require a tag and its value on resources"
}

data "azurerm_policy_definition" "inherit_tag_value_from_rg" {
  display_name = "Inherit a tag from the resource group if missing"
}

