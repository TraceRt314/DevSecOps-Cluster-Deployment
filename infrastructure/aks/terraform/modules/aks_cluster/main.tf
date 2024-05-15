resource "azurerm_user_assigned_identity" "kubelet_identity" {
  name                = "${var.cluster_name}-agentpool-identity"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name            = "agentpool"
    node_count      = var.agent_count
    vm_size         = var.agent_vm_size
    os_disk_size_gb = var.node_os_disk_size_gb
    type            = "VirtualMachineScaleSets"
    zones = ["1", "2", "3"]
    enable_auto_scaling = true
    max_count          = 5
    min_count          = 2
    max_pods           = 110
    node_taints        = ["CriticalAddonsOnly=true:NoSchedule"]
    orchestrator_version = var.kubernetes_version
    os_disk_type = "Ephemeral"
    kubelet_disk_type = "OS"
    enable_node_public_ip = false
    node_labels = {
      "mode" = "System"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"
    load_balancer_sku = "standard"
    outbound_type = "managedNATGateway"
    service_cidr = "10.0.0.0/16"
  }

  azure_active_directory_role_based_access_control {
    managed = true
    admin_group_object_ids = [var.admin_group_id]
    azure_rbac_enabled = false
  }

  windows_profile {
    admin_username = var.admin_username
  }


  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  azure_policy_enabled = false

  auto_scaler_profile {
    balance_similar_node_groups = "false"
    expander = "random"
    max_graceful_termination_sec = "600"
    new_pod_scale_up_delay = "0s"
    scale_down_delay_after_add = "10m"
    scale_down_delay_after_delete = "10s"
    scale_down_delay_after_failure = "3m"
    scale_down_unneeded = "10m"
    scale_down_unready = "20m"
    scale_down_utilization_threshold = "0.5"
    scan_interval = "10s"
    skip_nodes_with_local_storage = "false"
    skip_nodes_with_system_pods = "true"
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "kubelet_identity_role" {
  scope                = azurerm_kubernetes_cluster.aks.node_resource_group
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_user_assigned_identity.kubelet_identity.principal_id
  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}