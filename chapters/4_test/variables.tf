# 2_tflint
variable "main_subscription_id" {
  description = "The subscription ID to use for the resources"
  type        = string
}

variable "storage_account_name" {
  description = "The name for the Storage Account."
  type        = string

  validation {
    condition     = length(var.storage_account_name) <= 22 && length(var.storage_account_name) >= 4
    error_message = "The storage account name must be less than or equal to 22 characters."
  }
}

# Only relevant in this configuration
variable "tests_subscription_id" {
  default     = ""
  description = "The subscription ID to use for the resources in the tests"
  type        = string
}

variable "resource_group_name" {
  default     = "example"
  description = "The name for the Resource Group."
  # 2_tflint
  type = string
}
