resource "azurerm_resource_group" "this" {
  name = var.resource_group_config.name
  location = var.resource_group_config.location
}

resource "azurerm_virtual_network" "this" {
  name = var.vnet_configuration.name
  location = azurerm_resource_group.this.location
  address_space = var.vnet_configuration.address_space
  resource_group_name = azurerm_resource_group.this.name
  tags = var.tags
}

resource "azurerm_subnet" "this" {

  for_each = { for subnet in var.subnet_configuration : subnet.name => subnet }
  name = each.key
  resource_group_name = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes = each.value.address_prefixes
}

resource "azurerm_network_security_group" "this" {
  name = var.nsg_configuration.name
  resource_group_name = azurerm_resource_group.this.name
  location = azurerm_resource_group.this.location
}

resource "azurerm_network_security_rule" "this" {
  for_each = { for rule in var.nsg_rules : rule.name => rule }
  name = each.key
  priority = each.value.priority
  access = each.value.access
  resource_group_name = azurerm_resource_group.this.name
  source_port_range = each.value.source_port_range
  protocol = each.value.protocol
  network_security_group_name = azurerm_network_security_group.this.name
  direction = each.value.direction
  destination_port_range = each.value.destination_port_range
  source_address_prefix = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = { for subnet in var.subnet_configuration : subnet.name => subnet }
  subnet_id = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this.id
}