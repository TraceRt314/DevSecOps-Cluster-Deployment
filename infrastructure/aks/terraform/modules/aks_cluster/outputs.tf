output "kube_config" {
  description = "Kube config output"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "fqdn" {
  description = "The FQDN of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.fqdn
}

output "node_resource_group" {
  description = "The resource group for the AKS nodes."
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}
