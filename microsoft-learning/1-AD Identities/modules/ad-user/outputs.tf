output "credentials" {
    value = {
        username = azuread_user.this.user_principal_name,
        password = azuread_user.this.password
    }
    sensitive = true
}

# output "username" {
#   value = azuread_user.this.user_principal_name
# }

# output "password" {
#     value = azuread_user.this.password
#     sensitive = true
# }