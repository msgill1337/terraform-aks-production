#variables.tf

variable "location" {
  type = string
  description = "Location to deploy the resources"
  default = "canadacentral"
}

variable "vnet_configuration" {
  type = object({
    name = string
    address_space = list(string)  
  })
  description = "Virtual network configuration"
}

variable "subnet_configuration" {
  type = list(object({
    name = string
    address_prefixes = list(string)
  }))
  description = "List of subnets with name and address space"
}

variable "vnet_resource_group_config" {
  type = object({
    name = string
    location = string
  })
  
}

variable "tags" {
  type = object ({
    orchestrator = string
    environment = string
    appName = string
  })
}

variable "nsg_configuration" {
  type = object({
    name = string
  })
}

variable "nsg_rules" {
    type = list(object({
        name = string
        priority = number
        direction = string
        access = string
        protocol = string
        source_port_range = string
        destination_port_range = string
        source_address_prefix = string
        destination_address_prefix = string
    }))  
}

variable "kubernetes_cluster_configuration" {
    type = object({
      name = string
      dns_prefix = string
      kubernetes_version = string
      azure_active_directory_role_based_access_control = object({
        azure_rbac_enabled = bool
        tenant_id = string
      })
      default_node_pool = object({
        name = string
        node_count = number
        vm_size = string
        auto_scaling_enabled = bool
        type = string
        min_count = number
        max_count = number
      })

      identity = object({
        type = string
      })
    })
}

variable "kubernetes_node_pool_configuration" {
  type = object({
    name = string
    vm_size = string
    node_count = number
    auto_scaling_enabled = bool
    max_count = number
    min_count = number
    zones = list(string)
  })

}

variable "aks_resource_group_config" {
  type = object({
    name = string
    location = string
  })
}

variable "aks_log_analytics_workspace_config" {
  type = object({
    name = string
    sku = string
    retention_in_days = number
  })
}
