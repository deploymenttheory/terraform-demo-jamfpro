
// Define a Jamf Pro Package Resource
# resource "jamfpro_package" "jamfpro_package_001" {
#   name                          = "tf-ghatest-package-suspiciouspackage"
#   package_file_path             = "support_files/packages/SuspiciousPackage.dmg"
#   category                      = "Unknown"
#   info                          = "tf package deployment for demonstration"
#   notes                         = "This package is used for Terraform provider documentation example."
#   priority                      = 10
#   reboot_required               = false
#   fill_user_template            = true
#   fill_existing_users           = true
#   boot_volume_required          = false
#   allow_uninstalled             = false
#   os_requirements               = "macOS 10.15.1, macOS 10.15.7"
#   install_if_reported_available = false
#   send_notification             = true
# }

# data "jamfpro_package" "jamfpro_package_001_data" {
#   id = jamfpro_package.jamfpro_package_001.id
# }

# output "jamfpro_package_001_data_id" {
#   value = data.jamfpro_package.jamfpro_package_001_data.id
# }

# output "jamfpro_package_001_data_name" {
#   value = data.jamfpro_package.jamfpro_package_001_data.name
# }