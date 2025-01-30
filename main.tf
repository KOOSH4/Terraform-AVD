terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0"
    }
  }

  # Update this block with the location of your terraform state file
  backend "azurerm" {
    resource_group_name  = "rg-AVD-int-dewc-1"
    storage_account_name = "stavdtfdewc1"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}

  use_oidc = true
}
# This resource block defines an Azure Resource Group named "rg-AVD-int-dewc-1".
# The location of the resource group is specified by the variable "var.location".
# Tags are added to the resource group for identification, including the location "germanywestcentral" and the owner "Olad, Koosha".
resource "azurerm_resource_group" "rg-avd" {
  name     = "rg-AVD-int-dewc-1"
  location = var.location
  tags = {
    Location = "germanywestcentral"
    Owner    = "Olad, Koosha"
  }
}