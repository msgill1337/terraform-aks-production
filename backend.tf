# Backend configuration using partial configuration
# Provide backend settings via -backend-config flags or backend.hcl file
# See README.md section "Configure Terraform Backend" for instructions
#
# Example backend configuration (uncomment and customize, or use partial config):
#
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "your-terraform-state-rg"
#     storage_account_name = "yourterraformstorage"
#     container_name       = "tfstate"
#     key                  = "terraform.tfstate"
#     use_azuread_auth     = true
#   }
# }