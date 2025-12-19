variable "rg" {}
variable "location" {}
variable "subnet_id" {}
variable "acr_id" {}
 
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "healthcare-aks"
  location            = var.location
  resource_group_name = var.rg
  dns_prefix          = "healthcare"
 
  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_B2ms"
    vnet_subnet_id = var.subnet_id
  }
 
  identity {
    type = "SystemAssigned"
  }
  network_profile {
  network_plugin = "azure"
 
  service_cidr   = "10.2.0.0/16"
  dns_service_ip = "10.2.0.10"
 
  }
}
 
resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}
 
output "kubeconfig" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
output "identity_principal_id" {
  value = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}






