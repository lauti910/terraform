# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "SAESA"
  location = "eastus2"
}

resource "azurerm_data_factory" "rg" {
  name                = "df-ergo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_resource_group" "dev" {
  name     = "SAESA-Dev"
  location = "eastus2"
}
resource "azurerm_data_factory" "dev" {
  name                = "df-ergo-dev"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
}