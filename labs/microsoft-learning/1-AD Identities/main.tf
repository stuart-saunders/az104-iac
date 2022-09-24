resource "azurerm_resource_group" "this" {
  name     = "${var.resource_name_prefix}-rg"
  location = var.location
}

module "ad_user" {
  for_each = { for user in local.users : user.username => user }  

  source              = "./modules/ad-user"
  user_principal_name = each.value.username
  display_name        = each.value.username
  department          = each.value.department
  job_title           = each.value.job_title
}

# resource "azuread_directory_role" "user_admin" {
#   display_name = "User administrator"
# }

# resource "azuread_directory_role_member" "example" {
#   role_object_id   = azuread_directory_role.user_admin.object_id
#   member_object_id = data.azuread_user.example.object_id
# }

resource "azuread_group" "dynamic_membership" {
  for_each = {for g in var.dynamic_groups: g.display_name => g}

  display_name     = each.value.display_name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = each.value.membership_rule
  }
}

resource "azuread_group" "assigned_membership" {
  display_name     = "IT Lab Administrators"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}

resource "azuread_group_member" "assigned_members" {
  for_each = azuread_group.dynamic_membership

  group_object_id  = azuread_group.assigned_membership.id
  member_object_id = each.value.id
}