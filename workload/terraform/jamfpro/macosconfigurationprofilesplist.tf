
resource "jamfpro_macos_configuration_profile_plist" "jamfpro_macos_configuration_profile_001" {
  name                = "tf-ghatest-macosconfigprofile-passcode"
  distribution_method = "Install Automatically" // "Make Available in Self Service", "Install Automatically"
  payloads            = file("${path.module}/support_files/configuration_profiles/passcode.mobileconfig")
  category_id         = -1
  user_removable      = false
  level               = "User"
  scope {
    all_computers = true
    all_jss_users = true
  }
}