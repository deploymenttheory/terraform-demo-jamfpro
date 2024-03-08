resource "jamfpro_account" "jamfpro_account_001" {
  name                  = "tf-ghatest-account-custom"
  directory_user        = false
  full_name             = "Jonny Appleseed"
  password              = "mySecretThing10"
  email                 = "exampleEmailthing@domain.com"
  enabled               = "Enabled"
  force_password_change = true
  access_level          = "Group Access" // Full Access / Site Access / Group Access
  privilege_set         = "Custom"       // Custom

  // Use Terraform reference for group name
  groups {
    name = jamfpro_account_group.jamfpro_account_group_001.name
  }
}

data "jamfpro_account" "jamfpro_account_001_data" {
  id = jamfpro_account.jamfpro_account_001.id
}

output "jamfpro_account_001_data_id" {
  value = data.jamfpro_account.jamfpro_account_001_data.id
}

output "jamfpro_account_001_data_name" {
  value = data.jamfpro_account.jamfpro_account_001_data.name
}
