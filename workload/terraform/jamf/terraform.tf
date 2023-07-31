terraform {
  required_version = ">= 1.5.1"
  backend "azurerm" {}
  # Private Registry tf provider
  required_providers {
    jamf = {
      source  = "halosync/jamf"
      version = "1.1.2"
    }
  }
}