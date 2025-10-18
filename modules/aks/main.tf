resource "azurerm_resource_group" "this" {
  name = var.aks_resource_group_config.name
  location = var.aks_resource_group_config.location
}

resource "azurerm_log_analytics_workspace" "this" {
  name = var.aks_log_analytics_workspace_config.name
  location = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku = var.aks_log_analytics_workspace_config.sku
  retention_in_days = var.aks_log_analytics_workspace_config.retention_in_days

  depends_on = [azurerm_resource_group.this]
  tags = var.tags
}

resource "azurerm_kubernetes_cluster" "this" {
  name = var.kubernetes_cluster_configuration.name
  location = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix = var.kubernetes_cluster_configuration.dns_prefix
  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = var.kubernetes_cluster_configuration.azure_active_directory_role_based_access_control.azure_rbac_enabled
    tenant_id = var.kubernetes_cluster_configuration.azure_active_directory_role_based_access_control.tenant_id
  }
  default_node_pool {
    name = var.kubernetes_cluster_configuration.default_node_pool.name
    node_count = var.kubernetes_cluster_configuration.default_node_pool.node_count
    vm_size = var.kubernetes_cluster_configuration.default_node_pool.vm_size
    type = var.kubernetes_cluster_configuration.default_node_pool.type
    auto_scaling_enabled = var.kubernetes_cluster_configuration.default_node_pool.auto_scaling_enabled
    max_count = var.kubernetes_cluster_configuration.default_node_pool.max_count
    min_count = var.kubernetes_cluster_configuration.default_node_pool.min_count
    vnet_subnet_id = var.aks_node_pool_subnet_id
  }

  identity {
    type = var.kubernetes_cluster_configuration.identity.type
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  }
  tags = var.tags

  depends_on = [azurerm_log_analytics_workspace.this]

}

resource "azurerm_kubernetes_cluster_node_pool" "this" {
  name = var.kubernetes_node_pool_configuration.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size = var.kubernetes_node_pool_configuration.vm_size
  node_count = var.kubernetes_node_pool_configuration.node_count
  vnet_subnet_id = var.user_node_pool_subnet_id
  auto_scaling_enabled = var.kubernetes_node_pool_configuration.auto_scaling_enabled
  max_count = var.kubernetes_node_pool_configuration.max_count
  min_count = var.kubernetes_node_pool_configuration.min_count
  zones = var.kubernetes_node_pool_configuration.zones

  depends_on = [azurerm_kubernetes_cluster.this]
}