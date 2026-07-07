# Bastion Subnet variables
variable "bastion_subnet_name" {
  description = "Name of the Azure Bastion Subnet"
  type = string
  default = "AzureBastionSubnet"
}

variable "bastion_subnet_address_prefixes" {
  description = "Address prefixes for the Azure Bastion Subnet"
  type = list(string)
}


# Public Ip configurations (If tier is not Premium)

variable "bastion_public_ip_name" {
  description = "Name of the Azure Bastion Public IP"
  type = string
}

variable "bastion_public_ip_sku" {
  description = "SKU of the Azure Bastion Public IP"
  type = string
  default = "Standard"
}


# Azure Bastion Variables

variable "resource_group_name" {
  description = "Name of the Azure Bastion Subnet"
  type = string
}

variable "virtual_network_name" {
  description = "Name of the Vnet for the Bastion subnet and bastion host service"
  type = string
}

variable "azurebastion_location" {
  description = "Location of the Bastion service, subnet and public IP (if applicable)"
  type = string
}

variable "azurebastion_sku" {
  description = "Tier of the Azure Bastion Host Service"
  type = string
  validation {
    condition = contains(["Basic", "Standard", "Premium"], var.azurebastion_sku)
    error_message = "The SKU of the Azure Bastion Host Service must be one of 'Basic', 'Standard', or 'Premium'"
  }
}