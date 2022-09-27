resource "azurerm_resource_group" "require_tag" {
  name     = "${var.resource_name_prefix}-require-tag-rg"
  location = var.location
}

resource "azurerm_resource_group_policy_assignment" "require_tag_and_value" {
  name                 = "require-tag-and-value-on-resources-assigment"
  resource_group_id    = azurerm_resource_group.require_tag.id
  policy_definition_id = data.azurerm_policy_definition.require_tag_value_on_resources.id

  parameters = <<PARAMS
    {
      "tagName": {
        "value": "Role"
      },
      "tagValue": {
        "value": "Infra"
      }
    }
PARAMS
}

resource "azurerm_storage_account" "tagged" {
  name                     = "az104msllab2b${formatdate("DDMMhhmmss", timestamp())}"
  resource_group_name      = azurerm_resource_group.require_tag.name
  location                 = azurerm_resource_group.require_tag.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Role = "Infra"
  }
}

resource "azurerm_resource_group" "inherit_tag" {
  name     = "${var.resource_name_prefix}-inherit-tag-rg"
  location = var.location

  tags = {
    Role = "Infra"
  }
}

resource "azurerm_storage_account" "untagged" {
  name                     = "az104msllab2b${formatdate("DDMMhhmmss", timestamp())}"
  resource_group_name      = azurerm_resource_group.inherit_tag.name
  location                 = azurerm_resource_group.inherit_tag.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_resource_group_policy_assignment" "inherit_tag_and_value" {
  name                 = "inherit-tag-and-value-on-from-rg"
  resource_group_id    = azurerm_resource_group.inherit_tag.id
  location             = azurerm_resource_group.inherit_tag.location
  policy_definition_id = data.azurerm_policy_definition.inherit_tag_value_from_rg.id

  identity {
    type = "SystemAssigned"
  }

  parameters = <<PARAMS
    {
      "tagName": {
        "value": "Role"
      }
    }
PARAMS

  # Ensure untagged resource exists before Policy assignment is created, so that tag can be remediated
  depends_on = [ azurerm_storage_account.untagged ]
}

resource "azurerm_resource_group_policy_remediation" "inherit_tag_and_value_policy_remediation" {
  name                 = "inherit-tag-and-value-on-from-rg-remediation"
  resource_group_id    = azurerm_resource_group.inherit_tag.id
  policy_assignment_id = azurerm_resource_group_policy_assignment.inherit_tag_and_value.id
}