variable "resource_group_name" {
  type = string
  description = "The Resource Group name"
}

variable "location" {
  type = string
  description = "The location"
}

variable "vm_name" {
  type = string
  description = "The VM Name"
}

variable "vm_size" {
  type = string
  description = "The VM size"
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
  default = "Standard_LRS"
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
  default     = "_%@"
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

variable "network_interface_id" {
  type = string
  description = "The Networ Interface Id"
}