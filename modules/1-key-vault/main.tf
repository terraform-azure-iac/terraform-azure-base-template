resource "azurerm_resource_group" "keyvault" {
    name        = "${var.resource_group_name}-${var.environment}"
    location    = var.location
}

# Get tenant and object id
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                       = var.keyvault_name
  location                   = azurerm_resource_group.keyvault.location
  resource_group_name        = azurerm_resource_group.keyvault.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "create",
      "get",
    ]

    secret_permissions = [
      "set",
      "list",
      "get",
      "delete",
      "purge",
      "recover"
    ]
  }
}
