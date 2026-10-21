# USE THIS ONLY IF THE STORAGE ACCOUNT ALSO NEEDS TO BE DEPLOYED ALONG WITH THE LOGIC APP. OTHERWISE, USE DATA BLOCKS TO ACCESS EXISTING STORAGE ACCOUNT.
resource "azurerm_storage_account" "logic_app_storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.storage_account_resource_group_name
  location                 = var.storage_account_location
  account_kind             = var.storage_account_kind
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  access_tier              = var.storage_account_access_tier

}

resource "azurerm_service_plan" "logic_app_service_plan" {
  name                = var.app_service_plan_name
  location            = var.logic_app_location
  resource_group_name = var.app_service_plan_resource_group_name

  os_type  = var.os_type
  sku_name = var.logic_app_service_plan_sku_name
}

resource "azurerm_logic_app_standard" "logic_app_standard" {
  name                       = var.logic_app_name
  location                   = azurerm_service_plan.logic_app_service_plan.location
  resource_group_name        = azurerm_service_plan.logic_app_service_plan.resource_group_name
  app_service_plan_id        = azurerm_service_plan.logic_app_service_plan.id
  storage_account_name       = azurerm_storage_account.logic_app_storage_account.name
  storage_account_access_key = azurerm_storage_account.logic_app_storage_account.primary_access_key

  # Use only if we require public network access to the Logic App. If we want to restrict access to the Logic App, we can set this to "Disabled" and use private endpoints to access the Logic App.
  # The default is set to "TRUE"
  public_network_access = var.public_network_access

  # The name of the variable doesn't have to match site_config as the loop is alwaays going to be executed only once or not at all. The variable name can be anything, but the content block inside the loop should match the site_config block in the resource. WE ARE USING THE SAME NAME SO ITS EASY FOR US TO UNDERSTAND AND MAINTAIN.

  # site_config is a block, not a variable.
  dynamic "site_config" {
    for_each = var.site_config == null ? [] : [1]
    content {
      dotnet_framework_version  = lookup(var.site_config, "dotnet_framework_version", null)
      http2_enabled             = lookup(var.site_config, "http2_enabled", null)
      use_32_bit_worker_process = lookup(var.site_config, "use_32_bit_worker_process", null)
      min_tls_version           = lookup(var.site_config, "min_tls_version", null)
      vnet_route_all_enabled    = lookup(var.site_config, "vnet_route_all_enabled", null)
    }
  }
  # Here, app_settings is a map of strings and instead of configuring it as a whole in variables.tf, we are configuring each property of the app_settings map as a separate variable in variables.tf. IN THE WORKLOAD, WE'LL 

  # app_settings is a variable (this means, we can create its direct variable but not for site_config. For site_config, we use the dynamic block and there is a separate variable for it which is then declared in the variable.tf).
  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"     = var.functions_worker_runtime
    "WEBSITE_DNS_SERVER"           = var.website_dns_server
    "WEBSITE_NODE_DEFAULT_VERSION" = var.website_node_default_version
    "maximum_elastic_worker_count" = var.maximum_elastic_worker_count
    "WEBSITE_VNET_ROUTE_ALL"       = var.website_vnet_route_all_enabled ? "1" : "0"
    "WEBSITE_CONTENTOVERVNET"      = var.website_content_over_vnet_enabled ? "1" : "0" # When the Storage account is private.
  }
  # WEBSITE_VNET_ROUTE_ALL forces all outbound traffic from the Logic App Standard to route through the configured Virtual Network (VNet), ensuring that even internet-bound traffic exits via the VNet integration subnet.  WEBSITE_CONTENTOVERVNET specifically directs the Logic App runtime to fetch workflow definitions and state data from the storage account’s file share via the VNet rather than the public internet, which is critical when the storage account is secured by private endpoints or network rules. 

  # In Terraform, these settings are often configured within the app_settings block of the azurerm_logic_app_standard resource to ensure secure, private communication. However, note that newer Azure App Service configurations have introduced native site properties (vnetRouteAllEnabled and vnetContentShareEnabled) that may supersede these legacy app settings, though the app settings remain supported for backward compatibility
  identity {
    type = var.managed_identity_type
  }
}
