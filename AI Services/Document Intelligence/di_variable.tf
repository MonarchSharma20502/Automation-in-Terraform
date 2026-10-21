# variable "resource_group_name" {
#   description = "Name of the Resource Group"
#   type = string
# }

# variable "location" {
#   description = "Location of "
#   type = string
# }

# subscription id
variable "subscription_id" {
  description = "The subscription ID to use for the Azure provider."
  type        = string
}

# resource group name

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resource."
  type        = string
}

# location

variable "location" {
  description = "The Azure region in which to create the resource."
  type        = string
  default     = "Germany West Central"
}
# deployment name

variable "deployment_name" {
  description = "The name of the deployment."
  type        = string
  default     = "di-demo-mcsb"
}

# storage account name

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "sadidemomcsb6fa8"

}

# document intelligence users group name

variable "di_workspace_users_group_name" {
  description = "The name of the group for Document Intelligence users."
  type        = string
  default     = "di-demo-mcsb-users"
}

variable "di_workspace_users_principals" {
  description = "The list of user principal IDs for the Document Intelligence users."
  type        = list(string)
  default     = []

}

# windows admin username

variable "windows_admin_username" {
  description = "The username for the Windows admin account."
  type        = string
  default     = "datascientist"
}

# windows admin password

variable "windows_admin_password" {
  description = "The password for the Windows admin account."
  type        = string
  sensitive   = true
}