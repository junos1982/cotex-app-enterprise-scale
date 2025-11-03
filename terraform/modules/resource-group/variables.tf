variable "name" {
  description = "Name of the Azure resource group to create."
  type        = string
}

variable "location" {
  description = "Azure region where the resource group will be created."
  type        = string
}

variable "tags" {
  description = "Optional tags to associate with the resource group."
  type        = map(string)
  default     = {}
}
