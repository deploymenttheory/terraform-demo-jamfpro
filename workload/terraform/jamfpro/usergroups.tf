resource "jamfpro_user_group" "jamfpro_user_group_001" {
  name                 = "tf-ghatest-usergroup-static"
  is_smart             = false
  is_notify_on_change  = true

  site {
    id   = 1
    name = "None"
  }

  # Assuming users are added by specifying IDs or some unique identifiers
  user_additions = [4]
}

resource "jamfpro_user_group" "jamfpro_user_group_002" {
  name                 = "tf-ghatest-usergroup-dynamic"
  is_smart             = false
  is_notify_on_change  = true

  site {
    id   = 1
    name = "None"
  }

  criteria {
    name          = "Criterion Name"
    priority      = 1
    and_or        = "and"
    search_type   = "is"
    value         = "Example Value"
    opening_paren = false
    closing_paren = false
  }
}
