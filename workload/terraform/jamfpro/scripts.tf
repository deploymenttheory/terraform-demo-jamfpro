# resource "jamfpro_script" "script_001" {
#   name            = "[scpt]-add-or-remove-group-membership-v4.0"
#   script_contents = file("support_files/scripts/Add or Remove Group Membership.zsh")
#   os_requirements = "13"
#   priority        = "BEFORE"
#   info            = "Adds target user or group to specified group membership, or removes said membership."
#   notes           = "Jamf Pro script parameters 4 -> 7"
#   parameter4      = "100" // targetID
#   parameter5      = "group" // Target Type - Must be either "user" or "group"
#   parameter6      = "someGroupName" // targetMembership
#   parameter7      = "add" // Script Action - Must be either "add" or "remove"
# }

# data "jamfpro_script" "script_001_data" {
#   id = jamfpro_script.script_001.id
# }

# output "jamfpro_script_001_id" {
#   value = data.jamfpro_script.script_001_data.id
# }

# output "jamfpro_script_001_name" {
#   value = data.jamfpro_script.script_001_data.name
# }

# resource "jamfpro_script" "script_002" {
#   name            = "[scpt]-convert-admin-account-to-standard-v1.2.4"
#   script_contents = file("support_files/scripts/Convert Admin Account to Standard.sh")
#   os_requirements = "10"
#   priority        = "BEFORE"
#   info            = "Removes admin privileges from target account."
#   notes           = "Jamf Pro script parameters 4"
#   parameter4      = "SteveJobs" // targetAccount
# }

# data "jamfpro_script" "script_002_data" {
#   id = jamfpro_script.script_002.id
# }

# output "jamfpro_script_002_id" {
#   value = data.jamfpro_script.script_002_data.id
# }

# output "jamfpro_script_002_name" {
#   value = data.jamfpro_script.script_002_data.name
# }



# resource "jamfpro_script" "scripts_0004" {
#   name            = "[scpt]-convert-logged-in-user-to-admin-v1.1.2"
#   script_contents = file("support_files/scripts/Convert Logged-In User to Admin.sh")
#   os_requirements = "10"
#   priority        = "BEFORE"
#   info = "Grants admin privileges to logged-in user."
#   notes = "Jamf Pro script parameters 4"

# }

# resource "jamfpro_script" "scripts_0005" {
#   name            = "[scpt]-enable-guest-account.sh-v1.1.1"
#   script_contents = file("support_files/scripts/Enable Guest Account.sh")
#   os_requirements = "10"
#   priority        = "BEFORE"
#   info = "Enables guest account."
#   notes = ""

# }


# resource "jamfpro_script" "scripts_0006" {
#   count    = 10
#   name            = "[scpt]-add-apfs-volume-to-startup-container-v8.0-${format("%03d", count.index + 1)}"
#   script_contents = file("support_files/scripts/Add APFS Volume to Startup Container.sh")
#   //category = "No category assigned"
#   os_requirements = "16.1"
#   priority        = "BEFORE"
#   info = "Creates additional APFS volume at /Volumes/$newVolumeName (sharing space with other volumes in the startup volume container), using either predefined script parameters or responses from user-facing prompts for any undefined required values."
#   notes = "Jamf Pro script parameters 4 -> 8"
#   parameter4  = "Macintosh HD"  // newVolumeName
#   parameter5  = "APFS"          // newVolumeAPFSFormat
#   parameter8  = "100"           // newVolumeQuotaPercent

# }

# resource "jamfpro_script" "scripts_0007" {
#   count    = 100
#   name            = "[scpt]-disable-OCSP-v1.0.4-${format("%03d", count.index + 1)}"
#   script_contents = "hello world"
#   os_requirements = "13.1"
#   priority        = "BEFORE"
#   info = "Creates additional APFS volume at /Volumes/$newVolumeName (sharing space with other volumes in the startup volume container), using either predefined script parameters or responses from user-facing prompts for any undefined required values."
#   notes = "Jamf Pro script parameters 4 -> 8"

# }
