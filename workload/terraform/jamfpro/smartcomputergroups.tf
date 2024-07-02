resource "jamfpro_smart_computer_group" "smart_computer_group_001" {
  name     = "tf-ghatest-computergroup-operating-system-like-macos-14"

// optional
  site_id = -1

  # Add computers to the group
  criteria {
    name        = "Operating System Version"
    priority    = 0
    and_or       = "and"
    search_type = "like"
    value = "14"
    opening_paren = true
    closing_paren = false
  }
  criteria {
    name        = "Operating System Version"
    priority    = 1
    and_or       = "and"
    search_type = "like"
    value = "14"
    opening_paren = false
    closing_paren = true
  }

}