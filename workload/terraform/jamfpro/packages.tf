# // Example of referencing a package directly within the repository
# resource "jamfpro_package" "jamfpro_package_001" {
#   package_name          = "tf-ghatest-package-suspiciouspackage"
#   package_file_source   = "support_files/packages/gha-test-SuspiciousPackage.dmg"
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
# }


# // https://go.microsoft.com/fwlink/?linkid=853070 - company portal
# // https://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US - firefox

# // Example of referencing a package from a https source (with redirects)
# resource "jamfpro_package" "jamfpro_package_02" {
#   package_name          = "tf-ghatest-package-httpsourceprovider-test"
#   package_file_source   = "https://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US"
#   category_id           = "-1"
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
# }

# // Example of referencing a package from a https source
# resource "jamfpro_package" "jamfpro_package_03" {
#   package_name          = "tf-ghatest-package-httpsourceprovider-companyportal"
#   package_file_source   = "https://go.microsoft.com/fwlink/?linkid=853070"
#   category_id           = "-1"
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
# }
