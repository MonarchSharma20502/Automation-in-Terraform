# Logic app Variables
variable "logic_app_resource_group_name" {
  description = "Name of the Resource Group"
  type = string
}
variable "logic_app_location" {
  description = "Location of the Logic App"
  type = string
}
variable "logic_app_name" {
  description = "Name of the Logic App"
  type = string
}
variable "functions_worker_runtime" {
  description = "Functions Worker Runtime for the Logic App"
  type = string
  default = "node"
}
variable "website_dns_server" {
  description = "DNS Server for the Logic App"
  type = string
  default = "8.8.8.8"
}
variable "website_node_default_version" {
  description = "Node.js Version for the Logic App"
  type = string
  default = "~20"
}
variable "maximum_elastic_worker_count" {
  description = "Maximum Elastic Worker Count for the Logic App Service Plan"
  type = number
}

# FOR PUBLIC LOGIC APP.
variable "public_network_access" {
  description = "Public Network Access for the Logic App"
  type = string
  default = "Enabled"
}
variable "virtual_network_subnet_id" {
  description = "Virtual Network Subnet ID for the Logic App"
  type = string
}
variable "managed_identity_type" {
  description = "Managed Identity Type for the Logic App"
  type = string
  default = "SystemAssigned"
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "None"], var.managed_identity_type)
    error_message = "Managed Identity Type must be one of: SystemAssigned, UserAssigned, None. Please provide a valid value."
  }
}


# APP SETTINGS VARIABLES

# Use this for Private Logic App with VNET Integration. If you want to use a public Logic App, you can remove this variable and the corresponding configuration in the azurerm_logic_app_standard resource.
variable "vnet_content_share_enabled" {
  description = "Enable VNET Content Share for the Logic App"
  type = bool
  default = true
}
variable "functions_worker_runtime" {
  description = "Functions Worker Runtime for the Logic App"
  type = string
  default = "node"
}
variable "website_dns_server" {
  description = "DNS Server for the Logic App"
  type = string
  default = "8.8.8.8"
}
variable "website_node_default_version" {
  description = "Node.js Version for the Logic App"
  type = string
  default = "~20"
}
variable "website_vnet_route_all_enabled" {
  description = "Enable VNET Route All for the Logic App"
  type = bool
}
variable "website_content_over_vnet_enabled" {
  description = "Enable Content Over VNET for the Logic App"
  type = bool
}

# This variable is tightly mapped (i.e., we can't declare these properties as separate variables in the workload as it will become difficult in accessing them in the main.tf).)
variable "site_config" {
  description = "Optional site config block for the Logic App"
  type = object({
    dotnet_framework_version         = optional(string)
    http2_enabled                    = optional(bool)
    use_32_bit_worker_process        = optional(bool)
    min_tls_version                  = optional(string)
    vnet_route_all_enabled           = optional(bool)
  })
  default = null
}


########################################

# App Service Plan Variables
variable "app_service_plan_resource_group_name" {
  description = "Resource Group Name of the App Service Plan"
  type = string
}
variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type = string
}
variable "logic_app_service_plan_sku_name" {
  description = "SKU Name for the App Service Plan"
  type = string
}
variable "os_type" {
  description = "OS Type for the App Service Plan"
  type = string
}


########################################

# Storage account variables
variable "storage_account_resource_group_name" {
  description = "Resource Group Name of the Storage Account"
  type = string
}
variable "storage_account_name" {
  description = "Name of the Storage Account"
  type = string
}
variable "storage_account_location" {
  description = "Location of the Storage Account"
  type = string
}
variable "storage_account_access_key" {
  description = "Access Key of the Storage Account"
  type = string
}
variable "storage_account_tier" {
  description = "Tier of the Storage Account. The possible values are 'Standard' and 'Premium'."
  type = string
}
variable "storage_account_replication_type" {
  description = "Replication Type of the Storage Account. The possible values are 'LRS', 'GRS', 'RAGRS', 'ZRS', 'GZRS', and 'RAGZRS'."
  type = string
}
variable "storage_account_kind" {
  description = "Kind of the Storage Account. The possible values are 'Storage', 'StorageV2', 'BlobStorage', 'FileStorage', and 'BlockBlobStorage'."
  type = string

  validation {
    condition     = contains(["Storage", "StorageV2", "BlobStorage", "FileStorage", "BlockBlobStorage"], var.storage_account_kind)
    error_message = "Storage Account Kind must be one of: Storage, StorageV2, BlobStorage, FileStorage, BlockBlobStorage. Please provide a valid value."
  }
}
variable "storage_account_access_tier" {
  description = "Access Tier of the Storage Account. The possible values are 'Hot' and 'Cool'."
  type = string
  validation {
    condition     = contains(["Hot", "Cool","Cold","Archive"], var.storage_account_access_tier)
    error_message = "Storage Account Access Tier must be one of: Hot, Cool, Cold, Archive. Please provide a valid value."
  }
}