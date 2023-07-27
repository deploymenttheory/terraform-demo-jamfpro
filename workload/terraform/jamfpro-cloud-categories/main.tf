#------------------------------ JAMF Pro Categories -----------------------------------------------#
# If resource doesn't exist it will be created
# If resource gets a new name it will remove the previous resouce and create a new one
# If the resource attribute is changed, then will keep the resource but update it's attribute.
# If resource is removed then it will be removed by Terraform
# If resource with the same name already exists, will throw duplicate field error and fail
#--------------------------------------------------------------------------------------------------#
resource "jamf_category" "Security" {
  name     = "Security"
  priority = 3
}

resource "jamf_category" "terraform-example" {
  name     = "terraform-example"
  priority = 4
}