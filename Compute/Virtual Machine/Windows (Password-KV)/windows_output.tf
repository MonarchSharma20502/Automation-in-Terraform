output "windowVmName" {
  value       = azurerm_windows_virtual_machine.vm.name
  description = "The name of the Azure Virtual Machine."
}

output "windowVmId" {
  value       = azurerm_windows_virtual_machine.vm.id
  description = "The ID of the Azure Virtual Machine."
}