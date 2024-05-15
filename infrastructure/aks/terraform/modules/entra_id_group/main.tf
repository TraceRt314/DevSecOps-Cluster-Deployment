resource "azuread_group" "entra_id_group" {
  display_name     = var.admin_group_name
  owners           = ["OBJECT_ID_TO_REPLACE"]
  security_enabled = true

  members = [
    "OBJECT_ID_TO_REPLACE",
  ]
}