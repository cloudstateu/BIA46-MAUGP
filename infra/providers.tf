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
  subscription_id = "5b1dcd77-9361-42f2-8274-db430a1dd52e"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}