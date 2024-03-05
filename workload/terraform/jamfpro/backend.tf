// set terraform cloud organization and workspace
terraform {
  cloud {
    organization = "deploymenttheory"

    workspaces {
      name = "terraform-jamfpro-demo"
    }
  }
}