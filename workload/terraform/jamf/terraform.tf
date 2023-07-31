terraform {
  required_version = ">= 1.5.1"
  backend "azurerm" {}
  required_providers {
    jamf = {
      source  = "deploymenttheory/terraform-provider-jamf"
      version = "0.0.1"
    }
  }
}