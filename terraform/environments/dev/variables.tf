variable "environment" {
  description = "Name of the deployment environment (e.g., dev, test, prod)."
  type        = string
  default     = "dev"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group to create."
  type        = string
}

variable "location" {
  description = "Azure region where the resource group will be created."
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Optional additional tags to associate with the resource group."
  type        = map(string)
  default     = {}
}
