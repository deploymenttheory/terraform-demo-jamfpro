// set terraform cloud organization and workspaceterraform {
terraform {
  cloud {
    organization = "MacDeacon99"

    workspaces {
      tags = ["Jamf Pro"]
      name = "terraform-jamfpro-demo"
    }
  }
}