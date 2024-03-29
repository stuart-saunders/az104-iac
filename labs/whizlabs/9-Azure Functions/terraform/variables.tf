variable "prefix" {
  type        = string
  description = "The prefix to add to resource names"
  default     = "az104-whiz-lab9"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resource should exist"
  default     = "UK South"
}