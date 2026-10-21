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

variable "application_insights_tags" {
  description = "Tags for the App Insight for the Bot Service"
  type = map(string)
  default = {
    "environment" = "Development"
    "owner"       = "Organization Name"
    "Cloud"       = "Azure"
    "attached_to"     = "Bot Service"
  }
}

variable "application_insights_name" {
  description = "Name of the Application Insights resource to be created for the Bot Service"
  type = string
}

variable "application_insights_type" {
  description = "Type of the Application Insights to be created"
  type = string
  default = "web"
}

# APPLICATION INSIGHTS API KEY VARIABLES

variable "application_insights_api_key_read_permissions" {
  description = "value"
  type = list(string)
  default = ["aggregate", "api", "draft", "extendqueries", "search"]
}

variable "application_insights_api_key_name" {
  description = "Name of the API key used for the Application Insights"
  type = string
}

# BOT SERVICE VARIABLES

variable "bot_service_name" {
  description = "Name of the Azure Bot Service"
  type = string
}

variable "bot_service_sku" {
  description = "The SKU of the Azure Bot Service. Accepted values are F0 or S1. Changing this forces a new resource to be created."
  type = string
  validation {
    condition = var.bot_service_sku == "F0" || var.bot_service_sku == "S1"
    error_message = "The given value must be either 'F0' or 'S1' for the Azure Bot Service SKU"
  }
}

variable "microsoft_app_type" {
  description = "The type of the Microsoft App. Accepted values are SingleTenant or MultiTenant."
  type = string
  validation {
    condition = var.microsoft_app_type == "SingleTenant" || var.microsoft_app_type == "MultiTenant" || var.microsoft_app_type == "UserAssignedMSI"
    error_message = "The given value must be either 'SingleTenant' or 'MultiTenant' or 'UserAssignedMSI' for the Microsoft App Type"
  }
}

variable "messaging_endpoint" {
  description = "Messaging Endpoint of the Azure Bot Service: Endpoint of the Bot Channel to connect"
  type = string
}

variable "bot_service_tags" {
  description = "Tags for the Bot Service"
  type = map(string)
  default = {
    "environment" = "Development"
    "owner"       = "Organization Name"
    "Cloud"       = "Azure"
    "Instance_count" = "1"
  }
}