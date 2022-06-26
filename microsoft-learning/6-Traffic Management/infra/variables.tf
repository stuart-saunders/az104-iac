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
    vnet1_appgw = {
      subnet_name   = "appgw"
      address_space = "10.60.3.224/27"
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
  # type = map(object({
  #   subnet_key           = string
  #   enable_ip_forwarding = optional(bool)
  # }))
  description = "The VMs to create with the subnets in which they should exist"
  default = {
    vm0 = {
      subnet_key           = "vnet1_subnet0"
      enable_ip_forwarding = true
    }
    vm1 = {
      subnet_key = "vnet1_subnet1"
    }
    vm2 = {
      subnet_key = "vnet2_subnet0"
    }
    vm3 = {
      subnet_key = "vnet3_subnet0"
    }
  }
}

variable "lb_backend_pool_vms" {
  type = set(string)
  default = ["vm0", "vm1"]
}

variable "peerings" {
  type        = map(list(string))
  description = "The pairs of networks to peer"
  default = {
    "1and2" = ["vnet1", "vnet2"]
    "1and3" = ["vnet1", "vnet3"]
  }
}

# variable "route_table" {
#   default =  {
#     name = "route-vnet2-to-vnet3"
#     address_prefix = "10.63.0.0/20"
#     next_hop_type = "VirtualAppliance"
#     next_hop_in_ip_address = "10.60.0.4"
#     vnet = "vnet2"
#     subnet = "subnet0"
#   }
# }

variable "route_table" {
  type = map(object({
    subnet                 = string
    route_name             = string
    route_address_prefix   = string
    route_next_hop_type    = string
    route_next_hop_address = string
  }))
  description = "The Route Tables and Routes to create"
  default = {
    rt23 = {
      subnet                 = "vnet2_subnet0"
      route_name             = "vnet2-to-vnet3"
      route_address_prefix   = "10.63.0.0/20"
      route_next_hop_type    = "VirtualAppliance"
      route_next_hop_address = "10.60.0.4"
    }
    rt32 = {
      subnet                 = "vnet3_subnet0"
      route_name             = "vnet3-to-vnet2"
      route_address_prefix   = "10.62.0.0/20"
      route_next_hop_type    = "VirtualAppliance"
      route_next_hop_address = "10.60.0.4"
    }
  }
}