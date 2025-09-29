# Create the Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create the Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# --- Subnets ---

# Create the Management Subnet
resource "azurerm_subnet" "mgmt_subnet" {
  name                 = "mgmt"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = [var.mgmt_subnet_prefix]
}

# Create the Untrust Subnet
resource "azurerm_subnet" "untrust_subnet" {
  name                 = "untrust"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = [var.untrust_subnet_prefix]
}

# Create the Trust Subnet
resource "azurerm_subnet" "trust_subnet" {
  name                 = "trust"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = [var.trust_subnet_prefix]
}