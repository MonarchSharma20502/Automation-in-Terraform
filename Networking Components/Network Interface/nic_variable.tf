# Resource Variables
variable "resource_group_name" {
  description = "Name of the Resource Group for Subnet, Vnet and the NIC on the subnet (Must be same)"
  type = string
}

variable "subnet_address_prefix" {
  description = "CIDR range for the target subnet"
  type = list(string)
}

variable "nic_name" {
  description = "Name of the Network Interface Card"
  type = string
}

variable "nic_location" {
  description = "Location/Region of the NIC"
  type = string
}

variable "nic_subnet_name" {
  description = "Name of the subnet for attaching NIC"
  type = string
}

# IP configuration Variables
variable "ip_configuration_name" {
  description = "Name of the IP Configuration"
  type = string
}

variable "private_ip_allocation_method" {
  description = "Private Ip allocation method: Static or Dynamic"
  type = string
  validation {
    condition = contains(["Static", "Dynamic"],var.private_ip_allocation_method)
    error_message = "Please enter a valid private IP allocation method."
  }
}


# Data Block Variables
variable "virtual_network_name" {
  description = "Name of the Virtual Network for the NIC subnet"
  type = string
}

variable "existing_subnet_name" {
  description = "Name of the subnet"
  type = string
}