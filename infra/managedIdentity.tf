#kubenet
resource "azurerm_user_assigned_identity" "mui-kubenet" {
  provider            = azurerm.dev
  name                = "mui-kubenet"
  location            = azurerm_resource_group.aks-kubenet-rg.location
  resource_group_name = azurerm_resource_group.aks-kubenet-rg.name
}

resource "azurerm_user_assigned_identity" "mui-kubenet-kubelet" {
  provider            = azurerm.dev
  name                = "mui-kubenet-kubelet"
  location            = azurerm_resource_group.aks-kubenet-rg.location
  resource_group_name = azurerm_resource_group.aks-kubenet-rg.name
}

resource "azurerm_role_assignment" "mui-kubenet-private-dns-contributor" {
  provider             = azurerm.dev
  scope                = azurerm_private_dns_zone.akszone.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.mui-kubenet.principal_id
}

resource "azurerm_role_assignment" "mui-kubenet-contributor" {
  provider             = azurerm.dev
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.mui-kubenet.principal_id
}

resource "azurerm_role_assignment" "mui-kubenet-mi-operator" {
  provider             = azurerm.dev
  scope                = azurerm_user_assigned_identity.mui-kubenet-kubelet.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_user_assigned_identity.mui-kubenet.principal_id
}

#cni
resource "azurerm_user_assigned_identity" "mui-cni" {
  provider            = azurerm.dev
  name                = "mui-cni"
  location            = azurerm_resource_group.aks-cni-rg.location
  resource_group_name = azurerm_resource_group.aks-cni-rg.name
}

resource "azurerm_user_assigned_identity" "mui-cni-kubelet" {
  provider            = azurerm.dev
  name                = "mui-cni-kubelet"
  location            = azurerm_resource_group.aks-cni-rg.location
  resource_group_name = azurerm_resource_group.aks-cni-rg.name
}

resource "azurerm_role_assignment" "mui-cni-private-dns-contributor" {
  provider             = azurerm.dev
  scope                = azurerm_private_dns_zone.akszone.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.mui-cni.principal_id
}

resource "azurerm_role_assignment" "mui-cni-contributor" {
  provider             = azurerm.dev
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.mui-cni.principal_id
}

resource "azurerm_role_assignment" "mui-cni-mi-operator" {
  provider             = azurerm.dev
  scope                = azurerm_user_assigned_identity.mui-cni-kubelet.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_user_assigned_identity.mui-cni.principal_id
}
