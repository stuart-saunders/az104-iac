locals {
    resource_groups = tolist(var.resource_groups)

    vnet_subnet_map = merge([
        for vnet_key, vnet_value in var.network_resources:
        {
            for idx, subnet_value in vnet_value.subnets: 
                "${vnet_key}-subnet${idx}" => {
                    vnet_name = vnet_key
                    subnet_name = "${vnet_key}-subnet${idx}"
                    vnet_address_space = vnet_value.address_space
                    subnet_address_space = subnet_value.address_space
                    resource_group_name = vnet_value.resource_group_name
                    vms = subnet_value.vms
                    scale_sets = subnet_value.scale_sets
                }
        }
    ]...)

    vm_list = flatten(([
    for key, vnet_subnet_map_value in local.vnet_subnet_map:
        [
            for idx, value in vnet_subnet_map_value.vms:
                {
                    vm_name             = value.name
                    zone                = value.zone
                    private_ip_address  = value.private_ip_address
                    disks = value.disks
                    subnet_name         = vnet_subnet_map_value.subnet_name
                    resource_group_name = vnet_subnet_map_value.resource_group_name
                }
        ]
    ]))

    vm_map = { for idx, value in local.vm_list:
        value.vm_name => {
            subnet_name         = value.subnet_name
            zone                = value.zone
            private_ip_address  = value.private_ip_address
            resource_group_name = value.resource_group_name
            disks               = value.disks
        }
    }

    vm_disk_list = flatten([
        for vm_key, vm_value in local.vm_map:
        [
            for disk_idx, disk in vm_value.disks:
            {
                vm_name      = vm_key
                disk_name    = disk.name
                storage_type = disk.storage_type
                disk_size_gb = disk.size_gb
                zone         = vm_value.zone
                resource_group_name = vm_value.resource_group_name
            }
        ]
    ])

    vm_disks = { for idx, value in local.vm_disk_list:
        "${value.vm_name}-${value.disk_name}" => {
            vm_name      = value.vm_name
            disk_name    = value.disk_name
            storage_type = value.storage_type
            disk_size_gb = value.disk_size_gb
            zone         = value.zone
            resource_group_name = value.resource_group_name
        }
    }

    vmss_list = flatten(([
        for key, vnet_subnet_map_value in local.vnet_subnet_map:
        [
            for idx, value in vnet_subnet_map_value.scale_sets:
                {
                    scale_set_name      = value.name
                    private_ip          = value.private_ip
                    instances           = value.instances
                    zones               = value.zones
                    subnet_name         = vnet_subnet_map_value.subnet_name
                    resource_group_name = vnet_subnet_map_value.resource_group_name
                }
        ]
    ]))

    vmss_map = { for idx, value in local.vmss_list:
        value.scale_set_name => {
            private_ip          = value.private_ip
            instances           = value.instances
            zones               = value.zones
            subnet_name         = value.subnet_name
            resource_group_name = value.resource_group_name
        }
    }
}