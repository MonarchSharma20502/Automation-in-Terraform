variable "dnat_rule_collection_name" {
  description = "Name of the dnat rule collection"
  type = string
}

variable "firewall_name" {
  description = "Name of the Firewall"
  type = string
}

variable "resource_group_name" {
  description = "Name of the resource group of Firewall"
  type = string
}

variable "priority" {
  description = "Priority of the rule collection"
  type = number
}

variable "action" {
  description = "Action for the rule: Allow or Deny"
  type = string
}

variable "dnat_rules" {
  description = "Map for the rules in the Rule Collection"
  type = map(object({
    source_addresses      = list(string)
    source_ip_groups      = optional(list(string))
    destination_addresses = optional(list(string))
    destination_ports     = list(string)
    translated_address    = string
    translated_port       = string
    protocols             = list(string)
  }))
}