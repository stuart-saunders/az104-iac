variable "prefix" {
  type        = string
  description = "The prefix to add to resource names"
  default     = "az104-mslearning-lab8"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resource should exist"
  default     = "UK South"
}

variable "resource_groups" {
  type = set(string)
  default = ["rg1", "rg2"]
}

variable "network_resources" {
   type = map(object({
    address_space = string
    resource_group_name = string
    subnets = list(object({
      name = string
      address_space = string
      vms = list(object({
        name               = string
        zone               = string
        private_ip_address = string
        disks = list(object({
          name         = string
          storage_type = string
          size_gb      = string
        }))
      }))
      scale_sets = list(object({
        name        = string
        private_ip  = string
        instances   = number
        zones       = list(string)
      }))
    }))
  }))
  description = "The hierarchy of Vnets, Subnets, Address Spaces, VM Scale Sets, VMs and disks"
  default = {
    vnet1 = {
      address_space       = "10.80.0.0/20"
      resource_group_name = "rg1"
      subnets = [
        {
          name          = "subnet0"
          address_space = "10.80.0.0/24"
          vms = [
            {
              name               = "vm0"
              zone               = "1"
              private_ip_address = "10.80.0.4"
              disks = [
                {
                  name              = "datadisk0"
                  storage_type      = "Premium_LRS"
                  size_gb           = "1"
                },
                {
                  name              = "datadisk1"
                  storage_type      = "Premium_LRS"
                  size_gb           = "1"
                }
              ]
            },
            {
              name               = "vm1"
              zone               = "2"
              private_ip_address = "10.80.0.5"
              disks = [
                {
                  name         = "datadisk0"
                  storage_type = "Premium_LRS"
                  size_gb      = "1"
                },
                {
                  name         = "datadisk1"
                  storage_type = "Premium_LRS"
                  size_gb      = "1"
                }
              ]
            }
          ]
          scale_sets = []
        }
      ]
    }
    vnet2 = {
      address_space       = "10.82.0.0/20"
      resource_group_name = "rg2"
      subnets = [
        {
          name          = "subnet0"
          address_space = "10.82.0.0/24"
          vms           = []
          scale_sets    = [
            {
              name        = "vmss0"
              private_ip  = "10.82.0.4"
              instances   = 2
              zones       = [1, 2, 3]
            }
          ]
        }
      ]
    }
  }
}

variable "iis_script_filename" {
  type = string
  description = "The name of the local script file containing the VM extension script"
  default = "install_iis.ps1"
}