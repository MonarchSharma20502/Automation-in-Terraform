resource "azurerm_subnet" "nic-subnet" {
  name                 = var.nic_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnet_address_prefix
}

resource "azurerm_network_interface" "network_interface_card" {
  name                = var.nic_name
  location            = var.nic_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = azurerm_subnet.nic-subnet.id
    private_ip_address_allocation = var.private_ip_allocation_method
  }
  # If using existing subnet:
  # ip_configuration {
  #   name                          = var.ip_configuration_name
  #   subnet_id = data.azurerm_subnet.existing_subnet.id
  #   private_ip_address_allocation = var.private_ip_allocation_method
  # }
}