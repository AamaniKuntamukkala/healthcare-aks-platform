variable "rg" {}
variable "location" {}
variable "tenant_id" {}
variable "aks_principal_id" {}
 
resource "azurerm_key_vault" "kv" {
  name                = "healthcare-kv-123"
  location            = var.location
  resource_group_name = var.rg
  tenant_id           = var.tenant_id
  sku_name            = "standard"
}
 
resource "azurerm_key_vault_secret" "db" {
  name         = "DB-PASSWORD"
  value        = "Secret123"
  key_vault_id = azurerm_key_vault.kv.id
}
 
resource "azurerm_key_vault_access_policy" "aks" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = var.tenant_id
  object_id    = var.aks_principal_id
  secret_permissions = ["Get", "List"]
}


