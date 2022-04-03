resource "azurerm_log_analytics_workspace" "low-spoke" {
  provider            = azurerm.dev
  name                = "low-spoke"
  location            = azurerm_resource_group.spoke-net-rg.location
  resource_group_name = azurerm_resource_group.spoke-net-rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}