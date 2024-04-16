
resource "jamfpro_macos_configuration_profile" "jamfpro_macos_configuration_profile_001" {
  name                = "tf-ghatest-macosconfigprofile-accessibility-options"
  distribution_method = "Install Automatically"
  payload             = file("${path.module}/support_files/configuration_profiles/accessibility-chara-nosub-test.mobileconfig")
  category {
    id = -1
  }
  scope {
    all_computers = true

  }
}