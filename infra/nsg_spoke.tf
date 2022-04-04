resource "azurerm_network_security_group" "NSG-FRONTEND" {
  provider            = azurerm.dev
  name                = "NSG-SUBNET-FRONTEND"
  location            = azurerm_resource_group.spoke-net-rg.location
  resource_group_name = azurerm_resource_group.spoke-net-rg.name


  # security_rule {
  #   name                       = "AllowAll_Inbound"
  #   priority                   = 4095
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "*"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }

  # security_rule {
  #   name                       = "AllowAll_Outbound"
  #   priority                   = 4095
  #   direction                  = "Outbound"
  #   access                     = "Allow"
  #   protocol                   = "*"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
}

resource "azurerm_network_security_group" "NSG-BACKEND" {
  provider            = azurerm.dev
  name                = "NSG-SUBNET-BACKEND"
  location            = azurerm_resource_group.spoke-net-rg.location
  resource_group_name = azurerm_resource_group.spoke-net-rg.name


  # security_rule {
  #   name                       = "AllowAll_Inbound"
  #   priority                   = 4095
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "*"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }

  # security_rule {
  #   name                       = "AllowAll_Outbound"
  #   priority                   = 4095
  #   direction                  = "Outbound"
  #   access                     = "Allow"
  #   protocol                   = "*"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
}

resource "azurerm_network_security_group" "NSG-DATA" {
  provider            = azurerm.dev
  name                = "NSG-SUBNET-DATA"
  location            = azurerm_resource_group.spoke-net-rg.location
  resource_group_name = azurerm_resource_group.spoke-net-rg.name


  # security_rule {
  #   name                       = "AllowAll_Inbound"
  #   priority                   = 4095
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "*"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }

  # security_rule {
  #   name                       = "AllowAll_Outbound"
  #   priority                   = 4095
  #   direction                  = "Outbound"
  #   access                     = "Allow"
  #   protocol                   = "*"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
}

resource "azurerm_network_security_group" "NSG-DEDICATED" {
  provider            = azurerm.dev
  name                = "NSG-SUBNET-DEDICATED"
  location            = azurerm_resource_group.spoke-net-rg.location
  resource_group_name = azurerm_resource_group.spoke-net-rg.name


  # security_rule {
  #   name                       = "AllowAll_Inbound"
  #   priority                   = 4095
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "*"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }

  # security_rule {
  #   name                       = "AllowAll_Outbound"
  #   priority                   = 4095
  #   direction                  = "Outbound"
  #   access                     = "Allow"
  #   protocol                   = "*"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
}