resource "azurerm_resource_group" "hub-net-rg" {
  provider = azurerm.dev
  name     = "hub-net-rg"
  location = var.location
}

resource "azurerm_resource_group" "spoke-net-rg" {
  provider = azurerm.dev
  name     = "spoke-net-rg"
  location = var.location
}

resource "azurerm_resource_group" "dev-dns-rg" {
  provider = azurerm.dev
  name     = "dev-dns-rg"
  location = var.location
}

resource "azurerm_resource_group" "aks-kubenet-rg" {
  provider = azurerm.dev
  name     = "aks-kubenet-rg"
  location = var.location
}

resource "azurerm_resource_group" "aks-cni-rg" {
  provider = azurerm.dev
  name     = "aks-cni-rg"
  location = var.location
}