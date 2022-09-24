variable "user_principal_name" {
  type = string
  description = "The user principal name (UPN) of the user"
}

variable "display_name" {
  type = string
  description = "The name to display in the address book for the user"
}

variable "department" {
  type = string
  description = "The name for the department in which the user works"
}

variable "job_title" {
  type = string
  description = "The user's job title"
}

//password
variable "secret_length" {
  type        = number
  description = "Length of the secret"
  default     = 20
}

variable "special" {
  type        = bool
  description = "Special characters in secret"
  default     = true
}

variable "override_special" {
  type        = string
  description = "Special override characters"
  default     = "_%@"
}