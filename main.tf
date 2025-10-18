terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {
  }
  subscription_id = "860e5706-a4d0-4c7c-89c9-4bd4aaeee4ad"
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

module "aks" {
  source = "./modules/aks"
  aks_node_pool_subnet_id = module.networking.subnet_ids["prod-aks-subnet01"]
  user_node_pool_subnet_id = module.networking.subnet_ids["prod-user-subnet01"]
  kubernetes_cluster_configuration = var.kubernetes_cluster_configuration
  tags = var.tags
  kubernetes_node_pool_configuration = var.kubernetes_node_pool_configuration
  aks_resource_group_config = var.aks_resource_group_config
  aks_log_analytics_workspace_config = var.aks_log_analytics_workspace_config
  depends_on = [module.networking]
}

output "VNET_ID" {
  value = module.networking.vnet_id
}