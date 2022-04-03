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

data "azurerm_resource_group" "aks-kubenet-rg" {
  provider = azurerm.dev
  name     = "aks-kubenet-rg"
}

data "azurerm_private_dns_zone" "akszone" {
  provider            = azurerm.dev
  name                = "akszone.privatelink.westeurope.azmk8s.io"
  resource_group_name = data.azurerm_resource_group.dev-dns-rg.name
}

data "azurerm_virtual_network" "vnet-spoke-kubenet" {
  provider            = azurerm.dev
  name                = "vnet-spoke-kubenet"
  resource_group_name = data.azurerm_resource_group.spoke-net-rg.name
}

data "azurerm_subnet" "subnet-backend" {
  provider             = azurerm.dev
  name                 = "subnet-backend"
  virtual_network_name = data.azurerm_virtual_network.vnet-spoke-kubenet.name
  resource_group_name  = data.azurerm_resource_group.spoke-net-rg.name
}

data "azurerm_log_analytics_workspace" "low-spoke" {
  provider            = azurerm.dev
  name                = "low-spoke"
  resource_group_name = data.azurerm_resource_group.spoke-net-rg.name
}

data "azurerm_user_assigned_identity" "mui-kubenet" {
  provider            = azurerm.dev
  name                = "mui-kubenet"
  resource_group_name = data.azurerm_resource_group.aks-kubenet-rg.name
}

data "azurerm_user_assigned_identity" "mui-kubenet-kubelet" {
  provider            = azurerm.dev
  name                = "mui-kubenet-kubelet"
  resource_group_name = data.azurerm_resource_group.aks-kubenet-rg.name
}