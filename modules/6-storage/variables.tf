##Variables that needs to be changed
variable "email" {
  type = list
  default = [
    "user1@test.no",
    "user2@test.no"
  ]
    
}

variable "adminstrator_login" {
  type     = string 
  default  = "test"
}

##Variables with names that should be changed

variable "resource_group_name" {
  type      = string
  default   = "sql-database"
}

variable "mssql_server_name" {
  type      = string
  default   = "navn-mssql-server"
}

variable "mssql_databse_name" {
  type      = string 
  default   = "mssql-databse"
}

variable "storage_account_sql_name" {
  type      = string
  default   = "navn-storage" 
}

variable "storage_container_name" {
  type      = string
  default   = "storage-container-sql"
}

variable "storage_blob_name" {
  type      = string
  default   = "storage-blob-sql"
}

variable "data_protection_backup_vault_name" {
  type      = string
  default   = "data-protection-backup-vault"
}

variable "data_protection_backup_policy_blob_storage_name" {
  type      = string
  default   = "backup-policy-blob-storage"
}



variable "policy_definition_name" {
  type      = string
  default   = "Restrict access to location"
}

variable "resource_group_policy_assignment_name" {
  type      = string
  default   = "SQL policy"
}

variable "data_share_account_name" {
  type      = string
  default   = "navn-data-share-account"
}


variable "data_share_name" {
  type = string
  default = "navn_data_share"
}

variable "data_share_dataset_blob_storage_name" {
  type      = string
  default   = "navn-dataset-blob-storage"
}



##Variables that can be changed, depending on needs

variable "account_tier" {
  type      = string
  default   = "Standard"   

}

variable "account_replication_type" {
  type     = string
  default  = "LRS"
}

variable "container_access_type" {
  type     = string 
  default  = "private"
}

variable "type_blob" {
  type     = string 
  default  = "Block"
}

variable "datastore_type" {
  type     = string 
  default  = "VaultStore"
}

variable "redundancy" {
  type     = string 
  default  = "LocallyRedundant"
}

variable "retention_duration" {
  type     = string 
  default  = "P30D"
}

variable "version_mssql" {
  type     = string 
  default  = "12.0"
}



variable "enabled" {
  type     = string 
  default  = "Enabled"
}


#Variabel for the number of databases that should be created
variable "amount_db" {
  type      = number
  default   = "1"
}



##Variables that should not be changed

variable "enviroment" {
  type      = string
  default   = ""
}


variable "location" {
  type      = string
  default   = "norwayeast"
}

