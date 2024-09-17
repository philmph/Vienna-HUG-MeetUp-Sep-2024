provider "azurerm" {
  features {}

  # Required as per AzureRM ~> 4.0
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide#specifying-subscription-id-is-now-mandatory
  # TODO: 2_tflint
  subscription_id = var.subscription_id

  # Rest of ARM config is done via az CLI
}
