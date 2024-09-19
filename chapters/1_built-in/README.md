# Built In

## Execution

### terraform fmt

1. Navigate into folder (`cd 1_built-in`)
2. Open [`main.tf`](./main.tf) and review the formatting of the file
3. Use `terraform fmt --check` and notice that
   a. `main.tf` is printed to stdout meaning the file is not formatted according to `terraform` rules
   b. The last exit code is `!= 0` (f.e. pwsh `$LASTEXITCODE` results in `3`)
   c. The file was not formatted
4. Use `terraform fmt` and verify
   a. Spacing in line 3-4 `main.tf` was updated
   b. `"${local.storage_account_name}"` was transformed to `local.storage_account_name` (string encapsulation is not needed here)

Notes:

- `--recursive` runs from `pwd` through all sub folders
- VSCode Extension `Terraform` uses `terraform fmt` as formatter for `.tf` files
- VSCode user option `"editor.formatOnSave": true` is an amazing settings

### terraform validate

1. Open [`main.tf`](./main.tf) and review the reference to `azurerm_resource_group.this.resource_group_name`
2. Use `terraform validate`
3. Review the stdout error and fix the finding. The correct resource attribute is `name`

Notes:

- `terraform validate` can be used without backend configuration by using `terraform init -backend=false`
- `terraform validate` gives fast feedback about the legitimacy of the Terraform configuration
- `terraform validate` also validates `*.tftest.hcl` files in the default sub folder `tests`
