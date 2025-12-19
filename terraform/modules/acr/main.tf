variable "rg" {}
variable "location" {}
variable "acr_name" {}
 
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.rg
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}
 
output "acr_id" {
  value = azurerm_container_registry.acr.id
}
 
output "acr_login" {
  value = azurerm_container_registry.acr.login_server
}

