resource "azurerm_resource_group" "rg-tf-state" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = var.storage_account_name
  location                 = azurerm_resource_group.rg-tf-state.location
  resource_group_name      = azurerm_resource_group.rg-tf-state.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storagecontainer" {
  name                  = var.storage_account_container_name
  storage_account_id    = azurerm_storage_account.storageaccount.id
  container_access_type = "private"
}