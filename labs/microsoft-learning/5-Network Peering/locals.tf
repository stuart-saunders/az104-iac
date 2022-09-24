locals {
  vms = { for vm_key, vm_value in var.vms :
    vm_key => flatten([
      for subnet_key, subnet_value in var.subnets :
      flatten([
        for vnet_key, vnet_value in var.vnets :
        {
          vnet_name   = subnet_value.vnet_name
          location    = vnet_value.location
          subnet_key  = subnet_key
          subnet_name = subnet_value.subnet_name
        }
        if vnet_key == subnet_value.vnet_name
      ])
      if subnet_key == vm_value.subnet
    ])
  }

  peerings = { for k, v in var.peerings :
    k => {
      first  = v[0]
      second = v[1]
    }
  }
}