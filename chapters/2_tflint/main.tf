locals {
  # 1_built-in
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
  # 1_built-in
  name = local.storage_account_name
  # 1_built-in
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
