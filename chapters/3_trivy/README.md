# trivy

## Prerequisites

- Locally install `trivy`

## Execution

1. Navigate into folder (`cd 3_trivy`)
2. Execute `trivy config ./`
3. Update the configuration
   a. In [`main.tf`](./main.tf) add a minimum TLS version constraint by using `min_tls_version` (line :30)
4. Rerun `trivy config ./` - There should be no more errors

You can try to remove the added line and moving `# trivy:ignore:AVD-AZU-0011` above the resource (line :19).

Notes:

- Alternatively to fixing issues they can be ignored (= accepted) by using the `trivy:ignore:ID` syntax commented out at [`main.tf`](./main.tf) (line :33) above the target resource
- `trivy` does not exit with interruptible exit codes for CI usage. The parameter `--exit-code 1` is required

## Personal Notes

I prefer to run `trivy` with the severity level `MEDIUM` or higher by using `--severity MEDIUM,HIGH,CRITICAL`. `LOW` can make a lot of noise.
