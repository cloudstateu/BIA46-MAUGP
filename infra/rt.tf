resource "azurerm_route_table" "default-fw" {
  provider            = azurerm.dev
  name                = "default-fw"
  resource_group_name = azurerm_resource_group.spoke-net-rg.name
  location            = azurerm_resource_group.spoke-net-rg.location
}

resource "azurerm_route" "to-fw" {
  provider               = azurerm.dev
  name                   = "to-fw"
  route_table_name       = azurerm_route_table.default-fw.name
  resource_group_name    = azurerm_resource_group.spoke-net-rg.name
  address_prefix         = "0.0.0.0/0"
  next_hop_in_ip_address = azurerm_firewall.fw01.ip_configuration[0].private_ip_address
  next_hop_type          = "VirtualAppliance"
}