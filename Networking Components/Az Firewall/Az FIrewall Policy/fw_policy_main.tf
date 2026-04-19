resource "azurerm_firewall_policy" "firewall_policy" {
  name                = var.firewall_policy_name
  resource_group_name = var.resource_group_name
  location            = var.location

  dynamic "dns" {
    for_each = var.dns_servers == null ? [] : [var.dns_servers]
    content {
      servers = dns.value
    }
  }
  
}