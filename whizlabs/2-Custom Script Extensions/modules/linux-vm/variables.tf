variable "resource_group_name" {
  type = string
  description = "The Resource Group in which the resource should be created"
}

variable "location" {
  type = string
  description = "The Azure Region where the Resource Group should exist"
}

variable "vm_name" {
  type = string
  description = "The name of the Virtual Machine"
}

variable "vm_size" {
  type = string
  description = "The SKU which should be used for the Virtual Machine"
  default = "Standard_B1s"
}

variable "admin_username" {
  type = string
  description = "The username of the local administrator used for the Virtual Machine"
  default = "admin_user"
}

variable "os_disk_caching" {
  type = string
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite"
  default = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  type = string
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS"
  default = "Standard_LRS"
}

variable "source_image_id" {
  type = string
  description = "The ID of the Image which this Virtual Machine should be created from"
  default = ""
}

variable "ssh_username" {
  type = string
  description = "The username for which this Public SSH Key should be configured"
  default = "admin_user"
}

variable "source_image_publisher" {
  type = string
  description = "The publisher of the image used to create the virtual machine"
  default = "Canonical"
}

variable "source_image_offer" {
  type = string
  description = " The offer of the image used to create the virtual machine"
  default = "0001-com-ubuntu-server-focal"
}

variable "source_image_sku" {
  type = string
  description = "The SKU of the image used to create the virtual machine"
  default = "20_04-lts-gen2"
}

variable "source_image_version" {
  type = string
  description = "The version of the image used to create the virtual machine"
  default = "latest"
}

variable "tags" {
  type = map(string)
  description = "A mapping of tags which should be assigned to this Virtual Machine"
  default = {}
}

// NIC
variable "subnet_id" { 
  type = string
  description = "The ID of the Subnet in which this Network Interface should be located"
}

variable "ip_configuration_name" {
    type        = string
    description = "The name used for the IP Configuration"   
}

variable "private_ip_address_allocation" {
    type = string
    description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static"
    default = "Dynamic"
}

//NSG
variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "The Security Rules to add to the NSG"
  default = [
    {
      name                       = "ssh"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "web"
      priority                   = 1002
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}