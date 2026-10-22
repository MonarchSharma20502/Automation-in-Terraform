
variable "location" {
  type = string
}

variable "rgName" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "subnetId" {
  type = string
}

variable "vmName" {
  type = string
}

variable "nicName" {
  type = string
}

variable "publicIpName" {
  type    = string
  default = null
}

variable "computerName" {
  type = string
}

variable "osdiskName" {
  type = string
}

variable "publicIpSku" {
  type    = string
  default = "Standard"
}

variable "publicIpAllocationMethod" {
  type    = string
  default = "Static"
}

variable "admin_password" {
  type = string
  description = "Virtual Machine Password"
}

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
