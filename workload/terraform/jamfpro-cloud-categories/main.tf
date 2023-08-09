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
# - Jamf Pro Server Settings - Extension attributes * 3 - Create / Read / Update / Delete           #
#---------------------------------------------------------------------------------------------------#
resource "jamf_computer_extension_attribute" "test-extension-attribute-script" {
  name              = "exat-battery_charge-0.0.1-test"
  description       = "Jamf Pro Extension Attribute that obtains the macOS device's battery charge"
  data_type         = "String"   # Can be "String", "Integer", "Date"
  inventory_display = "Hardware" # Category in which to display the extension attribute in Jamf Pro - Can be "General", "Hardware", "Operating System", "User and Location", "Purchasing", "Extension Attributes"
  script {
    enabled         = true # Boolean. Can be true or false. no "" needed.
    platform        = "Mac"
    script_contents = file("${path.module}/extension-attributes/Battery Charge.sh")
  }
}

resource "jamf_computer_extension_attribute" "test-extension-attribute-text-field" {
  name              = "exat-text_field-0.0.1-test"
  description       = "You can display a text field in inventory information or Recon to collect inventory data. You can enter a value in the field during enrollment with Recon or anytime using Jamf Pro."
  inventory_display = "Extension Attributes"
  text_field {}
}

resource "jamf_computer_extension_attribute" "test-extension-attribute-popup-menu" {
  name              = "exat-popup_menu-0.0.1-test"
  description       = "Jamf Pro Extension Attribute that obtains a string from a pop up menu"
  inventory_display = "Extension Attributes"
  popup_menu {
    choices = ["choice1", "choice2"]
  }
}

#------------------------------ JAMF Pro Smart Computer Group --------------------------------------#
# Ref: https://registry.terraform.io/providers/yohan460/jamf/latest/docs/resources/smartComputerGroup
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
# - Jamf Pro Server Settings - Smart Computer Groups - Create / Read / Update / Delete              #
#---------------------------------------------------------------------------------------------------#

resource "jamf_smartComputerGroup" "test_smart_1" {
  name = "smcg-has_application_Microsoft_Word-0.1-test"
  criteria {
    priority     = 0
    name         = "Application Title"
    search_type  = "is"
    search_value = "Microsoft word"
  }
}

resource "jamf_smartComputerGroup" "jamf_smartComputerGroup_2" {
  name = "smcg-last_check_in_gt_30_days-0.1-test"
  criteria {
    priority     = 0
    name         = "Last Check-in"
    search_type  = "more than x days ago"
    search_value = "30"
  }
}