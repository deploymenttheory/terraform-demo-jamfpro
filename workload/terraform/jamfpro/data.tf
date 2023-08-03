#---------------- JAMF Pro Buildings ---------------------------#

data "jamfpro_building" "example" {
  name = "example"
}

#---------------- JAMF Pro Categories --------------------------#
data "jamfpro_category" "terraform-example" {
  name = "terraform-example"
}
data "jamfpro_category" "Security" {
  name = "Security"
}