variable "route_table_name" {
  description = "Name of the Route Table"
  type = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group for the route table"
  type = string
}
variable "location" {
  description = "Location of the Route Table"
  type = string
}

variable "subnet_id" {
  description = "ID of the Subnet on which the Route Table is associated"
  type = string
}
variable "routes" {
  description = "Routes in the route table"
  type = list(object({
    route_name = string
    address_prefix = string
    next_hop_type = string
    next_hop_ip_address = optional(list(string))
  }))
}