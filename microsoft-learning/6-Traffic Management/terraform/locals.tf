locals {
    peerings = { for k, v in var.peerings :
        k => {
        first  = v[0]
        second = v[1]
        }
    }

    # vnets = { for subnet_key, subnet_value in var.vnets.subnets :
    #     subnet_key => {
    #         address_space = subnet_value.address_space
    #     }
    # }

    # vnets = { for vnet_key, vnet_value in var.vnets :
    #     # vnet_key => { for subnet_key, subnet_value in vnet_value.subnets :
    #     #     subnet_key => {
    #     #         address_space = subnet_value.address_space
    #     #     }
    #     # }
    #     vnet_key => flatten([ for subnet_key, subnet_value in vnet_value.subnets :
    #       {
    #           subnet_name = subnet_key
    #           address_space = subnet_value.address_space
    #       }
    #     ])
    # }

    # subnets = flatten([ for vnet_key, vnet_value in var.vnets :
    #     # { for subnet_key, subnet_value in vnet_value.subnets :
    #     #     "${vnet_key}-${subnet_key}" => {
    #     #         vnet = vnet_key
    #     #         subnet = subnet_key
    #     #         subnet_address_space = subnet_value.address_space
    #     #     # subnet_value =>  vnet_value
    #     #     }
    #     # }
    #     { for subnet_key, subnet_value in vnet_value.subnets :
    #         "${vnet_key}-${subnet_key}" => {
    #             vnet = vnet_key
    #             subnet = subnet_key
    #             subnet_address_space = subnet_value.address_space
    #         }
    #     }
    # ])

    # => Produces...
    # subnets = [
    #   + {
    #       + vnet1-subnet0 = {
    #           + subnet               = "subnet0"
    #           + subnet_address_space = "10.60.0.0/24"
    #           + vnet                 = "vnet1"
    #         }
    #       + vnet1-subnet1 = {
    #           + subnet               = "subnet1"
    #           + subnet_address_space = "10.60.1.0/24"
    #           + vnet                 = "vnet1"
    #         }
    #     },
    #   + {
    #       + vnet2-subnet0 = {
    #           + subnet               = "subnet0"
    #           + subnet_address_space = "10.62.0.0/24"
    #           + vnet                 = "vnet2"
    #         }
    #     },
    #   + {
    #       + vnet3-subnet0 = {
    #           + subnet               = "subnet0"
    #           + subnet_address_space = "10.63.0.0/24"
    #           + vnet                 = "vnet3"
    #         }
    #     },
    # ]

    # => Desired... 
    # subnets = { 
    #     vnet1-subnet0 = {
    #         subnet               = "subnet0"
    #         subnet_address_space = "10.60.0.0/24"
    #         vnet                 = "vnet1"
    #     }
    #     vnet1-subnet1 = {
    #         subnet               = "subnet1"
    #         subnet_address_space = "10.60.1.0/24"
    #         vnet                 = "vnet1"
    #     }
    #     vnet2-subnet0 = {
    #         subnet               = "subnet0"
    #         subnet_address_space = "10.62.0.0/24"
    #         vnet                 = "vnet2"
    #     }
    #     vnet3-subnet0 = {
    #         subnet               = "subnet0"
    #         subnet_address_space = "10.63.0.0/24"
    #         vnet                 = "vnet3"
    #     }
    # }
}