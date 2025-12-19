resource "azurerm_kubernetes_cluster" "aks" {
  name                = "healthcare-aks"
  location            = var.location
  resource_group_name = var.rg
  dns_prefix          = "healthcare"
 
  default_node_pool {
    name       = "system"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = var.subnet_id
  }
 
  identity {
    type = "SystemAssigned"
  }
}
Attach ACR:
resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}
