locals {
  resource_group_name  = "rg-${var.resource_group_name}"
  storage_account_name = "st${var.storage_account_name}${random_string.this.result}"
}

# Add random characters to the storage account name to ensure it is unique
# 24 = Maximum length, 2 = "st" prefix, length(var.name) = length of the name
resource "random_string" "this" {
  length = 24 - 2 - length(var.storage_account_name)

  special = false
  upper   = false
}

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = "swedencentral"
}

resource "azurerm_storage_account" "this" {
  name                = local.storage_account_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# TODO: 2_tflint - outputs.tf exists
output "storage_account_name" {
  # TODO: 2_tflint - output has a description
  # description = "The name of the storage account"
  value = azurerm_storage_account.this.name
}
