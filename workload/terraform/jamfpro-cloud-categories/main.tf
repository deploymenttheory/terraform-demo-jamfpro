#------------------------------ JAMF Pro Categories -----------------------------------------------#
# If resource doesn't exist it will be created
# If resource gets a new name it will remove the previous resouce and create a new one
# If the resource attribute is changed, then will keep the resource but update it's attribute.
# If resource is removed then it will be removed by Terraform
# If resource with the same name already exists, will throw duplicate field error and fail
#
# Service account requires the following permissions for CRUD operations respectively
# Jamf Pro Server Objects - Create / Read / Update / Delete
#--------------------------------------------------------------------------------------------------#
resource "jamf_category" "Security" {
  name     = "Security"
  priority = 3
}

resource "jamf_category" "terraform-example" {
  name     = "terraform-example"
  priority = 4
}


#------------------------------ JAMF Pro Buildings ------------------------------------------------#
#--------------------------------------------------------------------------------------------------#
resource "jamf_building" "example" {
  name = "example"

  street_address1 = "1-1-1"
  street_address2 = "example Building"
  city            = "Shibuya-ku"
  state_province  = "Tokyo"
  zip_postal_code = "111-1111"
  country         = "Japan"
}