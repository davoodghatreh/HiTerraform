variable "resource_group_name" {
  description = "Name of the resource group container for all resources"
}

variable "resource_group_location" {
  description = "Azure region used for resource deployment"
}

variable "virtual_network_name"{}

variable "address_prefix"{}

variable "subnet_name"{}

variable "subnet_prefix"{}

variable "as_name"{}

variable "net_interface_name1"{}
variable "net_interface_name2"{}

variable "private_ip_range_name"{}

variable "vmname1"{}

variable "vm1size"{}

variable "vmname2"{}

variable "vm2size"{}

variable "admin_username" {
  description = "User name for the Virtual Machine"
}

variable "admin_password" {
  description = "Password for the Virtual Machine."
}

variable "os_publisher"{}
    
variable "os_offer"{}
    
variable "os_sku"{}
    
variable "os_version"{}

variable "nsg_name"{}