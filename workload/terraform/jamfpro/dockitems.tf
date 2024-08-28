
resource "jamfpro_dock_item" "jamfpro_dock_item_001" {
  name = "tf-ghatest-dockItem-app-iTunes"
  type = "App"
  path = "file://localhost/Applications/iTunes.app/"
}

resource "jamfpro_dock_item" "jamfpro_dock_item_002" {
  name = "tf-ghatest-dockItem-file-hosts"
  type = "File" // App / File / Folder
  path = "/etc/hosts"
}

resource "jamfpro_dock_item" "jamfpro_dock_item_003" {
  name = "tf-ghatest-dockItem-folder-downloadsFolder"
  type = "Folder" // App / File / Folder
  path = "~/Downloads"
}