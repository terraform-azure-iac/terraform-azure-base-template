# IoT

## Info / intro

This module sets up..

A [Rasbery PI IoT simulator](https://azure-samples.github.io/raspberry-pi-web-simulator/) can be used to test the iot module and infrastructure. It can be used as an iot-device and send msg to Azure (IotHub, IoT Central, Eventhub).

![8-iot.png](/img/8-iot.png)

## Configure Module
- Naming for resources 
- Location 
- Tier, Size, sku, capacity and Version of the resources
- Cache fot kusto db
- msg retention
- data format
- replication type
- encryption type
- db tabel throughput 
- network: address spaces
- powerbi admins



--------------------------------------
## Terraform documentation 

### Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |


### Resources

| Name | Type |
|------|------|
| [azurerm_app_service.app_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service) | resource |
| [azurerm_app_service_plan.app_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan) | resource |
| [azurerm_app_service_plan.app_service_plan_logic_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_cosmosdb_account.cosmosdb_account_iot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |
| [azurerm_cosmosdb_table.cosmosdb_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_table) | resource |
| [azurerm_databricks_workspace.databricks_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace) | resource |
| [azurerm_digital_twins_endpoint_eventhub.digital_twins_eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_endpoint_eventhub) | resource |
| [azurerm_digital_twins_instance.digital_twins_instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_instance) | resource |
| [azurerm_eventhub.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_authorization_rule.eventhub_authorization_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_authorization_rule) | resource |
| [azurerm_eventhub_consumer_group.eventhub_consumer_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_consumer_group) | resource |
| [azurerm_eventhub_namespace.eventhub_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_iotcentral_application.iotcentral_application](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iotcentral_application) | resource |
| [azurerm_iothub.iothub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub) | resource |
| [azurerm_iothub_consumer_group.iothub_consumer_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_consumer_group) | resource |
| [azurerm_iothub_shared_access_policy.iothub_shared_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_shared_access_policy) | resource |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_kusto_cluster.kusto_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster) | resource |
| [azurerm_kusto_database.kusto_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_database) | resource |
| [azurerm_kusto_eventhub_data_connection.eventhub_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_eventhub_data_connection) | resource |
| [azurerm_logic_app_standard.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_standard) | resource |
| [azurerm_machine_learning_compute_cluster.ml_compute_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_cluster) | resource |
| [azurerm_machine_learning_compute_instance.ml_compute_instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_instance) | resource |
| [azurerm_machine_learning_workspace.ml_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace) | resource |
| [azurerm_resource_group.iot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_data_lake_gen2_filesystem.data_lake_gen2_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_filesystem) | resource |
| [azurerm_stream_analytics_job.stream_analytics_job](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_job) | resource |
| [azurerm_stream_analytics_stream_input_eventhub.stream_analytics_stream_input_eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/stream_analytics_stream_input_eventhub) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [random_integer.int](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [random_integer.int_stor](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [random_password.ml_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

### Inputs

| Name | Description | Type | Default | Should Default be changed? |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_dotnet_version"></a> [app\_service\_dotnet\_version](#input\_app\_service\_dotnet\_version) | n/a | `string` | `"v6.0"` | no |
| <a name="input_app_service_name"></a> [app\_service\_name](#input\_app\_service\_name) | n/a | `string` | `"iot-app"` | yes |
| <a name="input_app_service_plan_logic_app_name"></a> [app\_service\_plan\_logic\_app\_name](#input\_app\_service\_plan\_logic\_app\_name) | Logic App | `string` | `"iot-logic-app-service-plan"` | yes |
| <a name="input_app_service_plan_name"></a> [app\_service\_plan\_name](#input\_app\_service\_plan\_name) | App Service | `string` | `"iot-app-service-plan"` | yes |
| <a name="input_app_service_plan_sku_size"></a> [app\_service\_plan\_sku\_size](#input\_app\_service\_plan\_sku\_size) | n/a | `string` | `"B1"` | no |
| <a name="input_app_service_plan_sku_tier"></a> [app\_service\_plan\_sku\_tier](#input\_app\_service\_plan\_sku\_tier) | n/a | `string` | `"Basic"` | no |
| <a name="input_app_service_scm_type"></a> [app\_service\_scm\_type](#input\_app\_service\_scm\_type) | n/a | `string` | `"LocalGit"` | no |
| <a name="input_application_insight_name"></a> [application\_insight\_name](#input\_application\_insight\_name) | #################### Cold Path      # #################### | `string` | `"application-insight-iot"` | yes |
| <a name="input_application_insight_type"></a> [application\_insight\_type](#input\_application\_insight\_type) | n/a | `string` | `"web"` | no |
| <a name="input_cosmosdb_account_name"></a> [cosmosdb\_account\_name](#input\_cosmosdb\_account\_name) | Azure CosmosDB | `string` | `"iot-cosmosdb-bachelor-2022"` | yes |
| <a name="input_cosmosdb_cassandra_keyspace_name"></a> [cosmosdb\_cassandra\_keyspace\_name](#input\_cosmosdb\_cassandra\_keyspace\_name) | n/a | `string` | `"iot-cosmosdb-cassandra-keyspace-bachelor-2022"` | yes |
| <a name="input_cosmosdb_cassandra_keyspace_throughput"></a> [cosmosdb\_cassandra\_keyspace\_throughput](#input\_cosmosdb\_cassandra\_keyspace\_throughput) | n/a | `string` | `"800"` | no |
| <a name="input_cosmosdb_cassandra_table_name"></a> [cosmosdb\_cassandra\_table\_name](#input\_cosmosdb\_cassandra\_table\_name) | n/a | `string` | `"iot-cosmosdb-cassandra-table-bachelor-2022"` | yes |
| <a name="input_cosmosdb_table_name"></a> [cosmosdb\_table\_name](#input\_cosmosdb\_table\_name) | n/a | `string` | `"iot-cosmosdb-table-bachelor-2022"` | yes |
| <a name="input_cosmosdb_table_throughput"></a> [cosmosdb\_table\_throughput](#input\_cosmosdb\_table\_throughput) | n/a | `string` | `"800"` | no |
| <a name="input_dashboard_name"></a> [dashboard\_name](#input\_dashboard\_name) | Dashboard | `string` | `"iot-dashboard"` | yes |
| <a name="input_data_lake_name"></a> [data\_lake\_name](#input\_data\_lake\_name) | Data Lake Storage | `string` | `"datalakeiot"` | yes |
| <a name="input_data_lake_store_encryption_state"></a> [data\_lake\_store\_encryption\_state](#input\_data\_lake\_store\_encryption\_state) | n/a | `string` | `"Enabled"` | no |
| <a name="input_data_lake_store_encryption_type"></a> [data\_lake\_store\_encryption\_type](#input\_data\_lake\_store\_encryption\_type) | n/a | `string` | `"ServiceManaged"` | no |
| <a name="input_data_lake_store_name"></a> [data\_lake\_store\_name](#input\_data\_lake\_store\_name) | n/a | `string` | `"datalakestorageiot"` | yes |
| <a name="input_data_lake_store_tier"></a> [data\_lake\_store\_tier](#input\_data\_lake\_store\_tier) | n/a | `string` | `"Consumption"` | no |
| <a name="input_databricks_workspace_name"></a> [databricks\_workspace\_name](#input\_databricks\_workspace\_name) | Azure Databricks | `string` | `"databricks-workspace"` | yes |
| <a name="input_digital_twins_eventhub_name"></a> [digital\_twins\_eventhub\_name](#input\_digital\_twins\_eventhub\_name) | n/a | `string` | `"digital-twins-eventhub-iot"` | yes |
| <a name="input_digital_twins_instance_name"></a> [digital\_twins\_instance\_name](#input\_digital\_twins\_instance\_name) | Digital Twins | `string` | `"digital-twins-iot"` | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_eventhub_authorization_rule_name"></a> [eventhub\_authorization\_rule\_name](#input\_eventhub\_authorization\_rule\_name) | n/a | `string` | `"eventhub-authorization-rule"` | yes |
| <a name="input_eventhub_consumer_group_name"></a> [eventhub\_consumer\_group\_name](#input\_eventhub\_consumer\_group\_name) | n/a | `string` | `"eventhub-consumer-group"` | yes |
| <a name="input_eventhub_consumer_group_user_data"></a> [eventhub\_consumer\_group\_user\_data](#input\_eventhub\_consumer\_group\_user\_data) | n/a | `string` | `"some-meta-data"` | yes |
| <a name="input_eventhub_message_retention"></a> [eventhub\_message\_retention](#input\_eventhub\_message\_retention) | n/a | `number` | `1` | no |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | n/a | `string` | `"event-hub"` | no |
| <a name="input_eventhub_namespace_capacity"></a> [eventhub\_namespace\_capacity](#input\_eventhub\_namespace\_capacity) | n/a | `number` | `1` | no |
| <a name="input_eventhub_namespace_name"></a> [eventhub\_namespace\_name](#input\_eventhub\_namespace\_name) | #################### Ingestion     # #################### Event Hub | `string` | `"event-hub-namespace-bachelor-2022"` | yes |
| <a name="input_eventhub_namespace_sku"></a> [eventhub\_namespace\_sku](#input\_eventhub\_namespace\_sku) | n/a | `string` | `"Standard"` | no |
| <a name="input_eventhub_partition_count"></a> [eventhub\_partition\_count](#input\_eventhub\_partition\_count) | n/a | `number` | `2` | no |
| <a name="input_hdinsight_kafka_cluster_name"></a> [hdinsight\_kafka\_cluster\_name](#input\_hdinsight\_kafka\_cluster\_name) | n/a | `string` | `"HDinsight-kafka-cluster"` | yes |
| <a name="input_hdinsight_kafka_cluster_tier"></a> [hdinsight\_kafka\_cluster\_tier](#input\_hdinsight\_kafka\_cluster\_tier) | n/a | `string` | `"Standard"` | no |
| <a name="input_hdinsight_kafka_cluster_username"></a> [hdinsight\_kafka\_cluster\_username](#input\_hdinsight\_kafka\_cluster\_username) | n/a | `string` | `"bachelor-2022-admin"` | yes |
| <a name="input_hdinsight_kafka_cluster_version"></a> [hdinsight\_kafka\_cluster\_version](#input\_hdinsight\_kafka\_cluster\_version) | n/a | `string` | `"4.0"` | no |
| <a name="input_hdinsight_kafka_cluster_vm_size"></a> [hdinsight\_kafka\_cluster\_vm\_size](#input\_hdinsight\_kafka\_cluster\_vm\_size) | n/a | `string` | `"Standard_D3_V2"` | no |
| <a name="input_hdinsight_kafka_cluster_worker_count"></a> [hdinsight\_kafka\_cluster\_worker\_count](#input\_hdinsight\_kafka\_cluster\_worker\_count) | n/a | `number` | `3` | no |
| <a name="input_hdinsight_kafka_cluster_worker_nr_disks"></a> [hdinsight\_kafka\_cluster\_worker\_nr\_disks](#input\_hdinsight\_kafka\_cluster\_worker\_nr\_disks) | n/a | `number` | `3` | no |
| <a name="input_iotcentral_application_name"></a> [iotcentral\_application\_name](#input\_iotcentral\_application\_name) | IoT Central | `string` | `"iot-central-application-bachelor-2022"` | yes |
| <a name="input_iotcentral_application_sku"></a> [iotcentral\_application\_sku](#input\_iotcentral\_application\_sku) | n/a | `string` | `"ST1"` | no |
| <a name="input_iotcentral_application_subdomain"></a> [iotcentral\_application\_subdomain](#input\_iotcentral\_application\_subdomain) | n/a | `string` | `"iot-central-application-subdomain"` | yes |
| <a name="input_iothub_consumer_group_name"></a> [iothub\_consumer\_group\_name](#input\_iothub\_consumer\_group\_name) | n/a | `string` | `"iothub-consumer-group"` | yes |
| <a name="input_iothub_endpoint_authentication_type"></a> [iothub\_endpoint\_authentication\_type](#input\_iothub\_endpoint\_authentication\_type) | can be either keyBased (default) or identityBased | `string` | `"keyBased"` | no |
| <a name="input_iothub_endpoint_name"></a> [iothub\_endpoint\_name](#input\_iothub\_endpoint\_name) | n/a | `string` | `"iothub-endpoint"` | yes |
| <a name="input_iothub_identity_type"></a> [iothub\_identity\_type](#input\_iothub\_identity\_type) | SystemAssigned or UserAssigned | `string` | `"SystemAssigned"` | no |
| <a name="input_iothub_ip_filter_action"></a> [iothub\_ip\_filter\_action](#input\_iothub\_ip\_filter\_action) | n/a | `string` | `"Reject"` | no |
| <a name="input_iothub_ip_filter_ip_mask"></a> [iothub\_ip\_filter\_ip\_mask](#input\_iothub\_ip\_filter\_ip\_mask) | n/a | `list(string)` | <pre>[<br>  "10.10.10.0/32"<br>]</pre> | yes |
| <a name="input_iothub_ip_filter_name"></a> [iothub\_ip\_filter\_name](#input\_iothub\_ip\_filter\_name) | n/a | `string` | `"iothub-ip-filter"` | yes |
| <a name="input_iothub_name"></a> [iothub\_name](#input\_iothub\_name) | IoT Hub | `string` | `"iot-hub-bachelor-2022"` | yes |
| <a name="input_iothub_route_name"></a> [iothub\_route\_name](#input\_iothub\_route\_name) | n/a | `string` | `"iothub-route"` | yes |
| <a name="input_iothub_route_source"></a> [iothub\_route\_source](#input\_iothub\_route\_source) | Posible values are: Invalid, DeviceMessages, TwinChangeEvents, DeviceLifecycleEvents, DeviceConnectionStateEvents, DeviceJobLifecycleEvents | `string` | `"DeviceMessages"` | no |
| <a name="input_iothub_shared_access_policy_name"></a> [iothub\_shared\_access\_policy\_name](#input\_iothub\_shared\_access\_policy\_name) | n/a | `string` | `"iothub-shared-access-policy-group"` | yes |
| <a name="input_iothub_sku_capacity"></a> [iothub\_sku\_capacity](#input\_iothub\_sku\_capacity) | n/a | `number` | `1` | no |
| <a name="input_iothub_sku_name"></a> [iothub\_sku\_name](#input\_iothub\_sku\_name) | F1 = free, or you can use B or S 1-3, and you have use S to activate Defender for IoT | `string` | `"F1"` | no |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | n/a | `string` | `"keyvaultiot-bach22"` | yes |
| <a name="input_key_vault_sku"></a> [key\_vault\_sku](#input\_key\_vault\_sku) | n/a | `string` | `"standard"` | no |
| <a name="input_kusto_cluster_name"></a> [kusto\_cluster\_name](#input\_kusto\_cluster\_name) | Azure Data Explorer | `string` | `"kustoclusterbach"` | yes |
| <a name="input_kusto_cluster_sku_capacity"></a> [kusto\_cluster\_sku\_capacity](#input\_kusto\_cluster\_sku\_capacity) | n/a | `string` | `"1"` | no |
| <a name="input_kusto_cluster_sku_name"></a> [kusto\_cluster\_sku\_name](#input\_kusto\_cluster\_sku\_name) | Valid values are: Dev(No SLA)\_Standard\_D11\_v2, Dev(No SLA)\_Standard\_E2a\_v4, Standard\_D11\_v2, Standard\_D12\_v2, Standard\_D13\_v2, Standard\_D14\_v2, Standard\_DS13\_v2+1TB\_PS, Standard\_DS13\_v2+2TB\_PS, Standard\_DS14\_v2+3TB\_PS, Standard\_DS14\_v2+4TB\_PS, Standard\_E16as\_v4+3TB\_PS, Standard\_E16as\_v4+4TB\_PS, Standard\_E16a\_v4, Standard\_E2a\_v4, Standard\_E4a\_v4, Standard\_E64i\_v3, Standard\_E8as\_v4+1TB\_PS, Standard\_E8as\_v4+2TB\_PS, Standard\_E8a\_v4, Standard\_L16s, Standard\_L4s, Standard\_L8s, Standard\_L16s\_v2 and Standard\_L8s\_v2. | 
`string` | `"Dev(No SLA)_Standard_D11_v2"` | no |
| <a name="input_kusto_connection_data_format"></a> [kusto\_connection\_data\_format](#input\_kusto\_connection\_data\_format) | data format of the EventHub/IoTHub messages. Allowed values: APACHEAVRO, AVRO, CSV, JSON, MULTIJSON, ORC, PARQUET, PSV, RAW, SCSV, SINGLEJSON, SOHSV, TSVE, TSV, TXT, and W3CLOGFILE. | `string` | `"JSON"` | no |  
| <a name="input_kusto_database_name"></a> [kusto\_database\_name](#input\_kusto\_database\_name) | n/a | `string` | `"kusto-database"` | yes |
| <a name="input_kusto_eventhub_connection_name"></a> [kusto\_eventhub\_connection\_name](#input\_kusto\_eventhub\_connection\_name) | n/a | `string` | `"kusto-eventhub-connection"` | yes |
| <a name="input_kusto_iothub_connection_name"></a> [kusto\_iothub\_connection\_name](#input\_kusto\_iothub\_connection\_name) | n/a | `string` | `"kusto-eventhub-connection"` | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"norwayeast"` | no |
| <a name="input_logic_app_name"></a> [logic\_app\_name](#input\_logic\_app\_name) | n/a | `string` | `"iot-logic-app-bachelor-2022"` | yes |
| <a name="input_ml_compute_cluster_name"></a> [ml\_compute\_cluster\_name](#input\_ml\_compute\_cluster\_name) | n/a | `string` | `"ml-compute-cluster"` | yes |
| <a name="input_ml_compute_cluster_scale_down"></a> [ml\_compute\_cluster\_scale\_down](#input\_ml\_compute\_cluster\_scale\_down) | 30 sek | `string` | `"PT30S"` | no |
| <a name="input_ml_compute_cluster_vm"></a> [ml\_compute\_cluster\_vm](#input\_ml\_compute\_cluster\_vm) | n/a | `string` | `"STANDARD_DS2_V2"` | no |
| <a name="input_ml_compute_cluster_vm_pri"></a> [ml\_compute\_cluster\_vm\_pri](#input\_ml\_compute\_cluster\_vm\_pri) | n/a | `string` | `"LowPriority"` | no |
| <a name="input_ml_compute_instance_name"></a> [ml\_compute\_instance\_name](#input\_ml\_compute\_instance\_name) | n/a | `string` | `"ml-inst-bac22"` | no |
| <a name="input_ml_compute_instance_vm"></a> [ml\_compute\_instance\_vm](#input\_ml\_compute\_instance\_vm) | n/a | `string` | `"STANDARD_DS2_V2"` | no |
| <a name="input_ml_location"></a> [ml\_location](#input\_ml\_location) | Machine Learning | `string` | `"northeurope"` | no |
| <a name="input_ml_ssh_key"></a> [ml\_ssh\_key](#input\_ml\_ssh\_key) | n/a | `string` | `"ssh-rsa ......."` | yes |
| <a name="input_ml_workspace_name"></a> [ml\_workspace\_name](#input\_ml\_workspace\_name) | n/a | `string` | `"ml-workspace"` | yes |
| <a name="input_powerbi_embedded_admins"></a> [powerbi\_embedded\_admins](#input\_powerbi\_embedded\_admins) | Azure Advisor - admin, cant be guest user | `list(string)` | <pre>[<br>  "c39c9bac-9d1f-4dfb-aa29-27f6365e5cb7"<br>]</pre> | yes |
| <a name="input_powerbi_embedded_name"></a> [powerbi\_embedded\_name](#input\_powerbi\_embedded\_name) | #################### User Interface    # #################### Power BI | `string` | `"powerbiiot"` | yes |
| <a name="input_powerbi_embedded_sku"></a> [powerbi\_embedded\_sku](#input\_powerbi\_embedded\_sku) | n/a | `string` | `"A1"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `"IoT"` | yes |
| <a name="input_storage_account_hdinsight_name"></a> [storage\_account\_hdinsight\_name](#input\_storage\_account\_hdinsight\_name) | HD Insight Cluster | `string` | `"hdinstoraccbach"` | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | #################### Storage/Data    # #################### Storage Account | `string` | `"storaccbach2022"` | yes |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | n/a | `string` | `"LRS"` | no |
| <a name="input_storage_account_tier"></a> [storage\_account\_tier](#input\_storage\_account\_tier) | n/a | `string` | `"Standard"` | no |
| <a name="input_storage_container_hdinsight_name"></a> [storage\_container\_hdinsight\_name](#input\_storage\_container\_hdinsight\_name) | n/a | `string` | `"hdinsight-storage-container"` | yes |
| <a name="input_stream_analytics_input_eventhub_name"></a> [stream\_analytics\_input\_eventhub\_name](#input\_stream\_analytics\_input\_eventhub\_name) | n/a | `string` | `"stream-analytica-eventhub-input"` | yes |
| <a name="input_stream_analytics_input_iothub_name"></a> [stream\_analytics\_input\_iothub\_name](#input\_stream\_analytics\_input\_iothub\_name) | n/a | `string` | `"stream-analytica-iothub-input"` | yes |
| <a name="input_stream_analytics_job_name"></a> [stream\_analytics\_job\_name](#input\_stream\_analytics\_job\_name) | #################### Hot Path       # #################### Stream Analythics Jobs | `string` | `"stream-analytica-job"` | yes |
| <a name="input_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#input\_subnet\_address\_prefixes) | n/a | `list(string)` | <pre>[<br>  "10.1.0.0/24"<br>]</pre> | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | n/a | `string` | `"ml-subnet"` | yes |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | n/a | `list(string)` | <pre>[<br>  "10.1.0.0/16"<br>]</pre> | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Networking | `string` | `"ml-vnet"` | yes |



-----------------------------------------

## Resources

- Name of each resource in the module (links to documentation), what it does in this module
- ..
- 







## References
Link to the Azure resource can be found in the [Resources table](#resources). By clicking on the name of the resource you will be sent to the HashiCorps Terraform documentation/registry for that resource.

Micorsoft Documenation:
- [Rasbery PI IoT simulator](https://azure-samples.github.io/raspberry-pi-web-simulator/)
- [App Service documentation](https://docs.microsoft.com/nb-no/azure/app-service/)
- [Azure App Service plan overview](https://docs.microsoft.com/en-us/azure/app-service/overview-hosting-plans)
- [Application Insights overview](https://docs.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview)
- [Azure Cosmos DB documentation](https://docs.microsoft.com/en-us/azure/cosmos-db/)
- [Welcome to Azure Cosmos DB](https://docs.microsoft.com/en-us/azure/cosmos-db/introduction)
  - [Consistency levels in Azure Cosmos DB](https://docs.microsoft.com/en-us/azure/cosmos-db/consistency-levels)
- [Azure Databricks documentation](https://docs.microsoft.com/en-us/azure/databricks/)
    - [What is Azure Databricks?](https://docs.microsoft.com/en-us/azure/databricks/scenarios/what-is-azure-databricks)
- [Azure Digital Twins Documentation](https://docs.microsoft.com/en-us/azure/digital-twins/)
    - [What is Azure Digital Twins?](https://docs.microsoft.com/en-us/azure/digital-twins/overview)
- [Azure Event Hubs documentation](https://docs.microsoft.com/en-us/azure/event-hubs/)
    - [Azure Event Hubs — A big data streaming platform and event ingestion service
](https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-about)
- [Azure IoT Hub Documentation](https://docs.microsoft.com/en-us/azure/iot-hub/)
    - [IoT concepts and Azure IoT Hub](https://docs.microsoft.com/en-us/azure/iot-hub/iot-concepts-and-iot-hub)
- [Azure Key Vault documentation](https://docs.microsoft.com/en-us/azure/key-vault/general/)
    - [About Azure Key Vault](https://docs.microsoft.com/en-us/azure/key-vault/general/overview)
    - [Azure Key Vault basic concepts](https://docs.microsoft.com/en-us/azure/key-vault/general/basic-concepts)
- [Azure Data Explorer documentation - Kusto](https://docs.microsoft.com/en-us/azure/data-explorer/)
- [What is Azure Logic Apps?](https://docs.microsoft.com/en-us/azure/logic-apps/logic-apps-overview)
- [Azure Machine Learning documentation](https://docs.microsoft.com/en-us/azure/machine-learning/)
    - [What is Azure Machine Learning?](https://docs.microsoft.com/en-us/azure/machine-learning/overview-what-is-azure-machine-learning)
- [Manage Azure resource groups by using the Azure portal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal)
- [Storage account overview](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview)
- [Introduction to Azure Data Lake Storage Gen2](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction)
    - [Azure Blob Storage documentation](https://docs.microsoft.com/en-us/azure/storage/blobs/)
    - [Introduction to Azure Blob storage](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction)
- [Virtual Network documentation](https://docs.microsoft.com/en-us/azure/virtual-network/)
- [Azure Stream Analytics documentation](https://docs.microsoft.com/en-us/azure/stream-analytics/)
- [Quickstart: Create an Azure Stream Analytics job in Visual Studio Code](https://docs.microsoft.com/en-us/azure/stream-analytics/quick-create-visual-studio-code)
- [Choose between Azure messaging services - Event Grid, Event Hubs, and Service Bus](https://docs.microsoft.com/en-us/azure/event-grid/compare-messaging-services)
- [Azure IoT Hub Documentation](https://docs.microsoft.com/nb-no/azure/iot-hub/)
- [IoT concepts and Azure IoT Hub](https://docs.microsoft.com/nb-no/azure/iot-hub/iot-concepts-and-iot-hub?WT.mc_id=Portal-HubsExtension)
- [Azure HDInsight documentation](https://docs.microsoft.com/en-us/azure/hdinsight/)
- [What is Azure HDInsight?](https://docs.microsoft.com/en-us/azure/hdinsight/hdinsight-overview)

