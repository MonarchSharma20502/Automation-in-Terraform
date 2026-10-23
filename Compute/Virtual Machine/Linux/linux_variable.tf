variable "linux_vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
}
variable "os_disk_name" {
  description = "Name of the OS Disk"
  type        = string
}
variable "tags" {
  description = "Tags to be applied to the virtual machine"
  type        = map(string)
}
variable "nic_name" {
  description = "Name of the network interface card"
  type        = string
}
variable "public_ip_sku" {
  description = "SKU of the Public IP Address. Valid options: Basic, Standard."
  type    = string
  default = "Standard"
}

variable "public_ip_name" {
  description = "Name of the Public IP"
  type        = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnetId" {
  type = string
}

# Tags
# variable "cloud" {
#   description = "Cloud environment"
#   type        = string
# }
# variable "environment" {
#   description = "Environment"
#   type        = string
# }
# variable "author" {
#   description = "Author"
#   type        = string
# }



variable "vmConfig" {
  description = "Virtual Machine Configurations"
  type = object({
    vmSize                          = string
    vmAdminUsername                 = string
    vmAdminPassword                 = string
    vmPublisher                     = string
    vmOffer                         = string
    vmSku                           = string
    vmSkuVersion                    = string
    availabilityZone                = string
    vmCaching                       = string
    vmDiskSizeGB                    = string
    # Storage_account_type or vmManagedDiskType can only have: Standard_LRS, Premium_LRS, StandardSSD_LRS, or UltraSSD_LRS as valid inputs
    vmManagedDiskType               = string
    vmDisablePasswordAuthentication = string
    nicIpConfiguration              = string
    nicPrivateIpAddressAllocation   = string
    # publicIPAllocationMethod        = string
  })
}

variable "secure_boot_enabled" {
  type    = bool
  default = false
}

variable "private_ip_address_version" {
  type    = string
  default = "IPv4"
}

variable "enable_accelerated_networking" {
  type    = bool
  default = true
}

variable "vtpm_enabled" {
  type    = bool
  default = false
}

variable "ipconfig" {
  type = map(object({
    subnet_id                     = string
    private_ip_address_allocation = string
    primary                       = bool
  }))

  validation {
    condition     = length(var.ipconfig) == 0
    error_message = "The ipconfig variable must contain at least one IP configuration."
  }
}