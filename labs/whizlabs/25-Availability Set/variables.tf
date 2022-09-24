variable "prefix" {
  type        = string
  description = "The prefix to add to resource names"
  default     = "az104-whiz-lab25"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resource should exist"
  default     = "UK South"
}

variable "vms" {
  type        = set(string)
  description = "The list of VMs to deploy"
  default     = ["vm1", "vm2"]
}