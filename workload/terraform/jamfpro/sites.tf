# resource "jamfpro_site" "jamfpro_site_001" {
#   name = "tf-ghatest-site-uk"
# }

# resource "jamfpro_site" "site_002" {
#   name = "tf-ghatest-site-india"
# }

# data "jamfpro_site" "jamfpro_site_001_data" {
#   id = jamfpro_site.jamfpro_site_001.id
# }

# output "jamfpro_site_001_id" {
#   value = data.jamfpro_site.jamfpro_site_001_data.id
# }

# output "jamfpro_site_001_name" {
#   value = data.jamfpro_site.jamfpro_site_001_data.name
# }

# data "jamfpro_site" "jamfpro_site_002" {
#   id = jamfpro_site.site_002.id
# }

# output "jamfpro_site_002_id" {
#   value = data.jamfpro_site.jamfpro_site_002.id
# }

# output "jamfpro_site_002_name" {
#   value = data.jamfpro_site.jamfpro_site_002.name
# }