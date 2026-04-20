resource "azurerm_search_service" "ai_search" {
    name                = var.search_service_name
    resource_group_name = var.resource_group_name
    location            = var.location
    sku = var.ai_search_sku
    tags = var.ai_search_tags
    dynamic "identity" {
      for_each = var.enable_managed_identity == true ? [1] : []
    content {
      type = var.identity_type
    }
    }
}