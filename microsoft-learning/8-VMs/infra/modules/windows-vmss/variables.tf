variable "resource_group_name" {
  type = string
  description = "The Resource Group name"
}

variable "location" {
  type = string
  description = "The location"
}

variable "scale_set_name" {
  type = string
  description = "The scale set name"
}

variable "vm_sku" {
  type = string
  description = "The VM SKU for the Scale Set"
  default = "Standard_D2s_v3"
}

variable "admin_username" {
  type = string
  description = "Name to use for Admin User"
  default = "adminuser"
}

variable "os_disk_caching" {
  type = string
  description = "OS Disk Caching type"
  default = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  type = string
  description = "OS Disk Storage Account type"
  default = "Premium_LRS"
}

variable "source_image_publisher" {
  type = string
  description = "The Publisher of the VM image"
  default = "MicrosoftWindowsServer"
}

variable "source_image_offer" {
  type = string
  description = "The Offer of the VM image"
  default = "WindowsServer"
}

variable "source_image_sku" {
  type = string
  description = "The SKU of the VM image"
  default = "2019-Datacenter" 
}

variable "source_image_version" {
  type = string
  description = "The Version of the VM image (optional)"
  default = "latest"
}

variable "tags" {
  type = map(string)
  description = "The tags to be applied to the resource"
  default = {}
}

variable "instances" {
    type = string
    description = "The number of instances"
    default = 1
}

variable "zones" {
  type = list(number)
  description = "The Availability Zone(s) in which the VM should be created"
  default = [ 1 ]
}

variable "upgrade_mode" {
  type = string
  description = "Specifies how Upgrades (e.g. changing the Image/SKU) should be performed to Virtual Machine Instances. Possible values are Automatic, Manual and Rolling"
  default = "Automatic"
}

variable "boot_diagnostics_storage_account_uri" {
    type = string
    description = "The endpoint of the Storage Account used for boot diagnostics"
}

//password
variable "secret_length" {
  type        = number
  description = "Length of the secret"
  default     = 20
}

variable "special" {
  type        = bool
  description = "Special characters in secret"
  default     = true
}

variable "override_special" {
  type        = string
  description = "Special override characters"
  default     = "!@#$%&*"
}

// NIC
variable "subnet_id" { 
  type = string
  description = "Subnet Id"
}

variable "ip_configuration_name" {
  type = string
  description = "IP Configuration"   
}

variable "private_ip_address_allocation" {
  type = string
  description = "Private IP Address Allocation"
  default = "Dynamic"
}

variable "private_ip_address" {
  type = string
  description = "The Statically defined IP address"
  default = ""
}

variable "enable_ip_forwarding" {
  type = bool
  description = "Enable IP Forwarding"
  default = false
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
      name                       = "rdp"
      priority                   = 1000
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "http"
      priority                   = 1010
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

//Load Balancer
variable "lb_frontend_ip_config_name" {
  type = string
  default = "lb-frontend"
}

//VMSS Extension
variable "vmss_extension_file_uri" {
  type = string
}

variable "vmss_extension_file_name" {
  type = string
}