resource "azurerm_public_ip" "VM-WFE01-DEV-PIP" {
  provider                = azurerm.dev
  name                    = "VM-WFE01-DEV-PIP"
  location                = azurerm_resource_group.hub-net-rg.location
  resource_group_name     = azurerm_resource_group.hub-net-rg.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}

resource "azurerm_network_interface" "VM-WFE01-DEV-NIC" {
  provider            = azurerm.dev
  name                = "VM-WFE01-DEV-NIC"
  location            = azurerm_resource_group.hub-net-rg.location
  resource_group_name = azurerm_resource_group.hub-net-rg.name

  ip_configuration {
    name                          = "VM-WFE01-DEV-NIC-CONFIG"
    subnet_id                     = azurerm_subnet.vnet-hub-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.VM-WFE01-DEV-PIP.id
  }
}

resource "azurerm_linux_virtual_machine" "VM-WFE01-DEV" {
  provider            = azurerm.dev
  name                = "VM-WFE01-DEV"
  computer_name       = "VM-WFE01-DEV"
  location            = azurerm_resource_group.hub-net-rg.location
  resource_group_name = azurerm_resource_group.hub-net-rg.name
  size                = "Standard_DS1_v2"

  disable_password_authentication = false
  admin_username                  = var.default-admin-username
  admin_password                  = var.default-admin-pass

  network_interface_ids = [
    azurerm_network_interface.VM-WFE01-DEV-NIC.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    name                 = "VM-WFE01-DEV-OS"

  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}