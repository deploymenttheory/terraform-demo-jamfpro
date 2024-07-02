resource "jamfpro_static_computer_group" "static_computer_group_002" {
  name = "tf-ghatest-staticcomputergroup"

  // optional
  //site_id = -1

  assignments_ids = [16, 17, 20]

}