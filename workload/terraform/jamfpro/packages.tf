// Example of referencing a package directly within the repository
resource "jamfpro_package" "jamfpro_package_001" {
  package_name          = "tf-ghatest-package-suspiciouspackage"
  package_file_path     = "support_files/packages/gha-test-SuspiciousPackage.dmg"
  category_id           = "-1" // jamfpro_category.jamfpro_category_001.id
  info                  = "tf package deployment for demonstration"
  notes                 = "Uploaded by: terraform-provider-jamfpro plugin."
  priority              = 10
  reboot_required       = true
  fill_user_template    = false
  fill_existing_users   = false
  os_requirements       = "macOS 10.15.0"
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

// Example of downloading a package from a URL and uploading it to Jamf Pro
resource "terraform_data" "download_package" {
  provisioner "local-exec" {
    command = "curl -L -o /tmp/ghatest-companyportal-latest.pkg https://go.microsoft.com/fwlink/?linkid=853070"
  }
}

resource "jamfpro_package" "jamfpro_package_002" {
  depends_on            = [terraform_data.download_package]
  package_name          = "tf-ghatest-package-source:http-companyportal-latest"
  package_file_path     = "/tmp/ghatest-companyportal-latest.pkg"
  category_id           = "-1" // jamfpro_category.jamfpro_category_001.id
  info                  = "tf package deployment for demonstration"
  notes                 = "Uploaded by: terraform-provider-jamfpro plugin."
  priority              = 10
  reboot_required       = true
  fill_user_template    = false
  fill_existing_users   = false
  os_requirements       = "macOS 10.15.0"
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
