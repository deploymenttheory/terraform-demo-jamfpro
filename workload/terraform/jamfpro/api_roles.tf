
// cicd jamf api roles with no priviledge as they will be applied dynamically 
resource "jamfpro_api_role" "jamfpro_api_role_001" {
   display_name = "tf-demo-all-jamf-pro-privileges-11.7"
privileges = ["Allow User to Enroll",
    "Assign Users to Computers",
    "Assign Users to Mobile Devices",
    "CLEAR_TEACHER_PROFILE_PRIVILEGE",
    "Change Password",
    "Create API Integrations",
    "Create API Roles",
    "Create Accounts"]
}
