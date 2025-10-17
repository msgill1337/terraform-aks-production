resource_group_config = {
    name = "tf-aks-networking-rg"
    location = "canadacentral"
}

vnet_configuration = {
    name = "tf-aks-vnet01"
    
    address_space = ["100.0.0.0/8"]
    
}

subnet_configuration = [
    {
        name = "prod-aks-subnet01"
        address_prefixes = ["100.0.0.0/24"]
        
    },
    {
        name = "prod-user-subnet01"
        address_prefixes = ["100.1.0.0/24"]
       
    }
]

tags = {
    orchestrator = "terraform"
    appName = "testApp"
    environment = "dev"
}

nsg_configuration = {
    name = "AKS-PROD"
}


 nsg_rules = [
    {
      name = "DenyInbound-BasicRule"
      priority = 100
      direction = "Inbound"
      access = "Deny"
      protocol = "Tcp"
      source_port_range = "*"
      destination_port_range = "*"
      source_address_prefix = "*"
      destination_address_prefix = "*"
    },
    {
      name = "DenyOutBound-BasicRule"
      priority = 100
      direction = "Outbound"
      access = "Deny"
      protocol = "Tcp"
      source_port_range = "*"
      destination_port_range = "*"
      source_address_prefix = "*"
      destination_address_prefix = "*"
    }
 ]