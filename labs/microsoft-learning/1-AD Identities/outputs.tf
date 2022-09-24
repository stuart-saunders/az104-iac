output "user_credentials" {
    # value = {
    #     for k, u in module.ad_user : k => u.password
    # }
    
    value = {
        for k, u in module.ad_user :
            k => ({
                # "username" = u.username,
                # "password" = u.password,
                "credentials" = u.credentials
            })
    }
    sensitive = true
}

# output "user_list" {
#     value = [
#       for u in module.ad_user : u.username
#     ]
# }

output "dynamic_groups" {
    value = azuread_group.dynamic_membership
}

output "assigned_members" {
    value = azuread_group_member.assigned_members
}