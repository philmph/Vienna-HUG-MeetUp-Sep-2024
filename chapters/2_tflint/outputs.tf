# TODO: 2_tflint
output "storage_account_name" {
  # TODO: 2_tflint
  description = "The name of the storage account"
  value       = azurerm_storage_account.this.name
}
