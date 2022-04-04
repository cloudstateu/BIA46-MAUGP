resource "azurerm_virtual_network" "vnet-spoke-cni" {
  provider            = azurerm.dev
  name                = "vnet-spoke-cni"
  location            = azurerm_resource_group.spoke-net-rg.location
  resource_group_name = azurerm_resource_group.spoke-net-rg.name
  address_space       = [var.vnet-spoke-cni]
}

resource "azurerm_subnet" "subnet-frontend-cni" {
  provider             = azurerm.dev
  name                 = "subnet-frontend"
  resource_group_name  = azurerm_resource_group.spoke-net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-spoke-cni.name
  address_prefixes     = [cidrsubnet(var.vnet-spoke-cni, 2, 0)]

  lifecycle {
    ignore_changes = [
      enforce_private_link_endpoint_network_policies
    ]
  }
}

resource "azurerm_subnet" "subnet-backend-cni" {
  provider             = azurerm.dev
  name                 = "subnet-backend"
  resource_group_name  = azurerm_resource_group.spoke-net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-spoke-cni.name
  address_prefixes     = [cidrsubnet(var.vnet-spoke-cni, 2, 1)]

  lifecycle {
    ignore_changes = [
      enforce_private_link_endpoint_network_policies
    ]
  }
}

resource "azurerm_subnet" "subnet-data-cni" {
  provider             = azurerm.dev
  name                 = "subnet-data"
  resource_group_name  = azurerm_resource_group.spoke-net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-spoke-cni.name
  address_prefixes     = [cidrsubnet(var.vnet-spoke-cni, 2, 2)]

  lifecycle {
    ignore_changes = [
      enforce_private_link_endpoint_network_policies
    ]
  }
}

resource "azurerm_subnet" "subnet-dedicated-cni" {
  provider             = azurerm.dev
  name                 = "subnet-dedicated"
  resource_group_name  = azurerm_resource_group.spoke-net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-spoke-cni.name
  address_prefixes     = [cidrsubnet(var.vnet-spoke-cni, 2, 3)]

  lifecycle {
    ignore_changes = [
      enforce_private_link_endpoint_network_policies
    ]
  }
}

resource "azurerm_virtual_network_dns_servers" "cni" {
  provider           = azurerm.dev
  virtual_network_id = azurerm_virtual_network.vnet-spoke-cni.id
  dns_servers        = [azurerm_firewall.fw01.ip_configuration[0].private_ip_address]
}

resource "azurerm_subnet_route_table_association" "subnet-backend-cni" {
  provider       = azurerm.dev
  subnet_id      = azurerm_subnet.subnet-backend-cni.id
  route_table_id = azurerm_route_table.default-fw.id
}

resource "azurerm_subnet_network_security_group_association" "subnet-frontend-nsg-association-cni" {
  provider                  = azurerm.dev
  subnet_id                 = azurerm_subnet.subnet-frontend-cni.id
  network_security_group_id = azurerm_network_security_group.NSG-FRONTEND.id
}


resource "azurerm_subnet_network_security_group_association" "subnet-backend-nsg-association-cni" {
  provider                  = azurerm.dev
  subnet_id                 = azurerm_subnet.subnet-backend-cni.id
  network_security_group_id = azurerm_network_security_group.NSG-BACKEND.id

}

resource "azurerm_subnet_network_security_group_association" "subnet-data-nsg-association-cni" {
  provider                  = azurerm.dev
  subnet_id                 = azurerm_subnet.subnet-data-cni.id
  network_security_group_id = azurerm_network_security_group.NSG-DATA.id
}

resource "azurerm_subnet_network_security_group_association" "subnet-dedicated-nsg-association-cni" {
  provider                  = azurerm.dev
  subnet_id                 = azurerm_subnet.subnet-dedicated-cni.id
  network_security_group_id = azurerm_network_security_group.NSG-DEDICATED.id
}