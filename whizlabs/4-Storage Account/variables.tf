variable "resource_name_prefix" {
  type        = string
  description = "The prefix to add to resource names"
  default     = "az104-whiz-lab4"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resource should exist"
  default     = "UK South"
}

variable "blob_name" {
  type = string
  description = "The blob name"
  default = "lab4_blob.html"
}