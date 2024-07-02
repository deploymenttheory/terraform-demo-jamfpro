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
This change will trigger the null_resource.download_package 
resource, causing it to re-download the package. Since jamfpro_package.jamfpro_package_002
depends on null_resource.download_package, it ensures the package is downloaded before 
proceeding with its own creation.
*/

# Define the null_resource to manage the download package process
# resource "null_resource" "download_package" {
#   provisioner "local-exec" {
#     command = "curl -L -o /tmp/companyportallatest.pkg https://go.microsoft.com/fwlink/?linkid=853070"
#   }

#   # Using random_id to trigger the download when necessary
#   triggers = {
#     redeploy = "${random_id.download_trigger.hex}"
#   }
# }

# # Create a random_id to act as a trigger
# resource "random_id" "download_trigger" {
#   byte_length = 8
# }

# # Define the jamfpro_package resource
# resource "jamfpro_package" "jamfpro_package_002" {
#   depends_on            = [null_resource.download_package]
#   package_name          = "tf-ghatest-package-source:http-companyportal-latest"
#   package_file_path     = "/tmp/companyportallatest.pkg"
#   category_id           = "-1" // jamfpro_category.jamfpro_category_001.id
#   info                  = "tf package deployment for demonstration"
#   notes                 = "Uploaded by: terraform-provider-jamfpro plugin."
#   priority              = 10
#   reboot_required       = true
#   fill_user_template    = false
#   fill_existing_users   = false
#   os_requirements       = "macOS 10.15.0"
#   swu                   = false
#   self_heal_notify      = false
#   os_install            = false
#   serial_number         = ""
#   suppress_updates      = false
#   ignore_conflicts      = false
#   suppress_from_dock    = false
#   suppress_eula         = false
#   suppress_registration = false
#   manifest              = ""
#   manifest_file_name    = ""

#   # Force replacement if the null_resource triggers replacement
#   lifecycle {
#     replace_triggered_by = [null_resource.download_package.triggers["redeploy"]]
#   }
# }
