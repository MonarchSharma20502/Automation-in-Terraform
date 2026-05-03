# Fetching the Current Account running Terraform with Service Principal or Managed Identity authentication
data "azurerm_client_config" "current" {}

resource "azurerm_application_insights" "application_insights" {
  name                = var.application_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_insights_type
  tags                = var.application_insights_tags
}

resource "azurerm_application_insights_api_key" "application_insights_api_key" {
  name                    = var.application_insights_api_key_name
  application_insights_id = azurerm_application_insights.application_insights.id
  read_permissions        = try(var.application_insights_api_key_read_permissions, null)
}

resource "azurerm_bot_service_azure_bot" "azure_bot" {
  name                    = var.bot_service_name
  resource_group_name     = azurerm.application_insights.application_insights.resource_group_name
  location                = var.location
  microsoft_app_id        = data.azurerm_client_config.current.client_id
  microsoft_app_type      = var.microsoft_app_type
  microsoft_app_tenant_id = data.azurerm_client_config.current.tenant_id
  sku                     = var.bot_service_sku

  endpoint                              = var.messaging_endpoint
  developer_app_insights_api_key        = azurerm_application_insights_api_key.application_insights_api_key.api_key
  developer_app_insights_application_id = azurerm_application_insights.application_insights.app_id
  tags = var.bot_service_tags
}