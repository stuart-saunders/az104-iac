locals {
    config = {
      for i, v in var.subnets :
        i => ({ 
          "cidr_range"  = v,
          "subnet_name" = "subnet${i}",
          "vm_name"     = "vm${i}"
        })
    }
}