variable "prefix" {
  type        = string
  description = "The prefix to add to resource names"
  default     = "az104-msl-lab5"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resource should exist"
  default     = "UK South"
}

variable "vnets" {
  type = map(object({
    address_space = string
    location      = string
  }))
  description = "The VNets to create"
  default = {
    vnet0 = {
      address_space = "10.50.0.0/22"
      location      = "uksouth"
    }
    vnet1 = {
      address_space = "10.51.0.0/22"
      location      = "uksouth"
    }
    vnet2 = {
      address_space = "10.52.0.0/22"
      location      = "ukwest"
    }
  }
}

variable "subnets" {
  type = map(object({
    subnet_name   = string
    address_space = string
    vnet_name     = string
  }))
  description = "The subnets to create"
  default = {
    vnet0_subnet = {
      subnet_name   = "subnet0"
      address_space = "10.50.0.0/24"
      vnet_name     = "vnet0"
    }
    vnet1_subnet = {
      subnet_name   = "subnet1"
      address_space = "10.51.0.0/24"
      vnet_name     = "vnet1"
    }
    vnet2_subnet = {
      subnet_name   = "subnet0"
      address_space = "10.52.0.0/24"
      vnet_name     = "vnet2"
    }
  }
}

variable "vms" {
  type = map(object({
    subnet = string
  }))
  description = "The VMs to create with the subnets in which they should exist"
  default = {
    vm0 = {
      subnet = "vnet0_subnet"
    }
    vm1 = {
      subnet = "vnet1_subnet"
    }
    vm2 = {
      subnet = "vnet2_subnet"
    }
  }
}

variable "peerings" {
  type        = map(list(string))
  description = "The pairs of networks to peer"
  default = {
    "0and1" = ["vnet0", "vnet1"]
    "0and2" = ["vnet0", "vnet2"]
    "1and2" = ["vnet1", "vnet2"]
  }
}