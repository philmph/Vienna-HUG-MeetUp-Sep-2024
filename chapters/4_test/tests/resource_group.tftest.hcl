run "validate_default_name" {
  command = plan

  assert {
    condition     = azurerm_resource_group.this.name == "rg-example"
    error_message = "Default name for the Resource Group should be 'rg-example'."
  }
}

run "validate_custom_name" {
  command = plan

  variables {
    name = "custom"
  }

  assert {
    condition     = azurerm_resource_group.this.name == "rg-custom"
    error_message = "Name for the Resource Group should be 'rg-custom'."
  }
}
