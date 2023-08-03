#------------------------------ JAMF Pro Categories ------------------------------------------------#
# Behaviour:                                                                                        #
# - If resource doesn't exist it will be created.                                                   #
# - If resource gets a new name it will remove the resouce and create a new one with the new name.  #
# - If the resource attribute is changed, then will keep the resource but update it's attribute.    #
# - If resource is removed from the code then it will be removed by Terraform.                      #
# - If resource with the same name already exists, will throw duplicate field error and fail.       #
#                                                                                                   #
# RBAC:                                                                                             #
# Service account requires the following permissions for CRUD operations respectively.              #
# - Jamf Pro Server Objects - Create / Read / Update / Delete                                       #
#---------------------------------------------------------------------------------------------------#
resource "jamfpro_category" "category_terraform_test" {
  name     = "terraform_test_private"
  priority = 3
}

#------------------------------ JAMF Pro Buildings -------------------------------------------------#
# Behaviour:                                                                                        #
# - If resource doesn't exist it will be created.                                                   #
# - If resource gets a new name it will remove the resouce and create a new one with the new name.  #
# - If the resource attribute is changed, then will keep the resource but update it's attribute.    #
# - If resource is removed from the code then it will be removed by Terraform.                      #
# - If resource with the same name already exists, will throw duplicate field error and fail.       #
#                                                                                                   #
# RBAC:                                                                                             #
# Service account requires the following permissions for CRUD operations respectively.              #
# - Jamf Pro Server Objects - Create / Read / Update / Delete                                       #
#---------------------------------------------------------------------------------------------------#
resource "jamfpro_building" "building_example" {
  name = "terraform_example1"

  street_address1 = "1-1-1"
  street_address2 = "example Building"
  city            = "Shibuya-ku"
  state_province  = "Tokyo"
  zip_postal_code = "111-1111"
  country         = "Japan"
}

#------------------------------ JAMF Pro Computer Extension Attribute -----------------------------#