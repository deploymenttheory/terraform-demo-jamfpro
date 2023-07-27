#---------------- JAMF Pro Categories ----------------#
resource "jamf_category" "Security" {
  name     = "Security"
  priority = 3
}

resource "jamf_category" "terraform-example" {
  name     = "terraform-example"
  priority = 4
}