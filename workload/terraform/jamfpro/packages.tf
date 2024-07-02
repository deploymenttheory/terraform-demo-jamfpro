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

/* Example of downloading a package from a URL and uploading it to Jamf Pro with a trigger.
Logic:
If the jamfpro_package.jamfpro_package_002 resource needs to be replaced 
(due to any change in its attributes or if it is missing from the server), 
its ID will change.
This change will trigger the triggers_replace in the terraform_data.download_package 
resource, causing it to re-download the package.Since jamfpro_package.jamfpro_package_002
depends on terraform_data.download_package, it ensures the package is downloaded before 
proceeding with its own creation.
*/
resource "terraform_data" "download_package" {
  triggers_replace = [
    # This will trigger replacement based on the jamfpro_package resource
    jamfpro_package.jamfpro_package_002.id
  ]

  provisioner "local-exec" {
    command = "curl -L -o /tmp/companyportallatest.pkg https://go.microsoft.com/fwlink/?linkid=853070"
  }
}

# Define the jamfpro_package resource
resource "jamfpro_package" "jamfpro_package_002" {
  depends_on            = [terraform_data.download_package]
  package_name          = "tf-ghatest-package-source:http-companyportal-latest"
  package_file_path     = "/tmp/companyportallatest.pkg"
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

  # Force replacement if the terraform_data triggers replacement
  lifecycle {
    replace_triggered_by = [terraform_data.download_package.id]
  }
}
