variable "environment" {
  type        = string
  default     = ""
}

variable "resource_group_name" {
  type        = string
  default     = "keyvault"
}

variable "location" {
  type        = string
  default     = "norwayeast"
}

variable "keyvault_name" {
  type        = string
  default     = "bachelor-keyvault"
}
