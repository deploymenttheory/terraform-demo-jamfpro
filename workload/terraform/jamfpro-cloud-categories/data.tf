#---------------- JAMF Pro Buildings ---------------------------#

data "jamf_building" "example" {
  name = "example"
}
data "jamf_category" "Security" {
  name = "Security"
}

#---------------- JAMF Pro Categories --------------------------#
data "jamf_category" "terraform-example" {
  name = "terraform-example"
}