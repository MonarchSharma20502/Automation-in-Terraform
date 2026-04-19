variable "firewall_policy_name" {
  description = "Name of the Firewall Policy"
  type = string
}

variable "dns_servers" {
  description = "List of DNS servers"
  type = list(string)
}

variable "location" {
  description = "Location of Firewall Policy"
  type = string
}

variable "resource_group_name" {
  description = "Name of the RG of Firewall Policy"
  type = string
}