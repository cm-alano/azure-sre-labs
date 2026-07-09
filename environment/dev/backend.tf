terraform {
  backend "azurerm" {
    resource_group_name  = "rg-demo-tf-state"
    storage_account_name = "saallenvtfstate"
    container_name       = "sacontainertfstate"
    key                  = "dev.tfstate"
  }
}