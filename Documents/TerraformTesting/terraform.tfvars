resource_group_location = "centralus"

resource_group_name = "rg-centralus-prod-davood"

virtual_network_name = "davood-net"

address_prefix = "10.0.0.0/16"

subnet_name = "davoodSubnet"

subnet_prefix          = "10.0.0.0/24"

as_name = "davood-availabilitySet"

net_interface_name1 = "davood-nif1"
net_interface_name2 = "davood-nif2"

private_ip_range_name = "davood-ip-name"

vmname1 = "App1"

vm1size ="Standard_F2"

vmname2 = "App2"

vm2size ="Standard_F2"

admin_username = "davood"

admin_password = "mdef@tpY"

os_publisher = "MicrosoftWindowsServer"
    
os_offer     = "WindowsServer"
    
os_sku       = "2019-Datacenter"
    
os_version   = "latest"

nsg_name = "davood-nsg"