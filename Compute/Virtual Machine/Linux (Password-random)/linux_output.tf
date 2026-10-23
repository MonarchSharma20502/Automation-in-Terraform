output "linux_virtual_machine_name" {
  value       = azurerm_linux_virtual_machine.linux_virtual_machine.name
  description = "The name of the Azure Virtual Machine."
}

output "id" {
  value       = azurerm_linux_virtual_machine.linux_virtual_machine.id
  description = "The ID of the Azure Virtual Machine."
}