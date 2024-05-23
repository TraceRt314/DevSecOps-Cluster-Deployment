output "entra_id_group_id" {
  description = "The created Microsoft Entra ID object ID"
  value = module.azuread_group.entra_id_group_id
}

output "kube_config" {
  description = "Kube config output"
  value       = module.azurerm_kubernetes_cluster.kube_config
  sensitive = true
}

output "fqdn" {
  description = "The FQDN of the AKS cluster."
  value       = module.azurerm_kubernetes_cluster.fqdn
}

output "node_resource_group" {
  description = "The resource group for the AKS nodes."
  value       = module.azurerm_kubernetes_cluster.node_resource_group
}
