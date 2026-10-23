
variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "subnetId" {
  type = string
}

variable "windows_vm_name" {
  type = string
}

variable "nic_name" {
  type = string
}

variable "public_ip_name" {
  type    = string
  default = null
}

variable "computerName" {
  type = string
}

variable "osdiskName" {
  type = string
}

variable "public_ip_sku" {
  type    = string
  default = "Standard"
}

variable "public_ip_allocation_method" {
  type    = string
  default = "Static"
}

# variable "admin_password" {
#   type        = string
#   description = "Virtual Machine Password"
# }

variable "vmConfig" {
  type = object({
    vmSize                        = string
    adminUsername                 = string
    caching                       = string
    storageAccountType            = string
    availabilityZone              = string
    publisher                     = string
    offer                         = string
    sku                           = string
    version                       = string
    nicIpConfiguration            = string
    nicPrivateIpAddressAllocation = string
  })
}
variable "ipconfig" {
  type = map(object({
    subnet_id                     = string
    private_ip_address_allocation = string
    primary                       = bool
    private_ip_address_version    = string
  }))

  validation {
    condition     = length(var.ipconfig) > 0
    error_message = "The ipconfig variable must contain at least one IP configuration."
  }
}

variable "identity_type" {
  description = "Managed Identity Type: SystemAssigned or UserAssigned"
  type = string
  default = "SystemAssigned"

  validation {
    condition = contain(["SystemAssigned", "UserAssigned"], var.identity_type)
    error_message = "The value of identity_type variable must be among: 'SystemAssigned', 'UserAssigned'"

  }
}