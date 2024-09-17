// Default provider override
provider "azurerm" {
  features {}

  subscription_id = var.tests_subscription_id
}

// Secondary provider using alias syntax
provider "azurerm" {
  features {}

  alias = "main"
  subscription_id = var.main_subscription_id
}

// Overwrite the Storage Account name to ensure it doesn't with the other test
variables {
  resource_group_name = "customprovider"
  storage_account_name = "customprovider"
}

run "validate_storage_account_name_custom_override" {
  command = apply

  // Uses the overwritten provider configuration from this tftest file

  assert {
    condition     = length(azurerm_storage_account.this.name) == 24
    error_message = "The length of the Storage Account name should be 24 characters."
  }

  assert {
    condition     = length(regexall("^st${var.storage_account_name}[0-9a-z]*$", azurerm_storage_account.this.name)) > 0
    error_message = "Name should start with 'st' followed by the value of ${var.storage_account_name} and end with random numbers or lowercase characters."
  }

  // Not a useful but a showcase for cross output assertion between run {} blocks
  // This assertion will fail because output of validate_storage_account_name_custom_main is not known when executing this block
  // assert {
  //   condition = length(regexall("^stcustomprovider2[0-9a-z]*$", run.validate_storage_account_name_custom_main.storage_account_name)) > 0
  //   error_message = "Name must be match the output of the other test."
  // }
}

run "validate_storage_account_name_custom_main" {
  command = apply

  // Uses the alias provider configuration from this tftest file
  // which is the same as the one in the root module
  providers = {
    azurerm = azurerm.main
  }

  // Overwritten for showcase of cross output assertion between run {} blocks
  variables {
    storage_account_name = "customprovider2"
  }

  assert {
    condition     = length(azurerm_storage_account.this.name) == 24
    error_message = "The length of the Storage Account name should be 24 characters."
  }

  assert {
    condition     = length(regexall("^st${var.storage_account_name}[0-9a-z]*$", azurerm_storage_account.this.name)) > 0
    error_message = "Name should start with 'st' followed by the value of ${var.storage_account_name} and end with random numbers or lowercase characters."
  }

  // Not a useful but a showcase for cross output assertion between run {} blocks
  // Note that this assertion works because run {} blocks are executed in order and therefore output of
  // validate_storage_account_name_custom_override is known
  assert {
    condition = length(regexall("^stcustomprovider[0-9a-z]*$", run.validate_storage_account_name_custom_override.storage_account_name)) > 0
    error_message = "Name must be match the output of the other test."
  }
}
