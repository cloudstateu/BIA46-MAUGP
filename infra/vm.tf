resource "azurerm_public_ip" "vm-hub-pip" {
  provider                = azurerm.dev
  name                    = "vm-hub-pip"
  location                = azurerm_resource_group.hub-net-rg.location
  resource_group_name     = azurerm_resource_group.hub-net-rg.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}

resource "azurerm_network_interface" "vm-hub-nic" {
  provider            = azurerm.dev
  name                = "vm-hub-nic"
  location            = azurerm_resource_group.hub-net-rg.location
  resource_group_name = azurerm_resource_group.hub-net-rg.name

  ip_configuration {
    name                          = "vm-hub-nic-config"
    subnet_id                     = azurerm_subnet.vnet-hub-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm-hub-pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm-hub" {
  provider            = azurerm.dev
  name                = "vm-hub"
  computer_name       = "vm-hub"
  location            = azurerm_resource_group.hub-net-rg.location
  resource_group_name = azurerm_resource_group.hub-net-rg.name
  size                = "Standard_DS1_v2"

  disable_password_authentication = false
  admin_username                  = var.default-admin-username
  admin_password                  = var.default-admin-pass

  network_interface_ids = [
    azurerm_network_interface.vm-hub-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    name                 = "vm-hub-os"

  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}