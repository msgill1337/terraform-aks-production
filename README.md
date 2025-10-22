# Production AKS Platform

Terraform infrastructure for deploying production-grade AKS on Azure.

## Architecture
[Simple diagram]

## Prerequisites
- Terraform >= 1.5.0
- Azure CLI
- Contributor access

## Quick Start
```bash
cd environments/dev
terraform init -backend-config=../../backend.tf
terraform plan
terraform apply
```

## Modules
- networking: VNet, subnets, NSG
- aks: AKS cluster with system + user node pools
- acr: Container registry
- monitoring: Log Analytics

## Cost
~$200-300/month for dev environment