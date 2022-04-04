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

resource "azurerm_virtual_network_dns_servers" "hub" {
  provider           = azurerm.dev
  virtual_network_id = azurerm_virtual_network.vnet-hub.id
  dns_servers        = [azurerm_firewall.fw01.ip_configuration[0].private_ip_address]
}