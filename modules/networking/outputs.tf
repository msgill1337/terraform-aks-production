output "vnet_id" {
    value = azurerm_virtual_network.this.id
    description = "ID of the VNET"
}

output "nsg_id" {
    value = azurerm_network_security_group.this.id
    description = "ID of the NSG"
}

output "subnet_ids" {
    value = { for k,v in azurerm_subnet.this : k => v.id }
    description = "Map of subnets names to their IDs"
}