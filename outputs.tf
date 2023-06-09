output "vmss_id" {
  description = "The ID of the deployed VMSS"
  value       = azurerm_linux_virtual_machine_scale_set.vmss.id
}

output "vmss_identity" {
  description = "The identity block of the deployed VMSS"
  value       = azurerm_linux_virtual_machine_scale_set.vmss.identity
}

output "vmss_admin_username" {
  description = "The admin username used for SSH in the deployed instances"
  value       = azurerm_linux_virtual_machine_scale_set.vmss.admin_username
}
