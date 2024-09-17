# terraform test

## Prerequisites

Since we will need to provision infrastructure against Microsoft Azure we functioning Provider setup for `AzureRM`.

- Two Azure Subscriptions with RBAC `Contributor` or higher
- Active `az login` with your personal user account holding the RBAC
- Configuring Subscriptions
  - One: Variable `main_subscription_id`
  - Two: Variable `tests_subscription_id`

## Execution

1. Navigate into folder (`cd 4_test`)
2. Execute `terraform test` with
   a. `tests/1`
   b. `tests/2`
   c. `tests/3`
3. Look into the `*.tftest.hcl` files in the sub folders of `tests` to learn about the `terraform test` syntax

Notes:

- `terraform test` files can also be written in `.json` which was not checked out by me
- Variables files (f.e. `terraform.tfvars`) can be provided in the sub folder where test files are running from (f.e. `tests/`). See [documentation](https://developer.hashicorp.com/terraform/language/tests#specify-variables-with-the-command-line-or-definition-files)
- If you move all `*.tftest.hcl` files into `tests/` they will all run
- `terraform validate` also runs all test files in the default sub folder `tests`
- `terraform test` is a combination of unit and integration testing as also outlined in the [documentation](https://developer.hashicorp.com/terraform/language/tests#integration-or-unit-testing)
  - `run {}` blocks with `command = plan` can be considered logical / unit tests
  - `run {}` blocks with `command = apply` can be considered integration tests (provision real infrastructure with dependencies)

## Personal Notes

`terraform test` is not as easy to just run. It takes other skills then plain simple writing Terraform configurations.

Testing with `command = apply` can lead to a lot of troubles when names need to be unique. In my worst case experiences, `terraform test` did not deprovision correctly. Since there was no state, the cleanup needs to happen manuall then.

If you are familiar with `go` you can also consider [`terratest`](https://terratest.gruntwork.io/) from Gruntwork.io. It provides a more in depth testing experience but adds even more complexity for teams.
