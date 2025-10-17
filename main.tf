terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "tf-aks-rg" {
  name = var.resource_group_config.name
  location = var.resource_group_config.location
}

module "networking" {
  source = "./modules/networking"
  vnet_configuration = var.vnet_configuration
  subnet_configuration = var.subnet_configuration
  nsg_rules = var.nsg_rules
  resource_group_config = var.resource_group_config
  tags = var.tags
  nsg_configuration = var.nsg_configuration
}

output "VNET_ID" {
  value = module.networking.vnet_id
}