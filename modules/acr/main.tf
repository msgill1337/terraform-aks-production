resource "azurerm_resource_group" "this" {
  name = var.acr_resource_group_config.name
  location = var.acr_resource_group_config.location
}

resource "azurerm_container_registry" "this" {
  name = var.acr_config.name
  location = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku = var.acr_config.sku
  admin_enabled = var.acr_config.admin_enabled
  dynamic "georeplications" {
    for_each = var.acr_config.georeplications
    content {
      location = georeplications.value.location
      zone_redundancy_enabled = georeplications.value.zone_redundancy_enabled
    }
  }
}

resource "azurerm_role_assignment" "this" {
  principal_id = var.aks_principal_id
  role_definition_name = var.acr_role_assignment.role_definition_name
  skip_service_principal_aad_check = var.acr_role_assignment.skip_service_principal_aad_check
  scope = azurerm_container_registry.this.id
}