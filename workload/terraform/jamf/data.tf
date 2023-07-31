#---------------- JAMF Pro Buildings ---------------------------#

data "jamf_building" "example" {
  name = "example"
}

#---------------- JAMF Pro Categories --------------------------#
data "jamf_category" "terraform-example" {
  name = "terraform-example"
}
data "jamf_category" "Security" {
  name = "Security"
}