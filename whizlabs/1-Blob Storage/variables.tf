variable "resource_name_prefix" {
  type        = string
  description = "The prefix to add to resource names"
  default     = "whiz-az104-lab1"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resource should exist"
  default     = "UK South"
}

