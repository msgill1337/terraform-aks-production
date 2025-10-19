resource "azurerm_resource_group" "this" {
  name = var.law_resource_group_config.name
  location = var.law_resource_group_config.location
  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "this" {
  name = var.log_analytics_workspace_config.name
  location = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku = var.log_analytics_workspace_config.sku
  retention_in_days = var.log_analytics_workspace_config.retention_in_days

  depends_on = [azurerm_resource_group.this]
  tags = var.tags
}