output "admin_password" {
    value = random_password.db_admin.result
    sensitive = true
}