# --- Public IP Addresses ---

# Public IP for the management interface
resource "azurerm_public_ip" "mgmt_pip" {
  name                = "mgmt-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# First Public IP for the untrust interface
resource "azurerm_public_ip" "untrust_pip_1" {
  name                = "untrust-pip-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Second Public IP for the untrust interface
resource "azurerm_public_ip" "untrust_pip_2" {
  name                = "untrust-pip-2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# --- Network Interfaces ---

# Network Interface for management
resource "azurerm_network_interface" "mgmt_nic" {
  name                = "mgmt_nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "mgmt-ip-config"
    subnet_id                     = azurerm_subnet.mgmt_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mgmt_pip.id
  }
}

# Network Interface for untrust (public)
resource "azurerm_network_interface" "untrust_nic" {
  name                  = "untrust_nic"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  ip_forwarding_enabled = true


  ip_configuration {
    name                          = "untrust-ip-config-1"
    subnet_id                     = azurerm_subnet.untrust_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.untrust_pip_1.id
    primary                       = true
  }

  ip_configuration {
    name                          = "untrust-ip-config-2"
    subnet_id                     = azurerm_subnet.untrust_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.untrust_pip_2.id
  }
}

# Network Interface for trust (internal)
resource "azurerm_network_interface" "trust_nic" {
  name                  = "trust_nic"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  ip_forwarding_enabled = true

  ip_configuration {
    name                          = "trust-ip-config"
    subnet_id                     = azurerm_subnet.trust_subnet.id
    private_ip_address_allocation = "Dynamic"

  }
}