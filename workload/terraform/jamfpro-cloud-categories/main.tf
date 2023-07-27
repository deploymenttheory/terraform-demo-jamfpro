resource "jamf_category" "terraform-example-update" {
  name     = "terraform-example-update"
  priority = 3
}

resource "jamf_category" "terraform-example" {
  name     = "terraform-example"
  priority = 4
}