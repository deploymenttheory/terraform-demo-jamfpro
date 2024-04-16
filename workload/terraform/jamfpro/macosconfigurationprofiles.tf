
resource "jamfpro_macos_configuration_profile" "jamfpro_macos_configuration_profile_001" {
  name                = "tf-ghatest-macosconfigprofile-accessibility-options"
  distribution_method = "Install Automatically"
  payload             = file("${path.module}/support_files/configuration_profiles/accessibility-chara-nosub-test.mobileconfig")
  category {
    id = -1
  }
  scope {
    all_computers      = false
    computer_ids       = sort([17, 18])
    computer_group_ids = sort([53])
    jss_user_ids       = [4]
    jss_user_group_ids = [4]

    exclusions {
      department_ids = [37287]
    }
  }
}