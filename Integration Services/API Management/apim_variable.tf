variable "name" {
  description = "Specifies the name of the API Management service."
  type        = string
}

variable "location" {
  description = "The Azure location where the resource should exist."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the API Management service."
  type        = string
}

variable "publisher_name" {
  description = "The name of the publisher/company."
  type        = string
}

variable "publisher_email" {
  description = "The email address of the publisher."
  type        = string
}

variable "sku_name" {
  description = "The SKU name of the API Management service. Valid options: Developer, Basic, Standard, Premium, Isolated."
  type        = string
}

variable "client_certificate_enabled" {
  description = "Should client certificate be enabled on the API Management service?"
  type        = bool
  default     = false
}

variable "gateway_disabled" {
  description = "Whether the Gateway is disabled."
  type        = bool
  default     = false
}

variable "min_api_version" {
  description = "The minimum API version to use for this API Management instance."
  type        = string
  default     = null
}

variable "zones" {
  description = "A list of Availability Zones to use for this API Management instance."
  type        = list(string)
  default     = []
}

variable "notification_sender_email" {
  description = "Email address from which the notification will be sent."
  type        = string
  default     = null
}

variable "public_ip_address_id" {
  description = "The ID of the Public IP Address to use with the API Management service."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for the API Management service."
  type        = bool
  default     = true
}
######################################## default = "None"
variable "virtual_network_type" {
  description = "The type of virtual network integration. Possible values are 'None', 'External', or 'Internal'."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "additional_location" {
  description = "A map of additional locations to deploy API Management instances to, including VNET config."
  type = map(object({
    location             = string
    capacity             = optional(number)
    zones                = optional(list(string))
    public_ip_address_id = optional(string)
    gateway_disabled     = optional(bool)
    virtual_network_configuration = object({
      subnet_id = string
    })
  }))
  default = {}
}

variable "certificates" {
  description = "A map of certificates to associate with the API Management service."
  type = map(object({
    encoded_certificate  = string
    store_name           = string
    certificate_password = optional(string)
  }))
  default = {}
}

variable "identity" {
  description = "The identity block for the API Management service."
  type = object({
    identity_type = string
    identity_ids  = optional(list(string))
  })
  default = null
}

variable "protocols" {
  description = "Enable or disable HTTP/2 support."
  type = object({
    enable_http2 = bool
  })
  default = null
}

variable "sign_in" {
  description = "Whether user sign-in is enabled."
  type = object({
    enabled = bool
  })
  default = null
}

variable "sign_up" {
  description = "Sign-up settings."
  type = object({
    enabled = bool
    terms_of_service = object({
      consent_required = bool
      enabled          = bool
      text             = optional(string)
    })
  })
  default = null
}

variable "tenant_access" {
  description = "Whether tenant access is enabled."
  type = object({
    enabled = bool
  })
  default = null
}

variable "virtual_network_configuration" {
  description = "Virtual network configuration for the APIM service."
  type = object({
    subnet_id = string
  })
  default = null
}