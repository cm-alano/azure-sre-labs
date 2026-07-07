resource "azurerm_resource_group" "rgdev" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.resource_group_tags
}

resource "azurerm_network_security_group" "nsgdev" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.rgdev.location
  resource_group_name = azurerm_resource_group.rgdev.name
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rgdev.name
  address_prefixes     = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.vnetdev.name

  service_endpoints = [
    "Microsoft.Storage"
  ]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.rgdev.name
  address_prefixes     = ["10.0.2.0/24"]
  virtual_network_name = azurerm_virtual_network.vnetdev.name

  service_endpoints = [
    "Microsoft.Storage"
  ]
}

resource "azurerm_virtual_network" "vnetdev" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rgdev.location
  resource_group_name = azurerm_resource_group.rgdev.name

  address_space = ["10.0.0.0/16"]
  dns_servers   = ["10.0.0.4", "10.0.0.5"]

  tags = var.resource_group_tags
}

resource "azurerm_storage_account" "sadev" {
  name                = var.storage_account_name
  location            = azurerm_resource_group.rgdev.location
  resource_group_name = azurerm_resource_group.rgdev.name

  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.resource_group_tags

  network_rules {
    default_action = "Deny"
    ip_rules       = var.storage_allowed_ips
    virtual_network_subnet_ids = [
      azurerm_subnet.subnet1.id,
      azurerm_subnet.subnet2.id
    ]
  }
}

resource "azurerm_storage_container" "sadevcontainer" {
  name                  = var.storage_account_container_name
  storage_account_id    = azurerm_storage_account.sadev.id
  container_access_type = "private"
}