output "linux_virtual_machine_name" {
  value       = azurerm_linux_virtual_machine.linux_virtual_machine.name
  description = "The name of the Azure Virtual Machine."
}

output "id" {
  value       = azurerm_linux_virtual_machine.linux_virtual_machine.id
  description = "The ID of the Azure Virtual Machine."
}

output "linux_vm_admin_password" {
  value = random_password.linux_vm_password.result
  description = "Password of Linux VM"
  sensitive = true
}

# In the terminal, we can access the password using 'terraform output -raw vm_admin_password'
# Or by using 'terraform state show random_password.linux_vm_password'