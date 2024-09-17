terraform {
  # Using fixed pins for providers to prevent random occurance during live demo
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.2.0"
    }
  }
}
