variable "resource_name_prefix" {
  type        = string
  description = "The prefix to add to resource names"
  default     = "az104-mslearning-lab1"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resource should exist"
  default     = "UK South"
}

variable "dynamic_groups" {
  type = set(object({ 
    display_name = string, 
    membership_rule = string 
  }))
  description = "Azure AD Groups with Dynamic Membership"
  default = [ 
    {
      display_name = "IT Cloud Administrators",
      membership_rule = "user.jobTitle -eq \"Cloud Administrator\""
    },
    {
      display_name = "IT System Administrators",
      membership_rule = "user.jobTitle -eq \"System Administrator\""
    },
  ]
}

variable "assigned_groups" {
  type = list(string)
  description = "Azure AD Groups with Assigned Membership"
  default = [ "IT Lab Administrators" ]
}