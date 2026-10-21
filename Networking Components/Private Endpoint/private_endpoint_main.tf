resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  dynamic "private_service_connection" {
    for_each = var.private_service_connection_name == null ? [] : [1]
    content {
      name                           = var.private_service_connection_name
      private_connection_resource_id = var.private_connection_resource_id
      subresource_names              = var.subresource_names
      is_manual_connection           = var.is_manual_connection
    }
  }
  private_dns_zone_group {
    name                 = var.dns_zone_group_name
    private_dns_zone_ids = var.private_dns_zone_group_ids
  }
}
