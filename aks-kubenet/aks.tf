resource "azurerm_kubernetes_cluster" "aks" {
  provider                            = azurerm.dev
  name                                = "aks-kubenet"
  location                            = data.azurerm_resource_group.aks-kubenet-rg.location
  resource_group_name                 = data.azurerm_resource_group.aks-kubenet-rg.name
  dns_prefix                          = "aks-kubenet"
  private_cluster_enabled             = true
  private_cluster_public_fqdn_enabled = false
  private_dns_zone_id                 = data.azurerm_private_dns_zone.akszone.id
  sku_tier                            = "Free"
  local_account_disabled              = true
  azure_policy_enabled                = true
  node_resource_group                 = "rg-aks-kubenet-nodes"

  network_profile {
    network_plugin     = "kubenet"
    pod_cidr           = "10.100.0.0/17"
    service_cidr       = "10.100.128.0/17"
    dns_service_ip     = "10.100.128.10"
    docker_bridge_cidr = "172.17.0.1/16"
    network_policy     = "calico"
    outbound_type      = "userDefinedRouting"
  }

  default_node_pool {
    name           = "default"
    vnet_subnet_id = data.azurerm_subnet.subnet-backend.id
    node_count     = 1
    vm_size        = "Standard_DS2_v2"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.mui-kubenet.id]
  }

  kubelet_identity {
    client_id                 = data.azurerm_user_assigned_identity.mui-kubenet-kubelet.client_id
    object_id                 = data.azurerm_user_assigned_identity.mui-kubenet-kubelet.principal_id
    user_assigned_identity_id = data.azurerm_user_assigned_identity.mui-kubenet-kubelet.id
  }

  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }

  oms_agent {
    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.low-spoke.id
  }
}