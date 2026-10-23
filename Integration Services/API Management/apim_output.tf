output "id" {
  description = "Resource ID of the APIM resource."
  value       = azurerm_api_management.this.id
}

output "name" {
  description = "Name of  the APIM resource."
  value       = azurerm_api_management.this.name
}

output "apim_client_certificate_enabled" {
  description = "Specifies whether client certificate is enabled on the API Management instance."
  value       = azurerm_api_management.this.client_certificate_enabled
}

output "apim_developer_portal_url" {
  description = "The URL for the developer portal."
  value       = azurerm_api_management.this.developer_portal_url
}

output "apim_gateway_disabled" {
  description = "Whether the gateway is disabled."
  value       = azurerm_api_management.this.gateway_disabled
}

output "apim_gateway_url" {
  description = "The gateway URL of the API Management service."
  value       = azurerm_api_management.this.gateway_url
}

output "apim_gateway_regional_url" {
  description = "The regional gateway URL of the API Management service."
  value       = azurerm_api_management.this.gateway_regional_url
}

output "apim_management_api_url" {
  description = "The management API URL."
  value       = azurerm_api_management.this.management_api_url
}

output "apim_min_api_version" {
  description = "The minimum API version supported by the service."
  value       = azurerm_api_management.this.min_api_version
}

output "apim_notification_sender_email" {
  description = "The email address used to send notifications."
  value       = azurerm_api_management.this.notification_sender_email
}

output "apim_portal_url" {
  description = "The portal URL of the API Management service."
  value       = azurerm_api_management.this.portal_url
}

output "apim_private_ip_addresses" {
  description = "The list of private IP addresses assigned to the API Management instance."
  value       = azurerm_api_management.this.private_ip_addresses
}

output "apim_public_ip_addresses" {
  description = "The list of public IP addresses assigned to the API Management instance."
  value       = azurerm_api_management.this.public_ip_addresses
}

output "apim_public_network_access_enabled" {
  description = "Indicates whether public network access is enabled."
  value       = azurerm_api_management.this.public_network_access_enabled
}

output "apim_publisher_email" {
  description = "The email address of the publisher."
  value       = azurerm_api_management.this.publisher_email
}

output "apim_publisher_name" {
  description = "The name of the publisher."
  value       = azurerm_api_management.this.publisher_name
}

output "apim_resource_group_name" {
  description = "The name of the resource group in which the API Management instance resides."
  value       = azurerm_api_management.this.resource_group_name
}

output "apim_scm_url" {
  description = "The SCM URL of the API Management instance."
  value       = azurerm_api_management.this.scm_url
}
 