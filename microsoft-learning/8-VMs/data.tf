# data "azurerm_resource_group" "this" {
#   for_each = var.resource_groups
#   name = each.value.name
# }
