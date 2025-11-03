output "resource_group_id" {
  description = "The ID of the created resource group."
  value       = azurerm_resource_group.this.id
}

output "resource_group_name" {
  description = "The name of the created resource group."
  value       = azurerm_resource_group.this.name
}

output "virtual_machine_id" {
  description = "The ID of the Linux virtual machine."
  value       = azurerm_linux_virtual_machine.this.id
}

output "virtual_machine_public_ip" {
  description = "The public IP address assigned to the Linux virtual machine."
  value       = azurerm_public_ip.this.ip_address
}
