output "logic_app_name" {
  value = azurerm_logic_app_standard.logicapp.name
}

output "logic_app_id" {
  value = azurerm_logic_app_standard.logicapp.id
}

output "logic_app_principal_id" {
  value = azurerm_logic_app_standard.logicapp.identity[0].principal_id
}

output "logicapp_plan_name" {
  value = azurerm_service_plan.logicapp_plan.name
}
