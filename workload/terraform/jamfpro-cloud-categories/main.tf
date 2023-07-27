resource "jamf_category" "terraform-example-update" {
  name     = "terraform-example-update"
  priority = 9
}

resource "jamf_category" "terraform-example" {
  name     = "terraform-example"
  priority = 7
}