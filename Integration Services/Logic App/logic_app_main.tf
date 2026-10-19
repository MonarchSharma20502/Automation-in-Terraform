# USE THIS ONLY IF THE STORAGE ACCOUNT ALSO NEEDS TO BE DEPLOYED ALONG WITH THE LOGIC APP. OTHERWISE, USE DATA BLOCKS TO ACCESS EXISTING STORAGE ACCOUNT.
resource "azurerm_storage_account" "logic_app_storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.storage_account_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "logic_app_service_plan" {
  name                = var.app_service_plan_name
  location            = var.logic_app_location
  resource_group_name = azurerm_resource_group.example.name

  os_type  = "Windows"
  sku_name = "WS1"
}

resource "azurerm_logic_app_standard" "example" {
  name                       = "example-logic-app"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  app_service_plan_id        = azurerm_app_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"     = "node"
    "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
  }
}
