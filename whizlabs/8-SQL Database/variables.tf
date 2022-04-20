variable "resource_name_prefix" {
  type        = string
  description = "The prefix to add to resource names"
  default     = "az104-whiz-lab8"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resource should exist"
  default     = "UK South"
}

//database
variable "db_administrator_login" {
  type = string
  description = "The administrator login name for the server"
  default = "db_admin"
}

# variable "db_administrator_password" {
#   type = string
#   description = "The administrator password for the server"
# }

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