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
# - Jamf Pro Server Objects - Categories - Create / Read / Update / Delete                          #
#---------------------------------------------------------------------------------------------------#
resource "jamf_category" "category_terraform_test" {
  name     = "cat-terraform_test-0.0.1-prod"
  priority = 3
}

#------------------------------ JAMF Pro Buildings -------------------------------------------------#
                                                                                                #
# Behaviour:                                                                                        #
# - If resource doesn't exist it will be created.                                                   #
# - If resource gets a new name it will remove the resouce and create a new one with the new name.  #
# - If the resource attribute is changed, then will keep the resource but update it's attribute.    #
# - If resource is removed from the code then it will be removed by Terraform.                      #
# - If resource with the same name already exists, will throw duplicate field error and fail.       #
#                                                                                                   #
# RBAC:                                                                                             #
# Service account requires the following permissions for CRUD operations respectively.              #
# - Jamf Pro Server Objects - Buildings - Create / Read / Update / Delete                           #
#---------------------------------------------------------------------------------------------------#
resource "jamf_building" "building_terraform_test" {
  name = "bld-terraform_test-0.0.1-test"

  street_address1 = "1-2-1"
  street_address2 = "example Building"
  city            = "Shibuya-ku"
  state_province  = "Tokyo"
  zip_postal_code = "111-1111"
  country         = "Japan"
}

#------------------------------ JAMF Pro Computer Extension Attribute ------------------------------#
# Ref: https://registry.terraform.io/providers/yohan460/jamf/latest/docs/resources/computerComputerExtensionAttribute#inventory_display
#                                                                                                   #
# Behaviour:                                                                                        #
# - If resource doesn't exist it will be created.                                                   #
# - If resource gets a new name it will remove the resouce and create a new one with the new name.  #
# - If the resource attribute is changed, then will keep the resource but update it's attribute.    #
# - If resource is removed from the code then it will be removed by Terraform.                      #
# - If resource with the same name already exists, will throw duplicate field error and fail.       #
#                                                                                                   #
# RBAC:                                                                                             #
# Service account requires the following permissions for CRUD operations respectively.              #
# - Jamf Pro Server Objects - Scripts - Create / Read / Update / Delete                             #
# - Jamf Pro Server Settings - Cloud distribution point - Read / Update                             #
#---------------------------------------------------------------------------------------------------#
resource "jamf_computer_extension_attribute" "test-extension-attribute-script" {
  name = "exat-test-extension-attribute-script"
  description = "Jamf Pro Extension Attribute that obtains the macOS device's battery charge"
  data_type = "string"
  inventory_display = "Extension Attributes"
  script {
    enabled = true
    script_contents = file("${path.module}/extension-attributes/Battery Charge.sh")
  }
}

resource "jamf_computer_extension_attribute" "test-extension-attribute-popup-menu" {
  name = "test-extension-attribute-popup-menu"
  description = "Jamf Pro Extension Attribute that obtains a string from a pop up menu"
  data_type = "string"
  inventory_display = "Extension Attributes"
  popup_menu {
    choices = ["choice1", "choice2"]
  }
}