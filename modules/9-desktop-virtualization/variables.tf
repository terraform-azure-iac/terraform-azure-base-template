variable "environment" {
  type        = string
  default     = ""
}

variable "resource_group_name" {
  type        = string
  default     = "desktop-virtualization"
}

variable "location" {
  type        = string
  default     = "northeurope"
}

variable "name_prefix" {
  type        = string
  default     = "desktop-virt"
}


##########################
#     Virtual Machine    #
##########################

variable "vm_count" {
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "Size of the machine to deploy"
  default     = "Standard_B2s"
}

variable "local_admin_username" {
  description = "local admin username for VMs"
  type        = string
  default     = "superduperadmin"
}

##################################
#     Active Directory Domain    #
##################################


variable "domain_name" {
  description = "The name of the Active Directory domain"     
  type        = string
  default     = ""
}

variable "active_directory_admin" {
  description = "The name of the Active Directory domain admin user"     
  type        = string
  default     = ""
}

variable "active_directory_admin_password" {
  description = "The name of the Active Directory domain admin user"     
  type        = string
  default     = ""
}