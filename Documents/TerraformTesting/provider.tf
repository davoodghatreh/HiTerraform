# Microsoft Azure Resource Manager Provider

#
# Uncomment this provider block if you have set the following environment variables: 
# ARM_SUBSCRIPTION_ID, ARM_CLIENT_ID, ARM_CLIENT_SECRET and ARM_TENANT_ID
#
provider "azurerm" {
      version = "=2.5.0"
  features {}
}

#
# Uncomment this provider block if you are using variables (NOT environment variables)
# to provide the azurerm provider requirements.
#
#provider "azurerm" {
#  subscription_id = "$"
#   client_id       = "$"
#   client_secret   = "$"
#  tenant_id       = "$"
#}