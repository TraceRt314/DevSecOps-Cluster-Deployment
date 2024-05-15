output "entra_id_group_id" {
  description = "The ID of the generated Microsoft Entra ID group"
  value = azuread_group.entra_id_group.object_id
}