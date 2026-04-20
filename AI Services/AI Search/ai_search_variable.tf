variable "search_service_name" {
  description = "Name of the AI Search Service (Cognitive Search Service)"
  type = string
}

variable "location" {
  description = "Region of the Search Service"
  type = string
}

variable "resource_group_name" {
  description = "Name of the RG"
  type = string
}

variable "ai_search_sku" {
  description = "SKU tier of AI Search Service: basic, free, standard, standard2, standard3, storage_optimized_l1 and storage_optimized_l2"
  type = string
}

variable "enable_managed_identity" {
  description = "Enable Managed Identity for the instance"
  type = bool
}

variable "identity_type" {
  description = "Type of Managed Identity to create: SystemAssigned or UserAssigned"
  type = string
}

variable "ai_search_tags" {
  description = "Tags for the AI Search Service"
  type = map(string)
  default = {
    "environment" = "Development"
    "owner"       = "Your Name"
    "Cloud"       = "Azure"
    "Instance_count" = "1"
  }
}