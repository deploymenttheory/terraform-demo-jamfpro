resource "jamfpro_script" "script_001" {
  name            = "[scpt]-add-or-remove-group-membership-v4.0"
  script_contents = file("${path.module}/../../support_files/scripts/Add or Remove Group Membership.zsh")
  os_requirements = "13"
  priority        = "BEFORE"
  info            = "Adds target user or group to specified group membership, or removes said membership."
  notes           = "Jamf Pro script parameters: 4 -> 7"
  parameter4      = "100"           // targetID
  parameter5      = "group"         // Target Type - Must be either "user" or "group"
  parameter6      = "someGroupName" // targetMembership
  parameter7      = "add"           // Script Action - Must be either "add" or "remove"
}

resource "jamfpro_script" "script_002" {
  name            = "[scpt]-encrypt-apfs-volume-v5.0.1"
  script_contents = file("${path.module}/../../support_files/scripts/Encrypt APFS Volume.zsh")
  os_requirements = "13"
  priority        = "BEFORE"
  info            = "Adds target user or group to specified group membership, or removes said membership."
  notes           = "Jamf Pro script parameters: 4"
  parameter4      = "/" // targetVolume
}

resource "jamfpro_script" "script_003" {
  name            = "[scpt]-reset-safari-v2.1.4"
  script_contents = file("${path.module}/../../support_files/scripts/Reset Safari.sh")
  os_requirements = "13"
  priority        = "BEFORE"
  info            = "Deleting Safari preference files to reset to system default."
  notes           = "Jamf Pro script parameters: none"

}

data "jamfpro_script" "script_001_data" {
  id = jamfpro_script.script_001.id
}

output "jamfpro_script_001_id" {
  value = data.jamfpro_script.script_001_data.id
}

output "jamfpro_script_001_name" {
  value = data.jamfpro_script.script_001_data.name
}
