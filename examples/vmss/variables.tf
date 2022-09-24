///scale set
variable "scale_set_name" {
  type = string
  default = "vmss-tf"
}

//nsg
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

//image
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

//disk
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

// script
variable "iis_script_filename" {
  type = string
  default = "install_iis.ps1"
}