provider "azurerm" {
  features {}
  subscription_id = "73325b5f-dd1c-46f6-89ad-748adf69b5b9"
}
 
data "azurerm_client_config" "current" {}
 
resource "azurerm_resource_group" "rg" {
  name     = "healthcare-rg"
  location = "eastus"
}
 
module "network" {
  source   = "./modules/network"
  rg       = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}

resource "random_id" "suffix" {
  byte_length = 3
}
 
module "acr" {
  source   = "./modules/acr"
  rg       = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  acr_name = "hcacr${random_id.suffix.hex}"
}

module "aks" {
  source    = "./modules/aks"
  rg        = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
  subnet_id = module.network.subnet_id
  acr_id    = module.acr.acr_id
}
 
# module "keyvault" {
#   source            = "./modules/keyvault"
#   rg                = azurerm_resource_group.rg.name
#   location          = azurerm_resource_group.rg.location
#   tenant_id         = data.azurerm_client_config.current.tenant_id
#   aks_principal_id  = module.aks.identity_principal_id
# }

