resource "jamfpro_category" "jamfpro_category_001" {
  name     = "tf-ghatest-category-01"
  priority = 5
}

data "jamfpro_category" "jamfpro_category_001_data" {
}

output "jamfpro_category_001_data_id" {
  value = data.jamfpro_category.jamfpro_category_001_data.id
}

output "jamfpro_category_001_data_name" {
  value = data.jamfpro_category.jamfpro_category_001_data.name
}