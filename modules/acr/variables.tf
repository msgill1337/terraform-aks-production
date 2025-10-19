variable "acr_resource_group_config" {
  type = object({
    name = string
    location = string
  })
}

variable "acr_config" {
  type = object({
    name = string
    sku = string
    admin_enabled = bool
    georeplications = list(object({
      location = string
      zone_redundancy_enabled = bool
    }))
  })
}

variable "acr_role_assignment" {
  type = object({
    role_definition_name = string
    skip_service_principal_aad_check = bool
  })
}

variable "aks_principal_id" {
  type = string
}