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

variable "azurebastion_public_ip_configuration" {
  description = "Public Ip configuration of Azure Bastion Host Service"
  type = object({
    name = string
    location = string
    resource_group_name = string
    allocation_method = string
    sku = string
  })
  default = null
  validation {
    condition = contains(["Static", "Dynamic"], var.azurebastion_public_ip_configuration.allocation_method)
    error_message = "The allocation method of the Azure Bastion Public IP Service must be one of 'Static', or 'Dynamic'" 
  }
  validation {
    condition = contains(["Basic","Standard"],var.azurebastion_public_ip_configuration.sku)
    error_message = "The SKU of the Azure Bastion Public IP must be one of 'Basic', 'Standard'"
  }
}

# Azure Bastion Variables

variable "azure_bastion_host_name" {
  description = "Name of the Azure Bastion Service"
  type = string
}
variable "resource_group_name" {
  description = "Name of the Azure Bastion Subnet"
  type = string
}

variable "virtual_network_name" {
  description = "Name of the Vnet for the Bastion subnet and bastion host service"
  type = string
}

variable "azure_bastion_host_location" {
  description = "Location of the Bastion service, subnet and public IP (if applicable)"
  type = string
}

variable "azure_bastion_host_sku" {
  description = "Tier of the Azure Bastion Host Service"
  type = string
  validation {
    condition = contains(["Basic", "Standard", "Premium"], var.azure_bastion_host_sku)
    error_message = "The SKU of the Azure Bastion Host Service must be one of 'Basic', 'Standard', or 'Premium'"
  }
}