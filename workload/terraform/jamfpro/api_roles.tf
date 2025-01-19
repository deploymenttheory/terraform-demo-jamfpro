
// cicd jamf api roles with no priviledge as they will be applied dynamically 
resource "jamfpro_api_role" "jamfpro_api_role_001" {
   display_name = "tf-demo-all-jamf-pro-privileges-11.7"
}

resource "jamfpro_api_role" "jamfpro_api_role_002" {
display_name = "tf-demo-all-jamf-pro-privileges-11.9.1"
 }
