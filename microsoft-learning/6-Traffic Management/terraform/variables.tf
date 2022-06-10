variable "prefix" {
  type        = string
  description = "The prefix to add to resource names"
  default     = "az104-msl-lab6"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resource should exist"
  default     = "UK South"
}

variable "vnets" {
  type = map(object({
    address_space = string
    # subnets = map(object({
    #   # name          = string
    #   address_space = string
    # }))
  }))
  description = "The VNets to create"
  default = {
    vnet1 = {
      address_space = "10.60.0.0/22"
      # subnets = {
      #   subnet0 = {
      #     address_space = "10.60.0.0/24"
      #   },
      #   subnet1 = {
      #     address_space = "10.60.1.0/24"
      #   }
      # }
    }
    vnet2 = {
      address_space = "10.62.0.0/22"
      # subnets = {
      #   subnet0 = {
      #     address_space = "10.62.0.0/24"
      #   }
      # }
    }
    vnet3 = {
      address_space = "10.63.0.0/22"
      # subnets = {
      #   subnet0 = {
      #     address_space = "10.63.0.0/24"
      #   }
      # }
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
    vnet1_subnet0 = {
      subnet_name   = "subnet0"
      address_space = "10.60.0.0/24"
      vnet_name     = "vnet1"
    }
    vnet1_subnet1 = {
      subnet_name   = "subnet1"
      address_space = "10.60.1.0/24"
      vnet_name     = "vnet1"
    }
    vnet2_subnet0 = {
      subnet_name   = "subnet0"
      address_space = "10.62.0.0/24"
      vnet_name     = "vnet2"
    }
    vnet3_subnet0 = {
      subnet_name   = "subnet0"
      address_space = "10.63.0.0/24"
      vnet_name     = "vnet3"
    }
  }
}

variable "vms" {
  type = map(object({
    subnet_key = string
  }))
  description = "The VMs to create with the subnets in which they should exist"
  default = {
    vm0 = {
      subnet_key = "vnet1_subnet0"
    }
    # vm1 = {
    #   subnet_key = "vnet1_subnet1"
    # }
    # vm2 = {
    #   subnet_key = "vnet2_subnet0"
    # }
    # vm3 = {
    #   subnet_key = "vnet3_subnet0"
    # }
  }
}

variable "peerings" {
  type        = map(list(string))
  description = "The pairs of networks to peer"
  default = {
    "1and2" = ["vnet1", "vnet2"]
    "1and3" = ["vnet1", "vnet3"]
  }
}