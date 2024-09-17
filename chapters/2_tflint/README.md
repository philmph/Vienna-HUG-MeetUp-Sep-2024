# tflint

## Prerequisites

- Locally install `tflint`

## Execution

### default

1. Navigate into folder (`cd 2_tflint`)
2. Execute `tflint` without extra options and review the errors
3. Update the configuration
   a. In [`terraform.tf`](./terraform.tf) add a provider constraint for `random` which is used in `main.tf` (line 13:16)
   b. In the same file, setup a `required_verion` constraint for the used `terraform` executable version (line :3)
   c. In [`variables.tf`](./variables.tf) add a `type` for the variable `resource_group_name` which is used in `main.tf` (line 21)
   d. In the same file, remove the unsued variable `Unused` (this one would also alert in the next `Preset: all` section due to the naming)
4. Rerun `tflint` - There should be no more errors

Notes:

- After finishing, there are still linting TODOs active which `tflint` did not shout about

### Preset: all

I have prepare a tflint configuration file (`.tflint.hcl`) in the root of the Repository. To use it the CLI run `tflint --config "../../.tflint.hcl"`

1. Make sure you are still in the `2_tflint` folder
2. Run `tflint --init --config "../../.tflint.hcl"` to download the required plugin
3. Execute `tflint --config "../../.tflint.hcl"`
4. Update the configuration
   a. In [`main.tf`](./main.tf) add a description for the output `storage_account_name` (line :33)
   b. Create a `outputs.tf` file in the directory (`touch outputs.tf`) and move the `output` block updated in the previous step into the new file
   c. Update all occurences of the variable `subscriptionId` to `subscription_id` (snake_case instead of pascalCase). The variable is found in `providers.tf` and `variables.tf`
5. Rerun `tflint --config "../../.tflint.hcl"` - There should be no more errors

Notes:

- The configuration in the Repository root uses all Terraform rules by using `preset  = "all"`
- Per default `tflint` uses the `.tflint.hcl` file from the local directory of the configuration
- This is also true when used with `--recursive`. Every sub folder needs to have a `.tflint.hcl` file per default
- To only require one `.tflint.hcl` file in the (f.e. in the Repository root) you can use a fully qualified path f.e. `--config "$(pwd)/../.tflint.hcl"`

## Personal Notes

`tflint` is a very mighty toolkit to standardize code styling within a team. It often times also brings up errors (like unused variables) which were not thought of.

To ensure proper lifecycling of `tflint` I prefer an explicit `.tflint.hcl` with a version constraint in the root directory. `renovatebot` can update the constraint :).
