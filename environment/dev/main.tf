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

resource "azurerm_virtual_network" "vnetdev" {
  name = var.vnet_name
  location = azurerm_resource_group.rgdev.location
  resource_group_name = azurerm_resource_group.rgdev.name

  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
    security_group   = azurerm_network_security_group.nsgdev.id
  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
    security_group   = azurerm_network_security_group.nsgdev.id
  }

  tags = {
    environment = "dev"
  }
}