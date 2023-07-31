##----------------------------------------------------------------------------------------------##
##  Create Categories for JAMF PRO                                                              ##
##----------------------------------------------------------------------------------------------##

## Modules
module "jamf" {
  source  = "app.terraform.io/deploymenttheory/jamf/provider"
  version = "0.0.1"

  categories = [
    {
      street_address1 = "1-1-1"
      street_address2 = "example Building"
      city            = "Shibuya-ku"
      state_province  = "Tokyo"
      zip_postal_code = "111-1111"
      country         = "Japan"
    },
  ]
}