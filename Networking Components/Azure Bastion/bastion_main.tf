
resource "azurerm_subnet" "azurebastionsubnet" {
  name                 = var.bastion_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name # This must be already existing
  address_prefixes     = var.bastion_subnet_address_prefixes
}

# This block only runs when the SKU is not Premium. It iterates over the public IP configuration variable and creates a public IP resource for the Bastion. We directly passed a map object to the for_each argument, which allows us to access the properties of the public IP configuration variable using each.value.<property_name> syntax. This is a more concise and efficient way to create the public IP resource, as it avoids the need for a separate variable or data source to hold the public IP configuration.
resource "azurerm_public_ip" "bastion_public_ip" {
  for_each = var.azure_bastion_host_sku == "Premium" ? {} : {"bastion_public_ip" = var.azurebastion_public_ip_configuration}
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_bastion_host" "azurebastionhost" {
  name                = var.azure_bastion_host_name
  location            = var.azure_bastion_host_location
  resource_group_name = azurerm_subnet.azurebastionsubnet.resource_group_name
  sku = var.azure_bastion_host_sku

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.azurebastionsubnet.id
    public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
  }
}