// Docs: https://developer.hashicorp.com/terraform/language/tests

// From docs:
// We recommend defining your variables and provider blocks first, at the beginning of the test file.
variables {
  test_var = "outer"
}

// Overwrite the default provider from root module
provider "my_provider" {}

// Add an Alias Provider "alias"
provider "my_provider" {
  alias = "alias"
}

run "my_run_block" {
  // Defaults to "apply" and can be set to "plan"
  command = "apply"

  variables {
    // Variable defined in run block wins over the variable defined in the root block
    test_var = "inner"
  }

  // If specified, runs in the alias provider context defined in this file
  providers = {
    my_provider = alias
  }

  assert {
    // Must consist of a condition and an error message. Access to variables of other run blocks is possible:
    // run.my_other_run_block.my_output
    condition = my_resource.example.name == "something"
    error_message = "Name is not something."
  }

  // This block below is not showcased in the repository and added for completeness
  // https://developer.hashicorp.com/terraform/language/tests#modules

  // Per default terraform test runs against the local root module. Use a module block with only
  // the source attribute to run against a different module.
  module {
    source = "./some-path"
  }
}
