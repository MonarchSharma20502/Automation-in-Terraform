output "vmName" {
  value       = azurerm_linux_virtual_machine.VM.name
  description = "The name of the Azure Virtual Machine."
}

output "vmId" {
  value       = azurerm_linux_virtual_machine.VM.id
  description = "The ID of the Azure Virtual Machine."
}