
# // account group - custom example
# resource "jamfpro_account_group" "jamfpro_account_group_001" {
#   name          = "tf-ghatest-accountgroup-custom"
#   access_level  = "Full Access" // Full Access / Site Access / Group Access
#   privilege_set = "Custom"

#   site {
#     id   = -1
#     name = "None"
#   }

#   jss_objects_privileges = [
#     "Create Advanced Computer Searches",
#     "Read Advanced Computer Searches",
#     "Update Advanced Computer Searches",
#     "Delete Advanced Computer Searches",
#     "Create Advanced Mobile Device Searches",
#     "Read Advanced Mobile Device Searches",
#     "Update Advanced Mobile Device Searches",
#     "Delete Advanced Mobile Device Searches",
#     "Create Advanced User Searches",
#     "Read Advanced User Searches",
#     "Update Advanced User Searches",
#     "Delete Advanced User Searches",
#     "Create Advanced User Content Searches",
#     "Read Advanced User Content Searches",
#     "Update Advanced User Content Searches",
#     "Delete Advanced User Content Searches",
#     "Create AirPlay Permissions",
#     "Read AirPlay Permissions",
#     "Update AirPlay Permissions",
#     "Delete AirPlay Permissions",
#   ]

#   jss_settings_privileges = [
#     "Read Activation Code",
#     "Update Activation Code",
#     "Read Apache Tomcat Settings",
#     "Update Apache Tomcat Settings",
#     "Read Apple Configurator Enrollment",
#     "Update Apple Configurator Enrollment",
#     "Read Education Settings",
#     "Update Education Settings",
#     "Read Mobile Device App Maintenance Settings",
#     "Update Mobile Device App Maintenance Settings",
#     "Read Automatic Mac App Updates Settings",
#     "Update Automatic Mac App Updates Settings",
#     "Read Automatically Renew MDM Profile Settings",
#     "Update Automatically Renew MDM Profile Settings",
#     "Read Cache",
#     "Update Cache",
#   ]

#   jss_actions_privileges = [
#     "Allow User to Enroll",
#     //"Assign Users to Computers",
#     "Assign Users to Mobile Devices",
#     "Change Password",
#     "Dismiss Notifications",
#     "Flush MDM Commands",
#     "Flush Policy Logs",
#     "Jamf Packages Action",
#     "Remove restrictions set by Jamf Parent",
#     "CLEAR_TEACHER_PROFILE_PRIVILEGE",
#     "Renewal of the Built-in Certificate Authority",
#     "Jamf Connect Deployment Retry",
#     "Jamf Protect Deployment Retry",
#     "Send Application Attributes Command",
#     "Send Blank Pushes to Mobile Devices",
#   ]

#   casper_admin_privileges = [
#   ]

# }

# data "jamfpro_account_group" "jamfpro_account_group_001_data" {
#   id = jamfpro_account_group.jamfpro_account_group_001.id
# }

# output "jamfpro_account_group_001_data_id" {
#   value = data.jamfpro_account_group.jamfpro_account_group_001_data.id
# }

# output "jamfpro_account_group_001_data_name" {
#   value = data.jamfpro_account_group.jamfpro_account_group_001_data.name
# }


# // account group - administrator example
# resource "jamfpro_account_group" "jamfpro_account_group_002" {
#   name          = "tf-ghatest-account_group-administrator"
#   access_level  = "Full Access" // Full Access / Site Access / Group Access
#   privilege_set = "Administrator"

#   site {
#     id   = -1
#     name = "None"
#   }

# }

# data "jamfpro_account_group" "jamfpro_account_group_002_data" {
#   id = jamfpro_account_group.jamfpro_account_group_002.id
# }

# output "jamfpro_account_group_002_data_id" {
#   value = data.jamfpro_account_group.jamfpro_account_group_002_data.id
# }

# output "jamfpro_account_group_002_data_name" {
#   value = data.jamfpro_account_group.jamfpro_account_group_002_data.name
# }


# # // account group - auditor example
# resource "jamfpro_account_group" "jamfpro_account_group_003" {
#   name          = "tf-ghatest-account_group-auditor"
#   access_level  = "Full Access" // Full Access / Site Access / Group Access
#   privilege_set = "Auditor"

#   site {
#     id   = -1
#     name = "None"
#   }

# }

# data "jamfpro_account_group" "jamfpro_account_group_003_data" {
#   id = jamfpro_account_group.jamfpro_account_group_003.id
# }

# output "jamfpro_account_group_003_data_id" {
#   value = data.jamfpro_account_group.jamfpro_account_group_003_data.id
# }

# output "jamfpro_account_group_003_data_name" {
#   value = data.jamfpro_account_group.jamfpro_account_group_003_data.name
# }


# # // account group - enrollment only example
# resource "jamfpro_account_group" "jamf_pro_account_group_004" {
#   name          = "tf-ghatest-account_group-enrollmentonly"
#   access_level  = "Full Access" // Full Access / Site Access / Group Access
#   privilege_set = "Enrollment Only"

#   site {
#     id   = -1
#     name = "None"
#   }

# }

# data "jamfpro_account_group" "jamf_pro_account_group_004_data" {
#   id = jamfpro_account_group.jamf_pro_account_group_004.id
# }

# output "jamf_pro_account_group_004_data_id" {
#   value = data.jamfpro_account_group.jamf_pro_account_group_004_data.id
# }

# output "jamf_pro_account_group_004_data_name" {
#   value = data.jamfpro_account_group.jamf_pro_account_group_004_data.name
# }