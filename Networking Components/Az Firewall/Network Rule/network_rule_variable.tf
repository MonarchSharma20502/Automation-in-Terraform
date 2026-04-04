variable "network_rule_collection_name" {
  description = "Name of the Network Rule"
  type = string
}

variable "firewall_name" {
  description = "Name of the firewall"
  type = string
}

variable "network_rules" {
  description = "Network Rule inside the network collection"
  type = map(object({
    source_addresses      = list(string)
    source_ip_groups      = optional(list(string))
    destination_addresses = list(string)
    destination_ip_groups = optional(list(string))
    destination_ports     = list(string)
    protocols             = list(string)
  }))
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type = string
}

variable "priority" {
  description = "Priority of the Rule Collection"
  type = number
}

variable "action" {
  description = "Actions: Allow or Deny"
  type = string
}