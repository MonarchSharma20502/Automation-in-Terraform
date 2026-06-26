# Subnet Variables
variable "nat_gw_subnet_name" {
  description = "Name of the Subnet on which NAT gateway will be attached"
  type = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type = string
}

variable "virtual_network_name" {
  description = "Name of the Virtual Network"
  type = string
}

variable "address_prefixes" {
  description = "Address prefixes of the subnet"
  type = list(string)
}

variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type = string
}

variable "location" {
  description = "Location of the NAT Gateway"
  type = string
}