variable "nsg_name" {
  description = "Name of the Network Security Group"
  type = string
}

variable "location" {
  description = "Region of the Network Security Group"
  type = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type = string
}

variable "security_rules" {
  description = "List of security rules for the Network Security Group"
  type = map(object({
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "nsg_tags" {
  description = "Tags for the Network Security Group"
  type = map(string)
  default = {
    "environment" = "Development/Testing/Production"
    "owner"       = "Monarch Sharma"
    "Cloud"       = "Azure"
  }
}