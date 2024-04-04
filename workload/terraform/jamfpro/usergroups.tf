# resource "jamfpro_user_group" "jamfpro_user_group_multi" {
#   count               = 50
#   name                = format("tf-localtest-usergroup-static-loadtest-%03d", count.index + 1)
#   is_smart            = false
#   is_notify_on_change = false

#   site {
#     id   = -1
#     name = "None"
#   }

#   users {
#     id = [2, 3]
#   }
# }



# resource "jamfpro_user_group" "jamfpro_user_group_002" {
#   name                = "tf-ghatest-usergroup-smart"
#   is_smart            = true
#   is_notify_on_change = true

#   # site {
#   #   id   = -1
#   #   name = "None"
#   # }

#   criteria {
#     name          = "Email Address"
#     priority      = 0
#     and_or        = "and"
#     search_type   = "like"
#     value         = "company.com"
#     opening_paren = false
#     closing_paren = false
#   }
#   criteria {
#     name          = "Managed Apple ID"
#     priority      = 1
#     and_or        = "and"
#     search_type   = "like"
#     value         = "company.com"
#     opening_paren = false
#     closing_paren = false
#   }
# }

