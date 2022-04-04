resource "azurerm_resource_policy_assignment" "azpol-AKS-specific-label" {
  provider             = azurerm.dev
  name                 = "azpol-AKS-specific-label"
  resource_id          = data.azurerm_kubernetes_cluster.public-aks-cni.id
  policy_definition_id = data.azurerm_policy_definition.azpoldef-AKS-specific-labels.id

  parameters = <<PARAMETERS
    {
        "labelsList": {
          "value": ["env"]
        },
        "effect": {
          "value": "Deny"
        },
        "excludedNamespaces": {
          "value": ["kube-system", "gatekeeper-system", "azure-arc", "dev"]
        }
    }
    PARAMETERS
}

resource "azurerm_resource_policy_assignment" "azpol-AKS-liveness-readiness-configured" {
  provider             = azurerm.dev
  name                 = "azpol-AKS-liveness-readiness-configured"
  resource_id          = data.azurerm_kubernetes_cluster.public-aks-cni.id
  policy_definition_id = data.azurerm_policy_definition.azpoldef-AKS-liveness-readiness-configured.id

  parameters = <<PARAMETERS
    {
        "effect": {
          "value": "Deny"
        },
        "requiredProbes": {
          "value": ["readinessProbe", "livenessProbe"]
        },
        "excludedNamespaces": {
          "value": ["kube-system", "gatekeeper-system", "azure-arc", "dev"]
        }
    }
    PARAMETERS
}

resource "azurerm_resource_policy_assignment" "azpol-AKS-cpu-memory-limit" {
  provider             = azurerm.dev
  name                 = "azpol-AKS-cpu-memory-limit"
  resource_id          = data.azurerm_kubernetes_cluster.public-aks-cni.id
  policy_definition_id = data.azurerm_policy_definition.azpoldef-AKS-cpu-memory-limit.id

  parameters = <<PARAMETERS
    {
        "effect": {
          "value": "Deny"
        },
        "memoryLimit": {
          "value": "200Mi"
        },
        "cpuLimit": {
          "value": "100m"
        },
        "excludedNamespaces": {
          "value": ["kube-system", "gatekeeper-system", "azure-arc", "dev"]
        }
    }
    PARAMETERS
}