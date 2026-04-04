
resource "azurerm_firewall_application_rule_collection" "application_rule_collection" {
  name                = var.application_rule_collection_name
  azure_firewall_name = var.firewall_name
  resource_group_name = var.resource_group_name
  priority            = var.priority
  action              = var.action

  dynamic "rule" {
    for_each = length(var.application_rules) > 0 ? var.application_rules : {}
    content {
      name             = rule.key
      source_addresses = rule.value.source_addresses
      source_ip_groups = try(rule.value.source_ip_groups, null)
      target_fqdns     = try(rule.value.target_fqdns, null)
      protocol {
        port = try(rule.value.port, null)
        type = try(rule.value.protocol_type, null)
      }
    }
  }
}
