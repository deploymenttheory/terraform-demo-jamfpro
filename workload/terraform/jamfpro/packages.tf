
resource "jamfpro_package" "jamfpro_package_001" {
  package_name          = "tf-ghatest-package-suspiciouspackage"
  package_file_path     = "support_files/packages/SuspiciousPackage.dmg"
  category_id           = "-1" // jamfpro_category.jamfpro_category_001.id
  info                  = "tf package deployment for demonstration"
  notes                 = "Uploaded by: terraform-provider-jamfpro plugin."
  priority              = 10
  reboot_required       = true
  fill_user_template    = false
  fill_existing_users   = false
  os_requirements       = "macOS 10.15.7, macOS 11.1"
  swu                   = false
  self_heal_notify      = false
  os_install            = false
  serial_number         = ""
  suppress_updates      = false
  ignore_conflicts      = false
  suppress_from_dock    = false
  suppress_eula         = false
  suppress_registration = false
  manifest              = ""
  manifest_file_name    = ""
}


data "jamfpro_package" "jamfpro_package_001_data" {
  id = jamfpro_package.jamfpro_package_001.id
}

output "jamfpro_package_001_data_id" {
  value = data.jamfpro_package.jamfpro_package_001_data.id
}

output "jamfpro_package_001_data_name" {
  value = data.jamfpro_package.jamfpro_package_001_data.name
}