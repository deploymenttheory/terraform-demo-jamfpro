resource "jamfpro_script" "jamfpro_script_001" {
  name            = "tf-demo-correct-application-permissions-v1.0"
  script_contents = file("${path.module}/support_files/scripts/Correct Application Permissions.sh")
  os_requirements = "13"
  priority        = "BEFORE"
  info            = "Adds target user or group to specified group membership, or removes said membership."
  notes           = "Jamf Pro script parameters: 4 -> 7"
  parameter4      = "Google Chrome" // targetApplication
}

resource "jamfpro_script" "jamfpro_script_002" {
  name            = "tf-demo-encrypt-apfs-volume-v5.0.2"
  script_contents = file("${path.module}/support_files/scripts/Encrypt_APFS_Volume.zsh")
  os_requirements = "13"
  priority        = "BEFORE"
  info            = "Adds target user or group to specified group membership, or removes said membership."
  notes           = "Jamf Pro script parameters: 4"
  parameter4      = "/" // targetVolume
}

# resource "jamfpro_script" "jamfpro_script_003" {
#   name            = "tf-demo-reset-safari-v2.1.4"
#   script_contents = file("${path.module}/support_files/scripts/Reset_Safari.sh")
#   os_requirements = "15"
#   priority        = "BEFORE"
#   info            = "Deleting Safari preference files to reset to system default."
#   notes           = "Jamf Pro script parameters: none"
# }

# resource "jamfpro_script" "jamfpro_script_004" {
#   name            = "tf-demo-update-jamf-pro-inventory-and-set-logged-in-user-as-associated-user-v2.1.4"
#   script_contents = file("${path.module}/support_files/scripts/Update Jamf Pro Inventory and Set Logged-In User as Associated User.sh")
#   os_requirements = "15"
#   priority        = "BEFORE"
#   info            = "Update Jamf Pro inventory, assigning the computer record to the currently logged-in user.."
#   notes           = "Jamf Pro script parameters: none"
# }