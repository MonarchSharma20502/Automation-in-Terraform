
resource "azurerm_firewall_network_rule_collection" "network_rule_collection" {
  name                = var.network_rule_collection_name
  azure_firewall_name = var.firewall_name
  resource_group_name = var.resource_group_name
  priority            = var.priority
  action              = var.action

  dynamic "rule" {
    for_each = length(var.network_rules) > 0 ? var.network_rules : {}
    content {
      name                  = rule.key
      source_addresses      = rule.value.source_addresses
      source_ip_groups      = lookup(rule.value, "source_ip_groups", null)
      destination_addresses = lookup(rule.value, "destination_addresses", null)
      destination_ip_groups = lookup(rule.value, "destination_ip_groups", null)
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
    }
  }
}