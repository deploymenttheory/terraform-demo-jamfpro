##----------------------------------------------------------------------------------------------##
##  Create Categories for JAMF PRO                                                              ##
##----------------------------------------------------------------------------------------------##

resource "jamf" "building_example" {
  name = "example1"

  street_address1 = "1-1-1"
  street_address2 = "example Building"
  city            = "Shibuya-ku"
  state_province  = "Tokyo"
  zip_postal_code = "111-1111"
  country         = "Japan"
}

#------------------------------ JAMF Pro Computer Extension Attribute -----------------------------#