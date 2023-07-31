terraform {
  required_version = ">= 1.5.1"
  backend "azurerm" {}
  # Private Registry tf provider
  required_providers {
    jamf = {
      source  = "deploymenttheory/jamf/internal/provider"
      version = "0.0.1"
    }
  }
}