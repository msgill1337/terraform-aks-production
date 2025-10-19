terraform {
  backend "azurerm" {
    resource_group_name = "terraform-state-vscode"
    storage_account_name = "tfstatevscode012"
    container_name = "tfstate"
    key = "terraform.tfstate"
    # use_azuread_auth = true
  }

  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.0"
    }
  }
}