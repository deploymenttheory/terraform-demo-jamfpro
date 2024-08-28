
resource "jamfpro_building" "jamfpro_building_001" {
  name            = "tf-ghatest-Apple-Park"
  street_address1 = "The McIntosh Tree"
  street_address2 = "One Apple Park Way"
  city            = "Cupertino"
  state_province  = "California"
  zip_postal_code = "95014"
  country         = "The United States of America"
}

resource "jamfpro_building" "jamfpro_building_002" {
  name            = "Jamf Headquarters"
  street_address1 = "100 Washington Ave S"
  street_address2 = "Suite 1100"
  city            = "Minneapolis"
  state_province  = "Minnesota"
  zip_postal_code = "55401"
  country         = "The United States of America"
}