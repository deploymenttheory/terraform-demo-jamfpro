
// jamfpro Institutional Recovery Key config tf example 

resource "jamfpro_disk_encryption_configuration" "jamfpro_disk_encryption_configuration_001" {
  name                     = "tf-ghatest-diskencryption-institutional_recovery_key"
  key_type                 = "Institutional"      # Or "Individual and Institutional"
  file_vault_enabled_users = "Management Account" # Or "Current or Next User"

  institutional_recovery_key {
    certificate_type = "PKCS12" # For .p12 certificate types
    password         = "secretThing"
    data             = filebase64("${path.module}/support_files/filevaultcertificate/FileVaultMaster-sdk.p12")
  }
}

data "jamfpro_disk_encryption_configuration" "jamfpro_disk_encryption_configuration_001_data" {
  id = jamfpro_disk_encryption_configuration.jamfpro_disk_encryption_configuration_001.id
}

output "jamfpro_disk_encryption_configuration_001_id" {
  value = data.jamfpro_disk_encryption_configuration.jamfpro_disk_encryption_configuration_001_data.id
}

output "jamfpro_disk_encryption_configuration_001_name" {
  value = data.jamfpro_disk_encryption_configuration.jamfpro_disk_encryption_configuration_001_data.name
}

// jamfpro Individual Recovery Key config tf example 

resource "jamfpro_disk_encryption_configuration" "jamfpro_disk_encryption_configuration_002" {
  name                     = "tf-ghatest-diskencryption-individual_recovery_key"
  key_type                 = "Individual"
  file_vault_enabled_users = "Management Account" # Or "Current or Next User"

}

data "jamfpro_disk_encryption_configuration" "jamfpro_disk_encryption_configuration_002_data" {
  id = jamfpro_disk_encryption_configuration.jamfpro_disk_encryption_configuration_002.id
}

output "jamfpro_disk_encryption_configuration_002_id" {
  value = data.jamfpro_disk_encryption_configuration.jamfpro_disk_encryption_configuration_002_data.id
}

output "jamfpro_disk_encryption_configuration_002_name" {
  value = data.jamfpro_disk_encryption_configuration.jamfpro_disk_encryption_configuration_002_data.name
}