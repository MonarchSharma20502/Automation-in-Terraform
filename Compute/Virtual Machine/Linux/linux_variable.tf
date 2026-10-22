variable "vmName" {
  description = "Name of the Virtual Machine"
  type        = string
}


variable "vmStorageOsDiskName" {
  description = "Name of the OS Disk"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the virtual machine"
  type        = map(string)
}

variable "nicName" {
  description = "Name of the network interface card"
  type        = string
}
# variable "publicIpSku" {
#   type    = string
#   default = "Standard"
# }

# variable "publicIpName" {
#   description = "Name of the Public IP"
#   type        = string
# }

variable "rgName" {
  type = string
}

variable "location" {
  type = string
}

variable "subnetId" {
  type = string
}

variable "vmConfig" {
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