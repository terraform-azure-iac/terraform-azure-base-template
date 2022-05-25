# Name of module



## Info / intro

This module sets up..

![6-storage.png](/img/6-storage.png)

## Configure Module
- Naming for resources 
- Location 
- Tier, Size, sku and Version of the resources
- number of retnetion days, time and repeat frequency


### Usage



Account replication type = LRS -> locally-redundant storage "Brukes da for ikke kritisk data"
                           GRS -> Geo-Redundant storage "Burde brukes for kritisk data, men kan potensielt hindres av lovverk siden det da kan lagres utenfor norge"

Må sjekke public access configuration på storage account

Hot vs Cold blob -> hot: ofte accesed cold: sjeldent accesed

Network endpoint -> confgurert til public eller ikke?


-----------------------------
## Terraform documentation 

### Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |


### Resources

| Name | Type |
|------|------|
| [azurerm_data_protection_backup_policy_blob_storage.backup_policy_blob_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_policy_blob_storage) | resource |
| [azurerm_data_protection_backup_vault.data_protection_backup_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_vault) | resource |
| [azurerm_mssql_database.mssql_databse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |
| [azurerm_mssql_database_extended_auditing_policy.mssql_database_auditing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database_extended_auditing_policy) | resource |
| [azurerm_mssql_server.mssql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_mssql_server_extended_auditing_policy.mssql_server_auditing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_extended_auditing_policy) | resource |
| [azurerm_mssql_server_security_alert_policy.mssql_server_security_alert_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_security_alert_policy) | resource |
| [azurerm_mssql_server_vulnerability_assessment.mssql_server_vulnerability_assessment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_vulnerability_assessment) | resource |
| [azurerm_resource_group.sql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.storage_account_sql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_blob.storage_blob](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_container.storage_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |


### Inputs

| Name | Description | Type | Default | Should Default be changed? |
|------|-------------|------|---------|:--------:|
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | n/a | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | n/a | `string` | `"Standard"` | no |
| <a name="input_adminstrator_login"></a> [adminstrator\_login](#input\_adminstrator\_login) | n/a | `string` | `"test"` | yes |
| <a name="input_amount_db"></a> [amount\_db](#input\_amount\_db) | n/a | `number` | `"1"` | no |
| <a name="input_container_access_type"></a> [container\_access\_type](#input\_container\_access\_type) | n/a | `string` | `"private"` | no |
| <a name="input_data_protection_backup_policy_blob_storage_name"></a> [data\_protection\_backup\_policy\_blob\_storage\_name](#input\_data\_protection\_backup\_policy\_blob\_storage\_name) | n/a | `string` | `"backup-policy-blob-storage"` | yes |
| <a name="input_data_protection_backup_vault_name"></a> [data\_protection\_backup\_vault\_name](#input\_data\_protection\_backup\_vault\_name) | n/a | `string` | `"data-protection-backup-vault"` | yes |
| <a name="input_data_share_account_name"></a> [data\_share\_account\_name](#input\_data\_share\_account\_name) | n/a | `string` | `"navn-data-share-account"` | yes |
| <a name="input_data_share_dataset_blob_storage_name"></a> [data\_share\_dataset\_blob\_storage\_name](#input\_data\_share\_dataset\_blob\_storage\_name) | n/a | `string` | `"navn-dataset-blob-storage"` | yes |
| <a name="input_data_share_name"></a> [data\_share\_name](#input\_data\_share\_name) | n/a | `string` | `"navn_data_share"` | yes |
| <a name="input_datastore_type"></a> [datastore\_type](#input\_datastore\_type) | n/a | `string` | `"VaultStore"` | no |
| <a name="input_email"></a> [email](#input\_email) | n/a | `list` | <pre>[<br>  "user1@test.no",<br>  "user2@test.no"<br>]</pre> | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | n/a | `string` | `"Enabled"` | no |
| <a name="input_enviroment"></a> [enviroment](#input\_enviroment) | n/a | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"norwayeast"` | no |
| <a name="input_mssql_databse_name"></a> [mssql\_databse\_name](#input\_mssql\_databse\_name) | n/a | `string` | `"mssql-databse"` | yes |
| <a name="input_mssql_server_name"></a> [mssql\_server\_name](#input\_mssql\_server\_name) | n/a | `string` | `"navn-mssql-server"` | yes |
| <a name="input_policy_definition_name"></a> [policy\_definition\_name](#input\_policy\_definition\_name) | n/a | `string` | `"Restrict access to location"` | no |
| <a name="input_redundancy"></a> [redundancy](#input\_redundancy) | n/a | `string` | `"LocallyRedundant"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `"sql-database"` | yes |
| <a name="input_resource_group_policy_assignment_name"></a> [resource\_group\_policy\_assignment\_name](#input\_resource\_group\_policy\_assignment\_name) | n/a | `string` | `"SQL policy"` | yes |
| <a name="input_retention_duration"></a> [retention\_duration](#input\_retention\_duration) | n/a | `string` | `"P30D"` | no |
| <a name="input_storage_account_sql_name"></a> [storage\_account\_sql\_name](#input\_storage\_account\_sql\_name) | n/a | `string` | `"navn-storage"` | yes |
| <a name="input_storage_blob_name"></a> [storage\_blob\_name](#input\_storage\_blob\_name) | n/a | `string` | `"storage-blob-sql"` | yes |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | n/a | `string` | `"storage-container-sql"` | yes |
| <a name="input_type_blob"></a> [type\_blob](#input\_type\_blob) | n/a | `string` | `"Block"` | no |
| <a name="input_version_mssql"></a> [version\_mssql](#input\_version\_mssql) | n/a | `string` | `"12.0"` | no |


----------------------------------------------------



## References:
Link to the Azure resource can be found in the [Resources table](#resources). By clicking on the name of the resource you will be sent to the HashiCorps Terraform documentation/registry for that resource.

Micorsoft Documenation:
- [Manage Azure resource groups by using the Azure portal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal)
- [Azure SQL documentation](https://docs.microsoft.com/en-us/azure/azure-sql/)
- [What is Azure SQL Database?](https://docs.microsoft.com/en-us/azure/azure-sql/database/sql-database-paas-overview)
- [Storage account overview](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview)
- [Azure Blob Storage documentation](https://docs.microsoft.com/en-us/azure/storage/blobs/)
- [Introduction to Azure Blob storage](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction)
- [Azure Backup service documentation](https://docs.microsoft.com/en-us/azure/backup/)
- [Backup vaults overview](https://docs.microsoft.com/en-us/azure/backup/backup-vault-overview)


Terraform:
- Mssql Database: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database
- Random passsword: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
- Mssql server: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server
- Storage account: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
- Blob storage: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob
- mssql server auditing: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_extended_auditing_policy
- mssql databse auditing: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database_extended_auditing_policy
- blob data protection: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_backup_policy_blob_storage
- mssql server vulnerability assesment: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_vulnerability_assessment
- mssql server security alert policy: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_security_alert_policy
- Se på seinere: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy
               https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_pool
               