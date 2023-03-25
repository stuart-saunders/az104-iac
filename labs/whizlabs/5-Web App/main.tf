resource "azurerm_resource_group" "this" {
  name     = "whizlabs-lab5-rg"
  location = "uksouth"
}

resource "azurerm_service_plan" "this" {
  name                = "whizlabs-lab5-plan"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  os_type = "Linux"
  sku_name = "B1"
}

resource "azurerm_linux_web_app" "this" {
  name                = "whizlabs-lab5-app"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    application_stack {
      docker_image     = "nginx"
      docker_image_tag = "latest"
    }
  }
}