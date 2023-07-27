data "jamf_building" "example" {
  name = "example"
}
data "jamf_category" "Security" {
  name = "Security"
}

data "jamf_category" "terraform-example" {
  name = "terraform-example"
}