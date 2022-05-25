#Oppretter en resource group for alt relater til storage
resource "azurerm_resource_group" "sql" {
    name        = "${var.resource_group_name}-${var.enviroment}"
    location    = var.location
}

//Policy for å hindre ressuser utenfor Norge i å bli opprettet
/** 
resource "azurerm_policy_definition" "policy_definition" {
    name            = var.policy_definition_name
    display_name    = var.policy_definition_name 
    policy_type     = "Custom"
    mode            = "All"
    policy_rule     =  <<POLICY_RULE
        {
            "if": {
                "not": {
                    "field": "location",
                    "equals": "norwayeast"
                }            
            },
                "then":{
                    "effect": "Deny"
                }
        
        }
        POLICY_RULE
}

resource "azurerm_resource_group_policy_assignment" "resource_group_policy_assignment" {
    name                    = var.resource_group_policy_assignment_name
    resource_group_id       = azurerm_resource_group.sql.id
    policy_definition_id    = azurerm_policy_definition.policy_definition.id
}

**/

#Oppretter en middlertidig storage account for storage testing, kan være relevant å ha 1 og hente den fra et annet sted?
resource "azurerm_storage_account" "storage_account_sql" {
    name                      = var.storage_account_sql_name
    resource_group_name       = azurerm_resource_group.sql.name
    location                  = var.location
    account_tier              = var.account_tier
    #Foreløpig satt til locally-redundant storage 
    account_replication_type  = var.account_replication_type 
}

#Oppretter en container tilknyttet storage accounten, slik at de kan lagres blober på den
resource "azurerm_storage_container" "storage_container" {
    name                      = var.storage_container_name
    storage_account_name      = azurerm_storage_account.storage_account_sql.name
    container_access_type     = var.container_access_type
}

#Oppretter en tom blob, men sånn jeg har tolket det så referer blob til måten filer lagres på i azure. Så en fil som lastes opp 
#i en container kan refereres til som en blob.
resource "azurerm_storage_blob" "storage_blob" {
    name                      = var.storage_blob_name 
    storage_account_name      = azurerm_storage_account.storage_account_sql.name
    storage_container_name    = azurerm_storage_container.storage_container.name
    type                      = var.type_blob
}

resource "azurerm_data_protection_backup_vault" "data_protection_backup_vault" {
    name                  = var.data_protection_backup_vault_name
    resource_group_name   = azurerm_resource_group.sql.name
    location              = var.location
    datastore_type        = var.datastore_type
    redundancy            = var.redundancy
}

resource "azurerm_data_protection_backup_policy_blob_storage" "backup_policy_blob_storage" {
    name                  = var.data_protection_backup_policy_blob_storage_name
    vault_id              = azurerm_data_protection_backup_vault.data_protection_backup_vault.id
    retention_duration    = var.retention_duration
}



#Generer et tilfeldig passord for databasene
resource "random_password" "password" {
    length            = 16
    special           = true
}

#Oppretter en mssql server for å kunne knytte sql databaser til
resource "azurerm_mssql_server" "mssql_server" {
    name                          = var.mssql_server_name
    resource_group_name           = azurerm_resource_group.sql.name
    location                      = var.location
    version                       = var.version_mssql
    administrator_login           = var.adminstrator_login
    administrator_login_password  = random_password.password.result
}

#Oppretter antall spesifiserte mssql databser, antall bestemmes i variabel filen
resource "azurerm_mssql_database" "mssql_databse" {
    count           = var.amount_db
    name            = "${var.mssql_databse_name}-${count.index+1}"
    server_id       = azurerm_mssql_server.mssql_server.id
    max_size_gb     = 4
    zone_redundant  = false

    threat_detection_policy {
        state                       = var.enabled
        email_account_admins        = var.enabled
        use_server_default          = var.enabled
        storage_endpoint            = azurerm_storage_account.storage_account_sql.primary_blob_endpoint
        storage_account_access_key  = azurerm_storage_account.storage_account_sql.primary_access_key
    }       

    short_term_retention_policy {
        retention_days = 30
    }
    #Må endres etter behov
    long_term_retention_policy {
        weekly_retention      = "P14D"
        monthly_retention     = "P24W"
        yearly_retention      = "P10Y"
        week_of_year          = 26
    }   

}

#Oppretter en auditing policy for mssql serveren, dette lagres på containeren
resource "azurerm_mssql_server_extended_auditing_policy" "mssql_server_auditing" {
    server_id                   = azurerm_mssql_server.mssql_server.id
    storage_endpoint            = azurerm_storage_account.storage_account_sql.primary_blob_endpoint
    storage_account_access_key  = azurerm_storage_account.storage_account_sql.primary_access_key
    retention_in_days           = 6
}

#Oppretter en auditing for mssql databasene, går i samsvar med opprettelse av databsene, det vill opprettes en for antall ønsket databaser spesifisert i variabelen
resource "azurerm_mssql_database_extended_auditing_policy" "mssql_database_auditing" {
    count                       = var.amount_db
    database_id                 = azurerm_mssql_database.mssql_databse[count.index].id
    storage_endpoint            = azurerm_storage_account.storage_account_sql.primary_blob_endpoint
    storage_account_access_key  = azurerm_storage_account.storage_account_sql.primary_access_key
    retention_in_days           = 6
}

#Makes a security alert policy for the mssql server
resource "azurerm_mssql_server_security_alert_policy" "mssql_server_security_alert_policy" {
    resource_group_name         = azurerm_resource_group.sql.name 
    server_name                 = azurerm_mssql_server.mssql_server.name
    state                       = var.enabled
    storage_endpoint            = azurerm_storage_account.storage_account_sql.primary_blob_endpoint
    storage_account_access_key  = azurerm_storage_account.storage_account_sql.primary_access_key
    email_addresses             = var.email
    retention_days              = 10  
}

#Sets up a vulernability assesment for the mssql server
resource "azurerm_mssql_server_vulnerability_assessment" "mssql_server_vulnerability_assessment" {
    server_security_alert_policy_id     = azurerm_mssql_server_security_alert_policy.mssql_server_security_alert_policy.id
    storage_container_path              = "${azurerm_storage_account.storage_account_sql.primary_blob_endpoint}${azurerm_storage_container.storage_container.name}/"
    storage_account_access_key          =  azurerm_storage_account.storage_account_sql.primary_access_key

    recurring_scans {
        enabled                     = true
        email_subscription_admins   = true
        emails                      = var.email
        }
}

//Ikke tilgjenlig i Norge enda, er derfor eksudert på grunn av sikkerhet/compliance
/* 
resource "azurerm_data_share_account" "data_share_account" {
    name                  = var.data_share_account_name
    location              = "northeurope"
    resource_group_name   = azurerm_resource_group.sql.name
    identity {
        type = "SystemAssigned"
    }
}


resource "azurerm_data_share" "data_share" {
    name          = var.data_share_name 
    account_id    = azurerm_data_share_account.data_share_account.id
    kind          = "CopyBased"
}

data "azuread_service_principal" "service_principal" {
    display_name = azurerm_data_share_account.data_share_account.name
}

resource "azurerm_role_assignment" "role_assignment" {
    scope                 = azurerm_storage_account.storage_account_sql.id
    role_definition_name  = "Storage Blob Data Reader"
    principal_id          = data.azuread_service_principal.service_principal.object_id
}

data "azurerm_subscription" "current" {}

resource "azurerm_data_share_dataset_blob_storage" "data_share_dataset_blob_storage" {
    name            = var.data_share_dataset_blob_storage_name
    data_share_id   = azurerm_data_share.data_share.id
    container_name  = azurerm_storage_container.storage_container.name
    storage_account {
        name                    = azurerm_storage_account.storage_account_sql.name
        resource_group_name     = azurerm_storage_account.storage_account_sql.resource_group_name
        subscription_id         = data.azurerm_subscription.current.id
    }
    file_path   = "myfile.txt"
    depends_on  = [
        azurerm_role_assignment.role_assignment,
    ]
}

*/