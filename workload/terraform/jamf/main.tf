##----------------------------------------------------------------------------------------------##
##  Create Categories for JAMF PRO                                                              ##
##----------------------------------------------------------------------------------------------##

module "jamf" {
  source  = "app.terraform.io/deploymenttheory/jamf/provider"
  version = "0.0.1"
}
#------------------------------ JAMF Pro Computer Extension Attribute -----------------------------#