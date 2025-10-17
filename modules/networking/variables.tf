variable "resource_group_config" {
  type = object({
    name = string
    location = string
  })
}

variable "vnet_configuration" {
  type = object({
    name = string
    address_space = list(string)
  })
}

variable "subnet_configuration" {
    type = list(object({
      name = string
      address_prefixes = list(string)
    }))
  
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

variable "tags" {
    type = object({
      orchestrator = string
      environment = string
      appName = string
    })
}