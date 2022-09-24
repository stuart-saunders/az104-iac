variable "resource_name_prefix" {
  type        = string
  description = "The prefix to add to resource names"
  default     = "az104-whiz-lab2"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resource should exist"
  default     = "UK South"
}

variable "script_filename" {
  type = string
  description = "The file name of the custom script to execute of the Virtual Machine"
  default = "script.sh"
}