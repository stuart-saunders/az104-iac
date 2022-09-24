module "key_vault" {
  source = "./modules/key-vault"  
  key_vault_name = "${var.prefix}${formatdate("DDMMhhmm", timestamp())}kv"  
  resource_group_name = azurerm_resource_group.this.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  purge_protection_enabled    = false
  enabled_for_disk_encryption = true
  network_acls_default_action = "Allow"

  policies = {
    full = {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = data.azurerm_client_config.current.object_id
      key_permissions         = []
      secret_permissions      = var.kv_secret_permissions_full
      certificate_permissions = []
      storage_permissions     = []
    }
  }
}

resource "azurerm_key_vault_secret" "vm_password" {
  for_each = module.win_vm

  name         = "${each.value.name}-password"
  value        = module.win_vm["${each.key}"].admin_password
  key_vault_id = module.key_vault.id

  depends_on = [module.key_vault.access_policy_ids]
}