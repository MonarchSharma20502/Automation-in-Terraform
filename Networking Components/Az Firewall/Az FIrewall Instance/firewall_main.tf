resource "azurerm_public_ip" "firewall_public_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}


resource "azurerm_firewall" "firewall" {
  name = var.firewall_name
  resource_group_name = var.resource_group_name
    location = var.location
    sku_name = var.sku_name
    firewall_policy_id = var.firewall_policy_id
    sku_tier = var.sku_tier

    ip_configuration {
      name = var.firewall_ip_configuration_name
      subnet_id = var.subnet_id
      public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
    }
}