
resource "azurerm_resource_group" "resource_group1" {
  name                = var.resource_group_name
  location            = var.resource_group_location
}

resource "azurerm_virtual_network" "virtual_network1" {
  name                = var.virtual_network_name
  address_space       = [var.address_prefix]
  location            = azurerm_resource_group.resource_group1.location
  resource_group_name = azurerm_resource_group.resource_group1.name
}

resource "azurerm_subnet" "subnet1" {
  name                = var.subnet_name
  resource_group_name = azurerm_virtual_network.virtual_network1.resource_group_name
  virtual_network_name= azurerm_virtual_network.virtual_network1.name
  address_prefix      = var.subnet_prefix
}

resource "azurerm_availability_set" "availability_set1" {
  name                = var.as_name
  location            = azurerm_resource_group.resource_group1.location
  resource_group_name = azurerm_resource_group.resource_group1.name
}

resource "azurerm_network_interface" "interface1" {
  name                = var.net_interface_name1
  location            = azurerm_virtual_network.virtual_network1.location
  resource_group_name = azurerm_virtual_network.virtual_network1.resource_group_name

  ip_configuration {
    name              = var.private_ip_range_name
    subnet_id         = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface" "interface2" {
  name                = var.net_interface_name2
  location            = azurerm_virtual_network.virtual_network1.location
  resource_group_name = azurerm_virtual_network.virtual_network1.resource_group_name

  ip_configuration {
    name              = var.private_ip_range_name
    subnet_id         = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm1" {
  name                = var.vmname1
  resource_group_name = azurerm_network_interface.interface1.resource_group_name
  location            = azurerm_network_interface.interface1.location
  size                = var.vm1size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  availability_set_id = azurerm_availability_set.availability_set1.id
  network_interface_ids = [
    azurerm_network_interface.interface1.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }
}

resource "azurerm_windows_virtual_machine" "vm2" {
  name                = var.vmname2
  resource_group_name = azurerm_network_interface.interface2.resource_group_name
  location            = azurerm_network_interface.interface2.location
  size                = var.vm2size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  availability_set_id = azurerm_availability_set.availability_set1.id
  network_interface_ids = [
    azurerm_network_interface.interface2.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }
}


resource "azurerm_network_security_group" "nsg1" {
  name                = var.nsg_name
  resource_group_name = azurerm_windows_virtual_machine.vm1.resource_group_name
  location            = azurerm_windows_virtual_machine.vm1.location
}

# NOTE: this allows HTTP from any network
resource "azurerm_network_security_rule" "http" {
  name                        = "http"
  resource_group_name         = azurerm_windows_virtual_machine.vm1.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg1.name
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

# NOTE: this allows HTTPS from any network
resource "azurerm_network_security_rule" "https" {
  name                        = "https"
  resource_group_name         = azurerm_windows_virtual_machine.vm1.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg1.name
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

resource "azurerm_subnet_network_security_group_association" "nsg-associate1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}
