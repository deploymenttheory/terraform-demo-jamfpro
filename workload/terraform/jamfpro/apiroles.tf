
// cicd jamf api roles with no priviledge as they will be applied dynamically 
# resource "jamfpro_api_role" "api_role_cicd_pipeline_1" {
#   display_name = "apir-cicdpipeline1-crud"
#   privileges   = []
# }
/*
data "jamfpro_api_role" "api_role_apiintegrations" {
  name = "apir-apiintegrations-crud"  # Replace with the actual name of the API role
}

resource "jamfpro_api_role" "api_role_cicd_pipeline_2" {
  display_name = "apir-cicdpipeline2-crud"
  privileges   = []
}
resource "jamfpro_api_role" "api_role_cicd_pipeline_3" {
  display_name = "apir-cicdpipeline3-crud"
  privileges   = []
}

resource "jamfpro_api_role" "api_role_api_roles_1" {
  display_name = "apir-apiroles-crud"
  privileges   = ["Create API Roles", "Update API Roles", "Read API Roles", "Delete API Roles"]
}

resource "jamfpro_api_role" "api_role_api_integrations_1" {
  display_name = "apir-apiintegrations-crud"
  privileges   = ["Create API Integrations","Update API Integrations", "Read API Integrations", "Delete API Integrations"]
}
*/

/*
resource "jamfpro_api_role" "api_role_departments" {
  display_name = "apir-departments-crud"
  privileges   = ["Create Departments", "Update Departments", "Read Departments", "Delete Departments"]
}

resource "jamfpro_api_role" "api_role_smart_computer_groups" {
  display_name = "apir-smartcomputergroups-crud"
  privileges   = ["Create Smart Computer Groups", "Update Smart Computer Groups", "Read Smart Computer Groups", "Delete Smart Computer Groups"]
}

resource "jamfpro_api_role" "api_role_advanced_computer_searches" {
  display_name = "apir-advancedcomputersearches-crud"
  privileges   = ["Create Advanced Computer Searches", "Update Advanced Computer Searches", "Read Advanced Computer Searches", "Delete Advanced Computer Searches"]
}

resource "jamfpro_api_role" "api_role_advanced_mobile_device_searches" {
  display_name = "apir-advancedmobiledevicesearches-crud"
  privileges   = ["Create Advanced Mobile Device Searches", "Update Advanced Mobile Device Searches", "Read Advanced Mobile Device Searches", "Delete Advanced Mobile Device Searches"]
}

resource "jamfpro_api_role" "api_role_buildings" {
  display_name = "apir-buildings-crud"
  privileges   = ["Create Buildings", "Update Buildings", "Read Buildings", "Delete Buildings"]
}



data "jamfpro_api_role" "api_role_computerextensionattributes" {
  name = "apir-computerextensionattributes-crud" 
}
*/


