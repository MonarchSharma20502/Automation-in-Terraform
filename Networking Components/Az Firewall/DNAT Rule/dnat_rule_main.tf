resource "azurerm_firewall_nat_rule_collection" "dnat_rule_collection" {
  name                = var.dnat_rule_collection_name
  azure_firewall_name = var.firewall_name
  resource_group_name = var.resource_group_name
  priority            = var.priority
  action              = var.action

  dynamic "rule" {
    for_each = length(var.dnat_rules) > 0 ? var.dnat_rules : {}
    content {
      name                  = rule.key
      source_addresses      = rule.value.source_addresses
      source_ip_groups      = lookup(rule.value, "source_ip_groups", null)
      destination_addresses = lookup(rule.value, "destination_addresses", null)
      destination_ports     = rule.value.destination_ports
      translated_address    = rule.value.translated_address
      translated_port       = rule.value.translated_port
      protocols             = rule.value.protocols
    }
  }

}
