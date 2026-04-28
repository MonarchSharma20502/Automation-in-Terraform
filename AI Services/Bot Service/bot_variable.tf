# COMMON VARIABLES

variable "location" {
  description = "Location of the Resources (Region)"
  type = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group of the resources"
  type = string
}

# AAPPLICATION INSIGHTS VARIABLES






# APPLICATION INSIGHTS API KEY VARIABLES

variable "application_insights_api_key_read_permissions" {
  description = "value"
  type = list(string)
  default = ["aggregate", "api", "draft", "extendqueries", "search"]
}

variable "bot_service_sku" {
  description = "The SKU of the Azure Bot Service. Accepted values are F0 or S1. Changing this forces a new resource to be created."
  type = string
  validation {
    condition = var.bot_service_sku == "F0" || var.bot_service_sku == "S1"
    error_message = "The given value must be either 'F0' or 'S1' for the Azure Bot Service SKU"
  }
}