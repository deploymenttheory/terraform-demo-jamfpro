terraform {
  cloud {
    organization = "MacDeacon99"

    workspaces {
      name = "terraform-jamfpro-demo"
    }
  }
}