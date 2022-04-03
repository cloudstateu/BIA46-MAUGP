resource "azurerm_virtual_network_peering" "vnet-hub-to-vnet-spoke-kubenet-peering" {
  provider                     = azurerm.dev
  name                         = "vnet-hub-to-vnet-spoke-kubenet-peering"
  resource_group_name          = azurerm_resource_group.hub-net-rg.name
  virtual_network_name         = azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet-spoke-kubenet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = false
  allow_gateway_transit        = false
}

resource "azurerm_virtual_network_peering" "vnet-spoke-kubenet-to-vnet-hub-peering" {
  provider                     = azurerm.dev
  name                         = "vnet-spoke-kubenet-to-vnet-hub-peering"
  resource_group_name          = azurerm_resource_group.spoke-net-rg.name
  virtual_network_name         = azurerm_virtual_network.vnet-spoke-kubenet.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet-hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = false
  allow_gateway_transit        = false
}

resource "azurerm_virtual_network_peering" "vnet-hub-to-vnet-spoke-cni-peering" {
  provider                     = azurerm.dev
  name                         = "vnet-hub-to-vnet-spoke-cni-peering"
  resource_group_name          = azurerm_resource_group.hub-net-rg.name
  virtual_network_name         = azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet-spoke-cni.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = false
  allow_gateway_transit        = false
}

resource "azurerm_virtual_network_peering" "vnet-spoke-cni-to-vnet-hub-peering" {
  provider                     = azurerm.dev
  name                         = "vnet-spoke-cni-to-vnet-hub-peering"
  resource_group_name          = azurerm_resource_group.spoke-net-rg.name
  virtual_network_name         = azurerm_virtual_network.vnet-spoke-cni.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet-hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = false
  allow_gateway_transit        = false
}
 