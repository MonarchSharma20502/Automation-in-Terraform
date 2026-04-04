variable "virtual_network_name" {
  description = "Name of the Virtual Network"
  type = string
}

variable "location" {
  description = "Location of Vnet"
  type = string
}

variable "virtual_network_address_space" {
  description = "CIDR ranges of the Virtual Network"
  type = list(string)
}

variable "resource_group_name" {
  description = "Name of the RG in which the virtual network exists"
  type = string
}