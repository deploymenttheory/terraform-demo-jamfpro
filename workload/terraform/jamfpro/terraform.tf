terraform {
  required_version = ">= 1.5.1"
  backend "azurerm" {}
  required_providers {
    jamfpro = {
      source = "app.terraform.io/deploymenttheory/jamfpro"
      version = "10.48.0"
    }
  }
}