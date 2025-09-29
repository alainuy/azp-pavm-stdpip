# --- Variables ---
variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "HUB-VNET"
}

variable "location" {
  description = "The Azure region where resources will be deployed"
  default     = "southeastasia"
}

variable "vnet_name" {
  description = "The name of the virtual network"
  default     = "fwVNET"
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  default     = ["10.0.5.0/24"]
}

variable "mgmt_subnet_prefix" {
  description = "The address prefix for the management subnet"
  default     = "10.0.5.0/27"
}

variable "untrust_subnet_prefix" {
  description = "The address prefix for the untrust subnet"
  default     = "10.0.5.32/27"
}

variable "trust_subnet_prefix" {
  description = "The address prefix for the trust subnet"
  default     = "10.0.5.64/27"
}

variable "admin_password" {
  description = "The password for the admin user. This is not recommended for production."
  type        = string
  sensitive   = true # Marks the variable as sensitive to prevent it from being displayed in logs.
}

variable "subs_id" {
  description = "subscription id"
  type        = string
}