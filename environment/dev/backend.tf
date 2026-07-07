terraform {
  backend "azurerm" {
    resource_group_name  = "rg-demo-dev"
    storage_account_name = "sa0pdevenv"
    container_name       = "dev-state-container"
    key                  = "dev.tfstate"
  }
}