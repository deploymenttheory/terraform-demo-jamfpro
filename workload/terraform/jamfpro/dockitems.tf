
// App Dock Item Example
# resource "jamfpro_dock_item" "jamfpro_dock_item_001" {
#   name = "tf-ghatest-dockItem-app-iTunes"
#   type = "App"
#   path = "file://localhost/Applications/iTunes.app/"
# }

# // File Dock Item Example
# resource "jamfpro_dock_item" "jamfpro_dock_item_002" {
#   name = "tf-ghatest-dockItem-file-hosts"
#   type = "File" // App / File / Folder
#   path = "/etc/hosts"
# }

# // Folder Dock Item Example
# resource "jamfpro_dock_item" "jamfpro_dock_item_003" {
#   name = "tf-ghatest-dockItem-folder-downloadsFolder"
#   type = "Folder" // App / File / Folder
#   path = "~/Downloads"
# }

# data "jamfpro_dock_item" "jamfpro_dock_item_001_data" {
#   id = jamfpro_dock_item.jamfpro_dock_item_001.id
# }

# output "jamfpro_dock_item_001_id" {
#   value = data.jamfpro_dock_item.jamfpro_dock_item_001_data.id
# }

# output "jamfpro_dock_item_001_name" {
#   value = data.jamfpro_dock_item.jamfpro_dock_item_001_data.name
# }

# data "jamfpro_dock_item" "jamfpro_dock_item_002_data" {
#   id = jamfpro_dock_item.jamfpro_dock_item_002.id
# }

# output "jamfpro_dock_item_002_id" {
#   value = data.jamfpro_dock_item.jamfpro_dock_item_002_data.id
# }

# output "jamfpro_dock_item_002_name" {
#   value = data.jamfpro_dock_item.jamfpro_dock_item_002_data.name
# }

# data "jamfpro_dock_item" "jamfpro_dock_item_003_data" {
#   id = jamfpro_dock_item.jamfpro_dock_item_003.id
# }

# output "jamfpro_dock_item_003_id" {
#   value = data.jamfpro_dock_item.jamfpro_dock_item_003_data.id
# }

# output "jamfpro_dock_item_003_name" {
#   value = data.jamfpro_dock_item.jamfpro_dock_item_003_data.name
# }