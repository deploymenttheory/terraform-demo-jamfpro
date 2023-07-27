provider "jamf" {
  username = var.username
  password = var.password

  # "This is the full url of jamf, xxxx.jamfcloud.com"
  url = var.url
}