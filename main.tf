provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-AVD-int-dewc-1"
  location = "westeurope"
  
  tags = {
    Location = "germanywestcentral"
    Owner    = "Olad, Koosha"
  }
}