resource "azurerm_virtual_network" "vnet-spoke-kubenet" {
  provider            = azurerm.dev
  name                = "vnet-spoke-kubenet"
  location            = azurerm_resource_group.spoke-net-rg.location
  resource_group_name = azurerm_resource_group.spoke-net-rg.name
  address_space       = [var.vnet-spoke-kubenet]
}

resource "azurerm_subnet" "subnet-frontend-kubenet" {
  provider             = azurerm.dev
  name                 = "subnet-frontend"
  resource_group_name  = azurerm_resource_group.spoke-net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-spoke-kubenet.name
  address_prefixes     = [cidrsubnet(var.vnet-spoke-kubenet, 2, 0)]

  lifecycle {
    ignore_changes = [
      enforce_private_link_endpoint_network_policies
    ]
  }
}

resource "azurerm_subnet" "subnet-backend-kubenet" {
  provider             = azurerm.dev
  name                 = "subnet-backend"
  resource_group_name  = azurerm_resource_group.spoke-net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-spoke-kubenet.name
  address_prefixes     = [cidrsubnet(var.vnet-spoke-kubenet, 2, 1)]

  lifecycle {
    ignore_changes = [
      enforce_private_link_endpoint_network_policies
    ]
  }
}

resource "azurerm_subnet" "subnet-data-kubenet" {
  provider             = azurerm.dev
  name                 = "subnet-data"
  resource_group_name  = azurerm_resource_group.spoke-net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-spoke-kubenet.name
  address_prefixes     = [cidrsubnet(var.vnet-spoke-kubenet, 2, 2)]

  lifecycle {
    ignore_changes = [
      enforce_private_link_endpoint_network_policies
    ]
  }
}

resource "azurerm_subnet" "subnet-dedicated-kubenet" {
  provider             = azurerm.dev
  name                 = "subnet-dedicated"
  resource_group_name  = azurerm_resource_group.spoke-net-rg.name
  virtual_network_name = azurerm_virtual_network.vnet-spoke-kubenet.name
  address_prefixes     = [cidrsubnet(var.vnet-spoke-kubenet, 2, 3)]

  lifecycle {
    ignore_changes = [
      enforce_private_link_endpoint_network_policies
    ]
  }
}


resource "azurerm_subnet_network_security_group_association" "subnet-frontend-nsg-association-kubenet" {
  provider                  = azurerm.dev
  subnet_id                 = azurerm_subnet.subnet-frontend-kubenet.id
  network_security_group_id = azurerm_network_security_group.NSG-FRONTEND.id
}


resource "azurerm_subnet_network_security_group_association" "subnet-backend-nsg-association-kubenet" {
  provider                  = azurerm.dev
  subnet_id                 = azurerm_subnet.subnet-backend-kubenet.id
  network_security_group_id = azurerm_network_security_group.NSG-BACKEND.id

}

resource "azurerm_subnet_network_security_group_association" "subnet-data-nsg-association-kubenet" {
  provider                  = azurerm.dev
  subnet_id                 = azurerm_subnet.subnet-data-kubenet.id
  network_security_group_id = azurerm_network_security_group.NSG-DATA.id
}

resource "azurerm_subnet_network_security_group_association" "subnet-dedicated-nsg-association-kubenet" {
  provider                  = azurerm.dev
  subnet_id                 = azurerm_subnet.subnet-dedicated-kubenet.id
  network_security_group_id = azurerm_network_security_group.NSG-DEDICATED.id
}