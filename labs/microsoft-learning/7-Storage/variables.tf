variable "prefix" {
  type        = string
  description = "The prefix to add to resource names"
  default     = "az104-mslearning-lab7"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resource should exist"
  default     = "UK South"
}

variable "vnet_address_space" {
  type    = string
  default = "10.70.0.0/22"
}

variable "subnet_address_space" {
  type    = string
  default = "10.70.0.0/24"
}