variable "law_resource_group_config" {
  type = object({
    name = string
    location = string
  })
}

variable "log_analytics_workspace_config" {
  type = object({
    name = string
    sku = string
    retention_in_days = number
  })
}

variable "tags" {
    type = object({
      orchestrator = string
      environment = string
      appName = string
    })
}