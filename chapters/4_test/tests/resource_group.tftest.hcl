// Required variables need to be provided even if not relevant for the test cas
variables {
  storage_account_name = "unused"
}

run "validate_default_name" {
  command = plan

  // Innherits the default value for var.name from the root module

  assert {
    condition     = azurerm_resource_group.this.name == "rg-example"
    error_message = "Default name for the Resource Group should be 'rg-example'."
  }
}

// Not used but also possible -> All run {} blocks inherit the value defined here instead of the default
// from the root module called.
// variables {
//   name = "global"
// }

run "validate_custom_name" {
  command = plan

  // Overwrites the var.name value within the run block
  variables {
    resource_group_name = "custom"
  }

  assert {
    condition     = azurerm_resource_group.this.name == "rg-custom"
    error_message = "Name for the Resource Group should be 'rg-custom'."
  }
}
