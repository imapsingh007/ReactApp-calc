terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.16.0"
    }
  

   }

  backend "azurerm" {
    resource_group_name  = "ap-rg"
    storage_account_name = "apstorage12345"
    container_name       = "calc-container"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = "1b07d375-e28d-4dd8-9a73-6e18dd9f7b3c"
}

resource "azurerm_resource_group" "rg" {
  name     = "calc-app-rg"
  location = "Canada Central"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "calc-app-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "calc-app-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
}
