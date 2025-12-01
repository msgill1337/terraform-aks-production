provider "azurerm" {
  features {
  }
  subscription_id = var.subscription_id != "" ? var.subscription_id : null
}

resource "azurerm_resource_group" "tf-aks-rg" {
  name = var.vnet_resource_group_config.name
  location = var.vnet_resource_group_config.location
}

module "networking" {
  source = "./modules/networking"
  vnet_configuration = var.vnet_configuration
  subnet_configuration = var.subnet_configuration
  nsg_rules = var.nsg_rules
  vnet_resource_group_config = var.vnet_resource_group_config
  tags = var.tags
  nsg_configuration = var.nsg_configuration
}

module "monitoring" {
  source = "./modules/monitoring"
  law_resource_group_config = var.law_resource_group_config
  log_analytics_workspace_config = var.log_analytics_workspace_config
  tags = var.tags
}

module "aks" {
  source = "./modules/aks"
  aks_node_pool_subnet_id = module.networking.subnet_ids["prod-aks-subnet01"]
  user_node_pool_subnet_id = module.networking.subnet_ids["prod-user-subnet01"]
  kubernetes_cluster_configuration = var.kubernetes_cluster_configuration
  tags = var.tags
  kubernetes_node_pool_configuration = var.kubernetes_node_pool_configuration
  aks_resource_group_config = var.aks_resource_group_config
  log_analytics_workspaces_id = module.monitoring.log_analytics_workspace_id
  depends_on = [module.networking]
}

module "acr" {
  source = "./modules/acr"
  acr_config = var.acr_config
  aks_principal_id = module.aks.principal_id
  acr_role_assignment = var.acr_role_assignment
  acr_resource_group_config = var.acr_resource_group_config
  depends_on = [module.aks]
}

output "VNET_ID" {
  value = module.networking.vnet_id
}

output "acr_id" {
  description = "The ID of the Azure Container Registry"
  value       = module.acr.acr_id
}

output "acr_login_server" {
  description = "The login server URL for the ACR"
  value       = module.acr.acr_login_server
}

output "acr_name" {
  description = "The name of the ACR"
  value       = module.acr.acr_name
}

output "subnet_ids" {
    value = module.networking.subnet_ids
    description = "Map of subnets names to their IDs"
}

output "law_id" {
  value = module.monitoring.log_analytics_workspace_id
  description = "ID of the LAW"
}