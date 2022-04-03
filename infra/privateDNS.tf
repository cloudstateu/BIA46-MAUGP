resource "azurerm_private_dns_zone" "akszone" {
  provider            = azurerm.dev
  name                = "akszone.privatelink.westeurope.azmk8s.io"
  resource_group_name = azurerm_resource_group.dev-dns-rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "akszone-to-kubnet" {
  provider              = azurerm.dev
  name                  = "akszone-to-kubnet"
  resource_group_name   = azurerm_resource_group.dev-dns-rg.name
  private_dns_zone_name = azurerm_private_dns_zone.akszone.name
  virtual_network_id    = azurerm_virtual_network.vnet-spoke-kubenet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "akszone-to-cni" {
  provider              = azurerm.dev
  name                  = "akszone-to-cni"
  resource_group_name   = azurerm_resource_group.dev-dns-rg.name
  private_dns_zone_name = azurerm_private_dns_zone.akszone.name
  virtual_network_id    = azurerm_virtual_network.vnet-spoke-cni.id
}