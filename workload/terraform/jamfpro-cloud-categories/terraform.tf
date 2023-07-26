terraform {
  required_version = ">= 1.5.1"
  backend "azurerm" {}
  required_providers {
    jamf = {
      source  = "Yohan460/jamf"
      version = "1.0.16"
    }
  }
}