variable "rg" {}
variable "location" {}
 
resource "azurerm_virtual_network" "vnet" {
  name                = "healthcare-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rg
}
 
resource "azurerm_subnet" "aks" {
  name                 = "aks-subnet"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
 
output "subnet_id" {
  value = azurerm_subnet.aks.id
}
