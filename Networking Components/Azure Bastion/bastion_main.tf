
resource "azurerm_subnet" "azurebastionsubnet" {
  name                 = var.bastion_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name # This must be already existing
  address_prefixes     = var.bastion_subnet_address_prefixes
}

resource "azurerm_public_ip" "bastion_public_ip" {
  # for_each = var.
  name                = var.bastion_public_ip_name
  location            = azurerm_bastion_host.azurebastionhost.location
  resource_group_name = azurerm_bastion_host.azurebastionhost.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "azurebastionhost" {
  name                = "examplebastion"
  location            = var.azurebastion_location
  resource_group_name = azurerm_subnet.azurebastionsubnet.resource_group_name
  sku = var.azurebastion_sku

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.example.id
    public_ip_address_id = azurerm_public_ip.example.id
  }
}