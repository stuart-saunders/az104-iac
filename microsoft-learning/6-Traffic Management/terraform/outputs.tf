# output "" {
#     value = ""
# }

# output "vnets" {
#   value = local.vnets
# }

# output "subnets" {
#   value = local.subnets
# }

output "vm_details" {
  value     = module.win_vm
  sensitive = true
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl",
    {
      vms = module.win_vm
      # key_vault_name = "kv" # module.key_vault.name
    }
  )
  filename = "../config/inventory.yml"
}

resource "local_file" "ansible_vars" {
  content = templatefile("vars.tmpl",
    {
      vm = module.win_vm
    }
  )
  filename = "../config/vars.yml"
}