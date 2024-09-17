run "validate_storage_account_name" {
  // Note: Assertions in this file don't work because random_string will only be known after apply
  // -> Needs command = apply instead of plan. Note that apply is the default.
  // command = plan
  command = apply

  // Uses the provider configuration from root module

  // We are not testing the resource group name here so we overwrite to avoid conflicts
  variables {
    // resource_group_name is Inhertied from the root module default value
    // Could be set here for explictness
    storage_account_name = "example"
  }

  assert {
    condition     = length(azurerm_storage_account.this.name) == 24
    error_message = "The length of the Storage Account name should be 24 characters."
  }

  assert {
    condition     = length(regexall("^st${var.storage_account_name}[0-9a-z]*$", azurerm_storage_account.this.name)) > 0
    error_message = "Name should start with 'st' followed by the value of ${var.storage_account_name} and end with random numbers or lowercase characters."
  }
}
