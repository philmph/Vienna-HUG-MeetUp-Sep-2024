# TODO: 2_tflint - outputs.tf exists
output "storage_account_name" {
  # TODO: 2_tflint - output has a description
  description = "The name of the storage account"
  value       = azurerm_storage_account.this.name
}
