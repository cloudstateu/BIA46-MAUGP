resource "azurerm_kubernetes_cluster" "aks" {
  provider                            = azurerm.dev
  name                                = "aks-cni"
  location                            = data.azurerm_resource_group.aks-cni-rg.location
  resource_group_name                 = data.azurerm_resource_group.aks-cni-rg.name
  dns_prefix                          = "aks-cni"
  private_cluster_enabled             = true
  private_cluster_public_fqdn_enabled = false
  private_dns_zone_id                 = data.azurerm_private_dns_zone.akszone.id
  sku_tier                            = "Free"
  local_account_disabled              = true
  azure_policy_enabled                = true
  node_resource_group                 = "rg-aks-cni-nodes"

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    outbound_type  = "userDefinedRouting"
  }

  default_node_pool {
    name           = "default"
    vnet_subnet_id = data.azurerm_subnet.subnet-backend.id
    node_count     = 1
    vm_size        = "Standard_DS2_v2"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.mui-cni.id]
  }

  kubelet_identity {
    client_id                 = data.azurerm_user_assigned_identity.mui-cni-kubelet.client_id
    object_id                 = data.azurerm_user_assigned_identity.mui-cni-kubelet.principal_id
    user_assigned_identity_id = data.azurerm_user_assigned_identity.mui-cni-kubelet.id
  }

  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }

  oms_agent {
    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.low-spoke.id
  }
}