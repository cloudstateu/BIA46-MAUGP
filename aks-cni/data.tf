data "azurerm_subscription" "current" {
  provider = azurerm.dev
}

data "azurerm_resource_group" "spoke-net-rg" {
  provider = azurerm.dev
  name     = "spoke-net-rg"
}

data "azurerm_resource_group" "dev-dns-rg" {
  provider = azurerm.dev
  name     = "dev-dns-rg"
}

data "azurerm_resource_group" "aks-cni-rg" {
  provider = azurerm.dev
  name     = "aks-cni-rg"
}

data "azurerm_private_dns_zone" "akszone" {
  provider            = azurerm.dev
  name                = "akszone.privatelink.westeurope.azmk8s.io"
  resource_group_name = data.azurerm_resource_group.dev-dns-rg.name
}

data "azurerm_virtual_network" "vnet-spoke-cni" {
  provider            = azurerm.dev
  name                = "vnet-spoke-cni"
  resource_group_name = data.azurerm_resource_group.spoke-net-rg.name
}

data "azurerm_subnet" "subnet-backend" {
  provider             = azurerm.dev
  name                 = "subnet-backend"
  virtual_network_name = data.azurerm_virtual_network.vnet-spoke-cni.name
  resource_group_name  = data.azurerm_resource_group.spoke-net-rg.name
}

data "azurerm_log_analytics_workspace" "low-spoke" {
  provider            = azurerm.dev
  name                = "low-spoke"
  resource_group_name = data.azurerm_resource_group.spoke-net-rg.name
}

data "azurerm_user_assigned_identity" "mui-cni" {
  provider            = azurerm.dev
  name                = "mui-cni"
  resource_group_name = data.azurerm_resource_group.aks-cni-rg.name
}

data "azurerm_user_assigned_identity" "mui-cni-kubelet" {
  provider            = azurerm.dev
  name                = "mui-cni-kubelet"
  resource_group_name = data.azurerm_resource_group.aks-cni-rg.name
}