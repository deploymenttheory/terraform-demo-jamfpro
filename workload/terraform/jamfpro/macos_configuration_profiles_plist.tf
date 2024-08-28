
resource "jamfpro_macos_configuration_profile_plist" "jamfpro_macos_configuration_profile_001" {
  name                = "tf-ghatest-dt-mcp-accessibility_hearing_base-prod-v0.0.1"
  distribution_method = "Install Automatically"
  payloads            = file("${path.module}/support_files/configuration_profiles/dt-mcp-accessibility_hearing_base-prod-v0.0.1.mobileconfig")
  category_id         = jamfpro_category.jamfpro_category_001.id
  user_removable      = false
  level               = "System"
  redeploy_on_update  = "Newly Assigned"
  scope {
    all_computers = true
    all_jss_users = true
  }
}

resource "jamfpro_macos_configuration_profile_plist" "jamfpro_macos_configuration_profile_002" {
  name                = "tf-ghatest-dt-mcp-accessibility_seeing_base-prod-v0.0.1"
  distribution_method = "Install Automatically"
  payloads            = file("${path.module}/support_files/configuration_profiles/dt-mcp-accessibility_seeing_base-prod-v0.0.1.mobileconfig")
  category_id         = jamfpro_category.jamfpro_category_001.id
  user_removable      = false
  level               = "System"
  redeploy_on_update  = "Newly Assigned"
  scope {
    all_computers = true
    all_jss_users = true
  }
}

resource "jamfpro_macos_configuration_profile_plist" "jamfpro_macos_configuration_profile_003" {
  name                = "tf-ghatest-dt-mcp-background_notifications-prod-v0.0.1"
  distribution_method = "Install Automatically"
  payloads            = file("${path.module}/support_files/configuration_profiles/dt-mcp-background_notifications-prod-v0.0.1.mobileconfig")
  category_id         = jamfpro_category.jamfpro_category_001.id
  user_removable      = false
  level               = "System"
  redeploy_on_update  = "Newly Assigned"
  scope {
    all_computers = true
    all_jss_users = true
  }
}

resource "jamfpro_macos_configuration_profile_plist" "jamfpro_macos_configuration_profile_004" {
  name                = "tf-ghatest-dt-mcp-block_beta_updates-prod-v0.0.1"
  distribution_method = "Install Automatically"
  payloads            = file("${path.module}/support_files/configuration_profiles/dt-mcp-block_beta_updates-prod-v0.0.1.mobileconfig")
  category_id         = jamfpro_category.jamfpro_category_001.id
  user_removable      = false
  level               = "System"
  redeploy_on_update  = "Newly Assigned"
  scope {
    all_computers = true
    all_jss_users = true
  }
}