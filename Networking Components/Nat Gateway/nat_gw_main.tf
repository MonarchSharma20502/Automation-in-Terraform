resource "azurerm_subnet" "nat_gw_subnet" {
  name                 = var.nat_gw_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}


resource "azurerm_nat_gateway" "nat_gateway" {
  name                = var.nat_gateway_name
  location            = var.location
  resource_group_name = azurerm_subnet.nat_gw_subnet.resource_group_name
}

resource "azurerm_subnet_nat_gateway_association" "nat_gateway_subnet_association" {
  subnet_id      = azurerm_subnet.nat_gw_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}

# If using existing subnet:
# resource "azurerm_subnet_nat_gateway_association" "nat_gateway_subnet_association" {
#   subnet_id      = data.azurerm_subnet.existing_subnet.id
#   nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
# }
