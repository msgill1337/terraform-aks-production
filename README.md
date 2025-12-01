# Production AKS Infrastructure Platform

Enterprise-grade Azure Kubernetes Service (AKS) deployment pipeline with Infrastructure as Code

---

## 🚀 Technology Stack

![Terraform](https://img.shields.io/badge/TERRAFORM-623CE4?style=for-the-badge&logo=terraform&logoColor=white)
![Azure](https://img.shields.io/badge/AZURE-0078D4?style=for-the-badge&logo=microsoft-azure&logoColor=white)
![Kubernetes](https://img.shields.io/badge/KUBERNETES-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Docker](https://img.shields.io/badge/DOCKER-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Azure Container Registry](https://img.shields.io/badge/ACR-0078D4?style=for-the-badge&logo=microsoft-azure&logoColor=white)

This repository contains Terraform modules to deploy a production-ready Azure Kubernetes Service (AKS) cluster with integrated networking, container registry, and monitoring capabilities. All infrastructure is defined as code, enabling version control, repeatability, and automated deployments.

---

## 📐 Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        Azure Cloud Infrastructure                       │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│                           NETWORKING MODULE                             │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │                   Virtual Network (VNet)                        │    │
│  │                                                                 │    │
│  │   ┌──────────────────────┐      ┌──────────────────────┐        │    │
│  │   │  AKS System Subnet   │      │ User Workload Subnet │        │    │
│  │   │ (prod-aks-subnet01)  │      │(prod-user-subnet01)  │        │    │
│  │   └──────────────────────┘      └──────────────────────┘        │    │
│  │          │                              │                       │    │
│  │          └──────────┬───────────────────┘                       │    │
│  │                     │                                           │    │
│  │          ┌──────────▼──────────────────────┐                    │    │
│  │          │ Network Security Group (NSG)    │                    │    │
│  │          │  • Outbound Rules               │                    │    │
│  │          └─────────────────────────────────┘                    │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
                                 │
                                 │ Subnet IDs
                                 ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                              AKS MODULE                                 │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │         Azure Kubernetes Service (AKS) Cluster                  │    │
│  │                                                                 │    │
│  │  ┌──────────────────────────────────────────────────────────┐   │    │
│  │  │              System Node Pool                            │   │    │
│  │  │  • Auto-scaling enabled                                  │   │    │
│  │  │  • VNet Integration (AKS Subnet)                         │   │    │
│  │  │  • Managed by AKS                                        │   │    │
│  │  └──────────────────────────────────────────────────────────┘   │    │
│  │                                                                 │    │
│  │  ┌──────────────────────────────────────────────────────────┐   │    │
│  │  │              User Node Pool                              │   │    │
│  │  │  • Auto-scaling enabled                                  │   │    │
│  │  │  • Availability Zones (1, 2)                             │   │    │
│  │  │  • VNet Integration (User Subnet)                        │   │    │
│  │  │  • User workloads                                        │   │    │
│  │  └──────────────────────────────────────────────────────────┘   │    │
│  │                                                                 │    │
│  │  Features:                                                      │    │
│  │  • System-assigned Managed Identity                             │    │
│  │  • Azure AD RBAC                                                │    │
│  │  • OMS Agent (connects to Log Analytics)                        │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                                 │                                       │
│                                 │ Principal ID                          │
│                                 ▼                                       │
└─────────────────────────────────────────────────────────────────────────┘
                                 │
                                 │ AcrPull Role Assignment
                                 ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                             ACR MODULE                                  │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │      Azure Container Registry (ACR) - Premium SKU               │    │
│  │                                                                 │    │
│  │  • Container Image Storage                                      │    │
│  │  • Georeplication                                               │    │
│  │                                                                 │    │
│  │    ┌────────────────┐         ┌────────────────┐                │    │
│  │    │   East US      │         │ North Europe   │                │    │
│  │    │Zone Redundancy │         │Zone Redundancy │                │    │
│  │    └────────────────┘         └────────────────┘                │    │
│  │                                                                 │    │
│  │  • Role: AcrPull (to AKS)                                       │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│                          MONITORING MODULE                              │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │              Log Analytics Workspace                            │    │
│  │                                                                 │    │
│  │  • Centralized Log Collection                                   │    │
│  │  • Container Logs                                               │    │
│  │  • Cluster Metrics                                              │    │
│  │  • Configurable Retention                                       │    │
│  │                                                                 │    │
│  │  ↑ OMS Agent collects logs from AKS Cluster                     │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│                         Resource Groups                                 │
│  • Networking Resource Group                                            │
│  • AKS Resource Group                                                   │
│  • ACR Resource Group                                                   │
│  • Monitoring Resource Group                                            │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 🏗️ Infrastructure Components

This Terraform configuration deploys a comprehensive Azure cloud infrastructure:

### **Networking Module** 🌐
- **Virtual Network (VNet)** with customizable address space
- **Dedicated Subnets** for AKS system node pool and user workloads
- **Network Security Groups (NSG)** with configurable security rules
- **Subnet-NSG Associations** for network-level security

### **Azure Kubernetes Service (AKS)** ☸️
- **Production-grade Kubernetes cluster** with Azure RBAC integration
- **System-assigned managed identity** for secure authentication
- **Azure AD Role-Based Access Control** for cluster management
- **Auto-scaling node pools** (system and user workloads)
- **Availability Zones** support for high availability
- **Virtual Network integration** for enhanced network security
- **OMS Agent integration** for centralized logging

### **Azure Container Registry (ACR)** 📦
- **Premium SKU container registry** with advanced features
- **Georeplication** for global container distribution
- **Role-based access control** with automatic AKS cluster integration
- **Secure image storage** with vulnerability scanning capabilities

### **Monitoring & Observability** 📊
- **Log Analytics Workspace** for centralized log collection
- **Configurable retention policies** for cost optimization
- **Integrated with AKS** for container and cluster monitoring

---

## 🎯 Infrastructure as Code (IaC) Benefits

### **Version Control & Collaboration**
- ✅ Complete infrastructure history in Git
- ✅ Pull request reviews for infrastructure changes
- ✅ Collaboration-friendly configuration management

### **Reproducibility & Consistency**
- ✅ Deploy identical environments (dev, staging, production)
- ✅ Eliminate manual configuration errors
- ✅ Standardized infrastructure patterns across teams

### **Risk Mitigation**
- ✅ `terraform plan` previews changes before application
- ✅ Rollback capabilities through version control
- ✅ Immutable infrastructure reduces configuration drift

### **Cost Optimization**
- ✅ Track infrastructure changes and associated costs
- ✅ Easy resource cleanup with `terraform destroy`
- ✅ Right-sizing through iterative configuration updates

### **Compliance & Governance**
- ✅ Infrastructure changes are auditable
- ✅ Policy enforcement through code reviews
- ✅ Security best practices codified in configuration

### **Automation & CI/CD Integration**
- ✅ Infrastructure changes via automated pipelines
- ✅ Environment provisioning on-demand
- ✅ Disaster recovery through automated rebuilds

---

## 📋 Prerequisites

- **Terraform** >= 1.5.0 ([Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli))
- **Azure CLI** ([Installation Guide](https://docs.microsoft.com/cli/azure/install-azure-cli))
- **Azure Subscription** with Contributor access
- **Azure AD Tenant ID** for RBAC configuration

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone <repository-url>
cd terraform-aks-production
```

### 2. Configure Variables

Copy the example variables file and customize it for your environment:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` and provide:

- **`subscription_id`**: Your Azure subscription ID (or use `ARM_SUBSCRIPTION_ID` environment variable)
- **`tenant_id`**: Your Azure AD tenant ID (within `kubernetes_cluster_configuration`)

> **⚠️ Security Note**: `terraform.tfvars` is gitignored. Never commit sensitive values.

### 3. Configure Terraform Backend

The backend configuration uses Azure Storage with Azure AD authentication. Configure using one of these methods:

**Option A: Partial Backend Configuration (Recommended)**

```bash
terraform init \
  -backend-config="resource_group_name=your-rg" \
  -backend-config="storage_account_name=your-storage" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=terraform.tfstate"
```

**Option B: Backend Configuration File**

Create a `backend.hcl` file (already in `.gitignore`):

```hcl
resource_group_name  = "terraform-state-rg"
storage_account_name = "tfstateyourstorage"
container_name       = "tfstate"
key                  = "terraform.tfstate"
```

Then initialize:

```bash
terraform init -backend-config=backend.hcl
```

### 4. Authenticate with Azure

```bash
# Login to Azure
az login

# Set your subscription
az account set --subscription <your-subscription-id>
```

### 5. Deploy Infrastructure

```bash
# Initialize Terraform
terraform init

# Review the deployment plan
terraform plan

# Apply the configuration
terraform apply
```

Type `yes` when prompted to confirm the deployment.

---

## 📖 Module Details

### **networking**
Creates the foundational networking infrastructure for the AKS cluster.

**Resources:**
- Resource Group
- Virtual Network
- Subnets (for AKS and user workloads)
- Network Security Group
- Security Rules
- Subnet-NSG Associations

**Outputs:**
- `vnet_id` - Virtual Network ID
- `subnet_ids` - Map of subnet names to IDs
- `nsg_id` - Network Security Group ID

---

### **aks**
Deploys the Azure Kubernetes Service cluster with production-ready configuration.

**Resources:**
- Resource Group
- AKS Cluster with:
  - System-assigned managed identity
  - Azure AD RBAC integration
  - OMS Agent for monitoring
  - System node pool (default)
  - User node pool (additional workloads)

**Features:**
- Auto-scaling enabled on both node pools
- Availability zones support
- Virtual Network integration
- Configurable Kubernetes version

**Outputs:**
- `principal_id` - Cluster identity principal ID (for ACR integration)

---

### **acr**
Provides container registry with enterprise features.

**Resources:**
- Resource Group
- Azure Container Registry (Premium SKU)
- Georeplication configurations
- Role assignment for AKS cluster (AcrPull)

**Features:**
- Georeplication for global distribution
- Zone redundancy support
- Automatic AKS cluster integration

**Outputs:**
- `acr_id` - Container Registry ID
- `acr_name` - Container Registry name
- `acr_login_server` - Login server URL
- `acr_admin_username` - Admin username (sensitive)
- `acr_admin_password` - Admin password (sensitive)

---

### **monitoring**
Sets up centralized logging and monitoring capabilities.

**Resources:**
- Resource Group
- Log Analytics Workspace

**Features:**
- Configurable retention period
- Integrated with AKS OMS Agent
- Per-GB pricing model

**Outputs:**
- `log_analytics_workspace_id` - Workspace ID

---

## 🔐 Security Best Practices

### **Secrets Management**
- ✅ All sensitive values are externalized to `terraform.tfvars` (gitignored)
- ✅ Variables marked with `sensitive = true` prevent accidental exposure
- ✅ No hardcoded secrets in source code
- ✅ Use environment variables for CI/CD pipelines

### **Network Security**
- ✅ Subnet isolation for AKS system and user workloads
- ✅ Network Security Groups with configurable rules
- ✅ Virtual Network integration (not public cluster)

### **Access Control**
- ✅ Azure AD RBAC for Kubernetes cluster access
- ✅ System-assigned managed identity (no service principal secrets)
- ✅ Role-based permissions for ACR access

### **Backend Security**
- ✅ Azure Storage backend with Azure AD authentication
- ✅ State file encryption at rest
- ✅ Backend configuration in gitignored files

---

## 🌍 Environment Variables

Set these environment variables as an alternative to `terraform.tfvars`:

| Variable | Description |
|----------|-------------|
| `ARM_SUBSCRIPTION_ID` | Azure subscription ID |
| `ARM_TENANT_ID` | Azure AD tenant ID |
| `ARM_CLIENT_ID` | Service principal client ID (if using) |
| `ARM_CLIENT_SECRET` | Service principal secret (if using) |

---

## 📊 Outputs

After deployment, Terraform provides these outputs:

- `VNET_ID` - Virtual Network identifier
- `acr_id` - Azure Container Registry ID
- `acr_login_server` - ACR login server URL
- `acr_name` - Container Registry name
- `subnet_ids` - Map of subnet names to IDs
- `law_id` - Log Analytics Workspace ID

To view all outputs:

```bash
terraform output
```

---

## 💰 Cost Estimation

Approximate monthly costs for a development environment:

| Component | Estimated Cost |
|-----------|---------------|
| AKS Cluster (1 node, Standard_D2_v2) | ~$70/month |
| Container Registry (Premium SKU) | ~$50/month |
| Log Analytics Workspace | ~$50-100/month (usage-based) |
| Virtual Network & Networking | ~$10/month |
| Storage (Backend) | ~$5/month |
| **Total** | **~$185-235/month** |

> **Note**: Costs vary based on usage, region, and node size. Use [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) for accurate estimates.

---

## 🧹 Cleanup

To destroy all resources created by this configuration:

```bash
terraform destroy
```

> **Warning**: This will permanently delete all resources. Ensure you have backups if needed.

---

## 📚 Additional Resources

- [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Kubernetes Service Documentation](https://docs.microsoft.com/azure/aks/)
- [Azure Container Registry Documentation](https://docs.microsoft.com/azure/container-registry/)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)

---

## 🤝 Contributing

1. Create a feature branch
2. Make your changes
3. Run `terraform fmt` and `terraform validate`
4. Submit a pull request

---

## 📝 License

This project is licensed under the MIT License.

---

## ⚠️ Important Notes

- **Never commit `terraform.tfvars`** - Contains sensitive information
- **Review `terraform plan`** before applying changes
- **Backup state files** before making significant changes
- **Test in non-production** environments first

---

**Built with ❤️ using Terraform and Azure**
