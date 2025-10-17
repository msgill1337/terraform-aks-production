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

variable "resource_group_config" {
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