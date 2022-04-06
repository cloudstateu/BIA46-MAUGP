data "azurerm_policy_definition" "azpoldef-AKS-default-ns-deny" {
  provider              = azurerm.dev
  display_name          = "Kubernetes clusters should not use the default namespace"
  management_group_name = data.azurerm_management_group.root_management_group.name
}

data "azurerm_policy_definition" "azpoldef-AKS-priviliged-containers-deny" {
  provider              = azurerm.dev
  display_name          = "Kubernetes cluster should not allow privileged containers"
  management_group_name = data.azurerm_management_group.root_management_group.name
}

data "azurerm_policy_definition" "azpoldef-AKS-liveness-readiness-configured" {
  provider              = azurerm.dev
  display_name          = "Ensure cluster containers have readiness or liveness probes configured"
  management_group_name = data.azurerm_management_group.root_management_group.name
}

data "azurerm_policy_definition" "azpoldef-AKS-specific-labels" {
  provider              = azurerm.dev
  display_name          = "Kubernetes cluster pods should use specified labels"
  management_group_name = data.azurerm_management_group.root_management_group.name
}

data "azurerm_policy_definition" "azpoldef-AKS-privileged-escalation-deny" {
  provider              = azurerm.dev
  display_name          = "Kubernetes clusters should not allow container privilege escalation"
  management_group_name = data.azurerm_management_group.root_management_group.name
}

data "azurerm_policy_definition" "azpoldef-AKS-cpu-memory-limit" {
  provider              = azurerm.dev
  display_name          = "Kubernetes cluster containers CPU and memory resource limits should not exceed the specified limits"
  management_group_name = data.azurerm_management_group.root_management_group.name
}