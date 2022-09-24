output "vm_details" {
  value     = module.win_vm
  sensitive = true
}

resource "local_file" "ansible_inventory" {
  content = templatefile("ansible_inventory.tmpl",
    {
      vms = module.win_vm
      private_vm = module.win_vm["private"]
      public_vm  = module.win_vm["public"]
      nvm        = module.win_vm["nvm"]
    }
  )
  filename = "../config/inventory.yml"
}

resource "local_file" "host_vars" {
  for_each = module.win_vm

  content = templatefile("ansible_host_vars.tmpl",
    {
      public_ip_address = each.value.public_ip_address
      admin_username = each.value.admin_username
      admin_password = each.value.admin_password
      vm_name = each.value.name
    }
  )
  filename = "../config/host_vars/${each.key}.yml"
}