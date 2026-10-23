resource "azurerm_api_management" "this" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  publisher_name                = var.publisher_name
  publisher_email               = var.publisher_email
  sku_name                      = var.sku_name
  client_certificate_enabled    = var.client_certificate_enabled
  gateway_disabled              = var.gateway_disabled
  min_api_version               = var.min_api_version
  zones                         = var.zones
  notification_sender_email     = var.notification_sender_email
  public_ip_address_id          = var.public_ip_address_id
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_type          = var.virtual_network_type
  tags                          = var.tags

  dynamic "additional_location" {
    for_each = var.additional_location
    content {
      location             = additional_location.value.location
      capacity             = lookup(additional_location.value, "capacity", null)
      zones                = lookup(additional_location.value, "zones", null)
      public_ip_address_id = lookup(additional_location.value, "public_ip_address_id", null)
      gateway_disabled     = lookup(additional_location.value, "gateway_disabled", null)
      virtual_network_configuration {
        subnet_id = additional_location.value.virtual_network_configuration.subnet_id
      }
    }
  }

  dynamic "certificate" {
    for_each = var.certificates
    content {
      encoded_certificate  = certificate.value.encoded_certificate
      store_name           = certificate.value.store_name
      certificate_password = lookup(certificate.value, "certificate_password", null)
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.identity_type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "sign_in" {
    for_each = var.sign_in != null ? [var.sign_in] : []
    content {
      enabled = sign_in.value.enabled
    }
  }

  dynamic "sign_up" {
    for_each = var.sign_up != null ? [var.sign_up] : []
    content {
      enabled = sign_up.value.enabled
      terms_of_service {
        consent_required = sign_up.value.terms_of_service.consent_required
        enabled          = sign_up.value.terms_of_service.enabled
        text             = lookup(sign_up.value.terms_of_service, "text", null)
      }
    }
  }

  dynamic "tenant_access" {
    for_each = var.tenant_access != null ? [var.tenant_access] : []
    content {
      enabled = tenant_access.value.enabled
    }
  }

  dynamic "virtual_network_configuration" {
    for_each = var.virtual_network_configuration != null ? [var.virtual_network_configuration] : []
    content {
      subnet_id = virtual_network_configuration.value.subnet_id
    }
  }
}