terraform {
  # TODO: 2_tflint
  required_version = "~> 1.9"

  # Using fixed pins for providers to prevent random occurance during live demo
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.2.0"
    }

    # TODO: 2_tflint
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}
