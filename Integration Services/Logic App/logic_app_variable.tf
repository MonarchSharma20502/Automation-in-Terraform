# Logic app Variables
variable "resource_group_name" {
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
variable "app_settings" {
  description = "App Settings for the Logic App"
  type = map(string)
  default = {
    # "WEBSITE_VNET_ROUTE_ALL"       = "1"
    # "WEBSITE_CONTENTOVERVNET"      = "1"
    "FUNCTIONS_WORKER_RUNTIME"     = var.functions_worker_runtime
    "WEBSITE_DNS_SERVER"           = var.website_dns_server
    "WEBSITE_NODE_DEFAULT_VERSION" = var.website_node_default_version
  }
}




# App Service Plan Variables
variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type = string
}
variable "sku_name" {
  description = "SKU Name for the App Service Plan"
  type = string
}




# Storage account variables
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

