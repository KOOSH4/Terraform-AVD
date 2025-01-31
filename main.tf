terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0"
    }
  }

# It specifies the resource group, storage account, container, and key for storing the Terraform state file.
# The use_oidc parameter is set to true to enable OpenID Connect (OIDC) authentication for secure access.
  backend "azurerm" {
    resource_group_name  = "rg-AVD-int-dewc-1"
    storage_account_name = "stavdtfdewc1"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}
# This block configures the Azure Resource Manager (azurerm) provider for Terraform.
# The 'features' block is required but can be left empty.
# The 'use_oidc' attribute is set to true to enable OpenID Connect (OIDC) authentication.

provider "azurerm" {
  features {}

  use_oidc = true
}
# This resource block defines an Azure Resource Group named "rg-AVD-int-dewc-1"
# in the location specified by the variable 'var.location'. The resource group
# is tagged with the location "germanywestcentral" and the owner "Olad, Koosha".
resource "azurerm_resource_group" "rg-aks" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    Location = "germanywestcentral"
    Owner    = "Olad, Koosha"
  }
}

# This block defines a resource for creating an Azure Virtual Desktop application group.
# The application group is named "avd-app-group" and is located in the same location as the specified resource group.
# It is associated with a host pool and can be of type "Desktop" or "RemoteApp".
resource "azurerm_virtual_desktop_application_group" "avd_app_group" {
  name                = "appGrp-AVD-dewc-1"
  location            = azurerm_resource_group.rg-avd.location
  resource_group_name = azurerm_resource_group.rg-avd.name
  type                = "Desktop"  # Options: "Desktop" or "RemoteApp"
  host_pool_id        = azurerm_virtual_desktop_host_pool.avd_host_pool.id
}

# This block defines a resource for associating an Azure Virtual Desktop application group with a workspace.
# The association links the specified application group to the specified workspace, enabling the applications in the group to be accessible through the workspace.
resource "azurerm_virtual_desktop_workspace_application_group_association" "avd_association" {
  workspace_id         = azurerm_virtual_desktop_workspace.avd_workspace.id
  application_group_id = azurerm_virtual_desktop_application_group.avd_app_group.id  # Link to App Group
}