data "azurerm_subscription" "current" {
  provider = azurerm.dev
}

data "azurerm_management_group" "root_management_group" {
  provider = azurerm.dev
  name     = data.azurerm_subscription.current.tenant_id
}

data "azurerm_resource_group" "aks-cni-rg" {
  provider = azurerm.dev
  name     = "aks-cni-rg"
}

data "azurerm_kubernetes_cluster" "public-aks-cni" {
  provider            = azurerm.dev
  name                = "public-aks-cni"
  resource_group_name = data.azurerm_resource_group.aks-cni-rg.name
}


