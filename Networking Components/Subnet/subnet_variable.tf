variable "resource_group_name" {
  description = "Name of Resource Group in which subnet exists"
  type = string
}
variable "subnet_name" {
  description = "Match the names of subnets with virtual network names"
  type = string
}
variable "virtual_network_name" {
  description = "Name of the Virtual Network in which the subnets exist"
  type = string
}
variable "subnet_address_space" {
  description = "Address prefix for the subnet"
  type = list(string)
}
variable "delegations" {
  description = "Information for the Delegations of the Subnets"
  type = map(object({
    delegation_name = string
    service_delegation_name = string
    actions = list(string)
  }))
}