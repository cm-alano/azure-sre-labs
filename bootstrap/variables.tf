variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  description = "Azure resource group"
  type        = string
}

variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
}

variable "storage_account_name" {
  description = "Azure Storage Account Name"
  type        = string
}

variable "storage_account_container_name" {
  description = "Azure Storage Account Container Name"
  type        = string
}

variable "tags" {
  description = "Tag for the Tfstate storage resource"
  type = map(string)
}