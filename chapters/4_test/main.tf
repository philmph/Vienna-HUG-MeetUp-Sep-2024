# Add random characters to the storage account name to ensure it is unique
# 24 = Maximum length, 2 = "st" prefix, length(var.name) = length of the name
resource "random_string" "this" {
  length = 24 - 2 - length(var.name)

  special = false
  upper   = false
}

locals {
  resource_group_name  = "rg-${var.name}"
  storage_account_name = "st${var.name}${random_string.this.result}"
}

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = "westeurope"
}

resource "azurerm_storage_account" "this" {
  name                = local.storage_account_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
