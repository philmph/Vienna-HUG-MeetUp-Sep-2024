# Docs: https://developer.hashicorp.com/terraform/language/tests

# We recommend defining your variables and provider blocks first, at the beginning of the test file.
variables {
  test_var = "root"
}

provider {}

run "my_run_block" {
  // Defaults to "apply" and can be set to "plan"
  command = "apply"

  variables {
    // Variable defined in run block wins over the variable defined in the root block
    test_var = "inner"
  }

  providers {}

  assert {

  }
}
