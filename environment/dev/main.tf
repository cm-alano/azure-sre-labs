resource "azurerm_resource_group" "rgdev" {
  name = var.resource_group_name
  location = var.location
  tags = var.resource_group_tags
}