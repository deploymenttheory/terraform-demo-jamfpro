terraform {
  required_version = ">= 1.5.1"
  backend "azurerm" {}
  # Private Registry tf provider
  # <HOSTNAME>/<ORGANIZATION>/<MODULE_NAME>/<PROVIDER_NAME>
  required_providers {
    jamf = {
      source  = "app.terraform.io/deploymenttheory/jamf"
      version = "0.0.1"
    }
  }
}