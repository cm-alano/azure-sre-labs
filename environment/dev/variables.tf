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
  type        = string
}

variable "storage_account_name" {
  description = "Name of Azure Storage Account"
  type        = string
}

variable "storage_allowed_ips" {
  description = "Public IPs allowed to access the storage account"
  type        = list(string)
  default     = []
}

variable "storage_account_container_name" {
  description = "Name of the storage container that will store the tfstate"
  type        = string
}

variable "network_interface_name" {
  description = "Name of the network interface for the virtual machine"
  type        = string
}

variable "virtual_machine_name" {
  description = "Name of the virtual machine name"
  type        = string
}

variable "admin_username" {
  description = "Username for logging in to the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "Password for logging in to the virtual machine"
  type        = string
}