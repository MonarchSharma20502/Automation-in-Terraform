variable "application_rule_collection_name" {
  description = "Name of the Application Rule"
  type = string
}

variable "firewall_name" {
  description = "Name of the firewall"
  type = string
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

variable "application_rules" {
  description = "Application Rule inside the application collection"
  type = map(object({
    source_addresses      = list(string)
    source_ip_groups      = optional(list(string))
    target_fqdns          = optional(list(string))
    port                  = optional(string)
    type                  = optional(string)
  }))
}
