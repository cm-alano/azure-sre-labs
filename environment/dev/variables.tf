variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "Azure Resource Group Location"
  type        = string
}

variable "resource_group_tags" {
  description = "List of tags to assign to resource group"
  type        = map(string)
}

variable "network_security_group_name" {
  description = "Name of Azure NSG"
  type        = string
}

variable "vnet_name" {
  description = "Name of Vnet"
  type = string
}