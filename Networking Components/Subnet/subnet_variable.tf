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
# Delegation is not tightly coupled with the subnet, so we can keep it as a separate variable. This will allow us to create subnets without delegations if needed. We'll combine it with the subnet variable when we create the resources in WORKLOAD.
variable "delegations" {
  description = "Information for the Delegations of the Subnets"
  type = map(object({
    delegation_name = string
    service_delegation_name = string
    actions = list(string)
  }))
}
# When we go with the Resource creation in WORKLOAD, we'll use this approach (the subnets will be resource group specific i.e., this variable includes the subnets for Vnets in the same RG):
# variable "subnets" {
#   type = map(object({
#     subnet_name = string
#     virtual_network_name = string
#     subnet_address_space = list(string)

#     delegations = map(object({
#       name    = string
#       service = string
#       actions = list(string)
#     }))
#   }))
# }