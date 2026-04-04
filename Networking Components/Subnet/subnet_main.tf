resource "azurerm_subnet" "subnets" {
  name = var.subnet_name
  address_prefixes = var.subnet_address_space
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  dynamic "delegation" {
    for_each = var.delegations != {} ? var.delegations : {}
    content {
      name = delegation.value.delegation_name
      service_delegation {
        name = delegation.value.service_delegation_name
        actions = delegation.value.actions
      }
    }
  }
}