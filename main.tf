terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.16.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "ap-rg"
    storage_account_name = "apstorage12345"
    container_name       = "calc2-container"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = "1b07d375-e28d-4dd8-9a73-6e18dd9f7b3c"
}

resource "azurerm_resource_group" "rg" {
  name     = "calc1-app-rg"
  location = "Canada Central"
}

resource "azurerm_service_plan" "asp" {
  name                = "calc1-app-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"

  sku_name = "B1" # Linux does not support F1 (Free Tier)
}

resource "azurerm_app_service" "app" {
  name                = "calc1-app-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_service_plan.asp.id

  site_config {
    # No need to define linux_fx_version directly
    # Terraform will automatically set the version based on the service plan
  }
}
