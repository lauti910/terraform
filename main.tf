# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  backend "azurerm" {    
    resource_group_name  = "SAESA"
    storage_account_name = "pruebasaesa"
    container_name       = "terra"
    key                  = "terra.terraform.tfstate"  
}
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

variable "resource_group_name" {
  type = string
  default = "SAESA"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "eastus2"
}

resource "azurerm_data_factory" "rg" {
  name                = "df-ergo-prod"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_data_factory" "dev" {
  name                = "df-ergo-dev-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_data_factory" "test" {
  name                = "df-ergo-dev-2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_storage_account" "rg" {
  name                     = "pruebasaesa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_databricks_workspace" "rg" {
  name                = "databricks-prod"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "standard"

  tags = {
    Environment = "Production"
  }
}

resource "azurerm_databricks_workspace" "dev" {
  name                = "databricks-dev"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "standard"

  tags = {
    Environment = "Development"
  }
}