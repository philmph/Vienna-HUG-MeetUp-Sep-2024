variable "subscription_id" {
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

variable "resource_group_name" {
  default     = "example"
  description = "The name for the Resource Group."
  type        = string
}
