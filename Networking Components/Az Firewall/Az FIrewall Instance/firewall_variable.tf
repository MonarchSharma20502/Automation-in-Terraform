# PUBLIC IP VARIABLES
variable "public_ip_name" {
    description = "Name of the Public IP for the firewall"
    type = string
}

variable "public_ip_allocation_method" {
  description = "Select Static or Dynamic for allocation method"
  type = string
}

variable "public_ip_sku" {
  description = "SKU for the Public IP: Basic or Standard"
  type = string
}

# FIREWALL VARIABLES
variable "firewall_name" {
  description = "Name of the Firewall"
  type = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group for the firewall"
  type = string
}

variable "location" {
  description = "Location of the Firewall"
  type = string
}

variable "sku_name" {
  description = "Name of the SKU for the firewall: AZFW_VNet or AZFW_Hub"
  type = string
}

variable "firewall_policy_id" {
  description = "ID of the Firewall Policy"
  type = string
}

variable "sku_tier" {
  description = "Tier of the SKU for the firewall: Standard or Premium"
  type = string
}

variable "firewall_ip_configuration_name" {
  description = "Name of the IP configuration for the firewall"
  type = string
}

variable "subnet_id" {
  description = "ID for the subnet in which the public IP is"
  type = string
}