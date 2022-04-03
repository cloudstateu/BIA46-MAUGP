terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = "> 1.0.9"
}

provider "azurerm" {
  alias           = "dev"
  subscription_id = ""
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}