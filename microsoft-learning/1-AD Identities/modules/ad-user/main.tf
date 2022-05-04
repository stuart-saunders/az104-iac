resource "random_password" "this" {
  length = var.secret_length
  special = var.special
  override_special = var.override_special
}

resource "azuread_user" "this" {
  user_principal_name = format(
    "%s@%s",
    var.user_principal_name,
    local.domain_name
  )
  display_name = var.user_principal_name

  password = random_password.this.result
  force_password_change = false

  department = var.department
  job_title  = var.job_title
}