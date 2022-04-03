resource "azurerm_virtual_network" "vnet-hub" {
  provider            = azurerm.dev
  name                = "vnet-hub"
  location            = azurerm_resource_group.hub-net-rg.location
  resource_group_name = azurerm_resource_group.hub-net-rg.name
  address_space       = [var.vnet-hub]
}

resource "azurerm_subnet" "vnet-hub-subnet" {
  provider             = azurerm.dev
  name                 = "vnet-hub-subnet"
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  resource_group_name  = azurerm_resource_group.hub-net-rg.name
  address_prefixes     = [var.vnet-hub-gateway-subnet]
}

resource "azurerm_subnet" "AzureFirewallSubnet" {
  provider             = azurerm.dev
  name                 = "AzureFirewallSubnet"
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  resource_group_name  = azurerm_resource_group.hub-net-rg.name
  address_prefixes     = [var.vnet-hub-azurefirewall-subnet]
}