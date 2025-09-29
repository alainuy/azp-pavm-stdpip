# --- Virtual Machine ---

resource "azurerm_linux_virtual_machine" "pa_firewall" {
  name                = "vmseriesfw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_D3_v2" # Recommended VM size

  network_interface_ids = [
    azurerm_network_interface.mgmt_nic.id,
    azurerm_network_interface.untrust_nic.id,
    azurerm_network_interface.trust_nic.id,
  ]

  source_image_reference {
    publisher = "paloaltonetworks"
    offer     = "vmseries-flex"
    sku       = "byol"
    version   = "11.2.5"
  }

  plan {
    name      = "byol"
    product   = "vmseries-flex"
    publisher = "paloaltonetworks"
  }

  os_disk {
    name                 = "vmseriesfw-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 128
  }

  admin_username                  = "paadmin"
  disable_password_authentication = false
  admin_password                  = var.admin_password
}