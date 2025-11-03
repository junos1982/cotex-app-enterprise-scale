variable "resource_group_name" {
  description = "Name of the Azure resource group to create."
  type        = string
}

variable "location" {
  description = "Azure region where the resource group and resources will be created."
  type        = string
  default     = "koreacentral"
}

variable "tags" {
  description = "Optional tags to associate with all resources."
  type        = map(string)
  default = {
    "생성자" = "이동준"
  }
}

variable "virtual_network_name" {
  description = "Name of the virtual network for the VM."
  type        = string
  default     = "cotex-basic-vnet"
}

variable "virtual_network_address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the subnet for the VM."
  type        = string
  default     = "cotex-basic-subnet"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet."
  type        = list(string)
  default     = ["10.10.1.0/24"]
}

variable "public_ip_name" {
  description = "Name of the public IP resource."
  type        = string
  default     = "cotex-basic-ip"
}

variable "network_security_group_name" {
  description = "Name of the network security group."
  type        = string
  default     = "cotex-basic-nsg"
}

variable "network_interface_name" {
  description = "Name of the network interface."
  type        = string
  default     = "cotex-basic-nic"
}

variable "network_interface_configuration_name" {
  description = "Name of the network interface IP configuration."
  type        = string
  default     = "primary"
}

variable "vm_name" {
  description = "Name of the Linux virtual machine."
  type        = string
  default     = "cotex-basic-vm"
}

variable "vm_size" {
  description = "Size of the Linux virtual machine."
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the Linux virtual machine."
  type        = string
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  description = "SSH public key for the admin user."
  type        = string
}
