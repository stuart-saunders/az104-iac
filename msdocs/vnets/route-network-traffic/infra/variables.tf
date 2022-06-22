variable "prefix" {
  type        = string
  description = "The prefix to add to resource names"
  default     = "az104-msdocs-route"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resource should exist"
  default     = "UK South"
}

variable "vnet" {
  type = map(string)
  description = "The Virtual Network details"
  default = {
    "name"          = "vnet0"
    "address_space" = "10.0.0.0/16"
  }
}

variable "subnets" {
  default = {
    public = {
      name          = "public"
      address_space = "10.0.0.0/24"
    }
    private = {
      name          = "private"
      address_space = "10.0.1.0/24"
    }
    dmz = {
      name          = "dmz"
      address_space = "10.0.2.0/24"
    }
    bastion = {
      name          = "AzureBastionSubnet"
      address_space = "10.0.3.0/24"
    }
  }
}

variable "vms" {
  type        = set(string)
  description = "The names of the VMs to create"
  default     = ["public", "private", "nvm"]
}