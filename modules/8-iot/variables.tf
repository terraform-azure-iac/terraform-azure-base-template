variable "environment" {
    type    = string
    default = ""
}

variable "resource_group_name" {
    type    = string
    default = "IoT"
} 

variable "location" {
    type    = string
    default = "norwayeast"
}

#IoT Central
variable "iotcentral_application_name" {
    type    = string
    default = "iot-central-application-bachelor-2022"
}

variable "iotcentral_application_subdomain" {
    type    = string
    default = "iot-central-application-subdomain"
}

variable "iotcentral_application_sku" {
    type    = string
    default = "ST1"
}


#####################
#     Ingestion     #
#####################
#Event Hub
variable "eventhub_namespace_name" {
    type    = string
    default = "event-hub-namespace-bachelor-2022"
}

variable "eventhub_namespace_sku" {
    type    = string
    default = "Standard"
}

variable "eventhub_namespace_capacity" {
    type    = number
    default = 1
}

variable "eventhub_name" {
    type    = string
    default = "event-hub"
}

variable "eventhub_partition_count" {
    type    = number
    default = 2
}

variable "eventhub_message_retention" {
    type    = number
    default = 1
}

variable "eventhub_authorization_rule_name" {
    type    = string
    default = "eventhub-authorization-rule"
}

variable "eventhub_consumer_group_name" {
    type    = string
    default = "eventhub-consumer-group"
}

variable "eventhub_consumer_group_user_data" {
    type    = string
    default = "some-meta-data"
}


#IoT Hub
variable "iothub_name" {
    type    = string
    default = "iot-hub-bachelor-2022"
}

variable "iothub_sku_name" {
    type    = string
    default = "F1"
    description  = "F1 = free, or you can use B or S 1-3, and you have use S to activate Defender for IoT"
}

variable "iothub_sku_capacity" {
    type        = number
    default     = 1
}

variable "iothub_endpoint_name" {
    type    = string
    default = "iothub-endpoint"
}

variable "iothub_endpoint_authentication_type" {
    type        = string
    default     = "keyBased"
    description  = "can be either keyBased (default) or identityBased"
}

variable "iothub_route_name" {
    type    = string
    default = "iothub-route"
}

variable "iothub_route_source" {
    type        = string
    default     = "DeviceMessages"
    description  = "Posible values are: Invalid, DeviceMessages, TwinChangeEvents, DeviceLifecycleEvents, DeviceConnectionStateEvents, DeviceJobLifecycleEvents"
}

variable "iothub_identity_type" {
    type    = string
    default = "SystemAssigned"
    description = "SystemAssigned or UserAssigned"
}

variable "iothub_ip_filter_name" {
    type    = string
    default = "iothub-ip-filter"
}

variable "iothub_ip_filter_ip_mask" {
    type    = list(string)
    default = ["10.10.10.0/32"]
}

variable "iothub_ip_filter_action" {
    type    = string
    default = "Reject"
}


variable "iothub_consumer_group_name" {
    type    = string
    default = "iothub-consumer-group"
}

variable "iothub_shared_access_policy_name" {
    type    = string
    default = "iothub-shared-access-policy-group"
}



#Digital Twins
variable "digital_twins_instance_name" {
    type    = string
    default = "digital-twins-iot"
}

variable "digital_twins_eventhub_name" {
    type    = string
    default = "digital-twins-eventhub-iot"
}



#####################
#    Hot Path       #
#####################
#Stream Analythics Jobs
variable "stream_analytics_job_name" {
    type    = string
    default = "stream-analytica-job"
}

variable "stream_analytics_input_iothub_name" {
    type    = string
    default = "stream-analytica-iothub-input"
}

variable "stream_analytics_input_eventhub_name" {
    type    = string
    default = "stream-analytica-eventhub-input"
}

#HD Insight Cluster
variable "storage_account_hdinsight_name" {
    type    = string
    default = "hdinstoraccbach"
}

variable "storage_container_hdinsight_name" {
    type    = string
    default = "hdinsight-storage-container"
}

variable "hdinsight_kafka_cluster_name" {
    type    = string
    default = "HDinsight-kafka-cluster"
}

variable "hdinsight_kafka_cluster_version" {
    type    = string
    default = "4.0"
}

variable "hdinsight_kafka_cluster_tier" {
    type    = string
    default = "Standard"
}


variable "hdinsight_kafka_cluster_username" {
    type    = string
    default = "bachelor-2022-admin"
}

variable "hdinsight_kafka_cluster_vm_size" {
    type    = string
    default = "Standard_D3_V2"
}
variable "hdinsight_kafka_cluster_worker_nr_disks" {
    type    = number
    default = 3
}

variable "hdinsight_kafka_cluster_worker_count" {
    type    = number
    default = 3
}

#Azure Data Explorer 
variable "kusto_cluster_name" {
    type    = string
    default = "kustoclusterbach"
}
variable "kusto_cluster_sku_name" {
    type        = string
    default     = "Dev(No SLA)_Standard_D11_v2"
    description = "Valid values are: Dev(No SLA)_Standard_D11_v2, Dev(No SLA)_Standard_E2a_v4, Standard_D11_v2, Standard_D12_v2, Standard_D13_v2, Standard_D14_v2, Standard_DS13_v2+1TB_PS, Standard_DS13_v2+2TB_PS, Standard_DS14_v2+3TB_PS, Standard_DS14_v2+4TB_PS, Standard_E16as_v4+3TB_PS, Standard_E16as_v4+4TB_PS, Standard_E16a_v4, Standard_E2a_v4, Standard_E4a_v4, Standard_E64i_v3, Standard_E8as_v4+1TB_PS, Standard_E8as_v4+2TB_PS, Standard_E8a_v4, Standard_L16s, Standard_L4s, Standard_L8s, Standard_L16s_v2 and Standard_L8s_v2."
}
variable "kusto_cluster_sku_capacity" {
    type    = string
    default = "1"
}

variable "kusto_database_name" {
    type    = string
    default = "kusto-database"
}

variable "kusto_eventhub_connection_name" {
    type    = string
    default = "kusto-eventhub-connection"
}
variable "kusto_connection_data_format" {
    type    = string
    default = "JSON"
    description = "data format of the EventHub/IoTHub messages. Allowed values: APACHEAVRO, AVRO, CSV, JSON, MULTIJSON, ORC, PARQUET, PSV, RAW, SCSV, SINGLEJSON, SOHSV, TSVE, TSV, TXT, and W3CLOGFILE."
}

variable "kusto_iothub_connection_name" {
    type    = string
    default = "kusto-eventhub-connection"
}


#####################
#   Storage/Data    #
#####################
#Storage Account
variable "storage_account_name" {
    type    = string
    default = "storaccbach2022"
}

variable "storage_account_tier" {
    type    = string
    default = "Standard"
}

variable "storage_account_replication_type" {
    type    = string
    default = "LRS"
}

#Data Lake Storage
variable "data_lake_name" {
    type    = string
    default = "datalakeiot"
}

variable "data_lake_store_name" {
    type    = string
    default = "datalakestorageiot"
}

variable "data_lake_store_encryption_state" {
    type    = string
    default = "Enabled"
}

variable "data_lake_store_encryption_type" {
    type    = string
    default = "ServiceManaged"
}

variable "data_lake_store_tier" {
    type    = string
    default = "Consumption"
}

#Azure CosmosDB
variable "cosmosdb_account_name" {
    type    = string
    default = "iot-cosmosdb-bachelor-2022"
}


variable "cosmosdb_table_name" {
    type    = string
    default = "iot-cosmosdb-table-bachelor-2022"
}

variable "cosmosdb_table_throughput" {
    type    = string
    default = "800"
}


variable "cosmosdb_cassandra_keyspace_name" {
    type    = string
    default = "iot-cosmosdb-cassandra-keyspace-bachelor-2022"
}

variable "cosmosdb_cassandra_keyspace_throughput" {
    type    = string
    default = "800"
}

variable "cosmosdb_cassandra_table_name" {
    type    = string
    default = "iot-cosmosdb-cassandra-table-bachelor-2022"
}




#####################
#    Cold Path      #
#####################
variable "application_insight_name" {
    type    = string
    default = "application-insight-iot"
}
variable "application_insight_type" {
    type    = string
    default = "web"
}

variable "key_vault_name" {
    type    = string
    default = "keyvaultiot-bach22"
}

variable "key_vault_sku" {
    type    = string
    default = "standard"
}

#Networking
variable "vnet_name" {
    type    = string
    default = "ml-vnet"
}

variable "vnet_address_space" {
    type    = list(string)
    default = ["10.1.0.0/16"]
}

variable "subnet_name" {
    type    = string
    default = "ml-subnet"
}

variable "subnet_address_prefixes" {
    type    = list(string)
    default = ["10.1.0.0/24"]
}

#Machine Learning
variable "ml_location" {
    type    = string
    default = "northeurope"
}

variable "ml_ssh_key" {
    type    = string
    default = "ssh-rsa ......."
}

variable "ml_workspace_name" {
    type    = string
    default = "ml-workspace"
}

variable "ml_compute_instance_name" {
    type    = string
    default = "ml-inst-bac22"
}

variable "ml_compute_instance_vm" {
    type    = string
    default = "STANDARD_DS2_V2"
}

variable "ml_compute_cluster_name" {
    type    = string
    default = "ml-compute-cluster"
}

variable "ml_compute_cluster_vm_pri" {
    type    = string
    default = "LowPriority"
}

variable "ml_compute_cluster_vm" {
    type    = string
    default = "STANDARD_DS2_V2"
}

variable "ml_compute_cluster_scale_down" {
    type        = string
    default     = "PT30S"
    description = "30 sek"
}


#Azure Databricks
variable "databricks_workspace_name" {
    type    = string
    default = "databricks-workspace"
}




#####################
# User Interface    #
#####################
#Power BI
variable "powerbi_embedded_name" {
    type    = string
    default = "powerbiiot"
}

variable "powerbi_embedded_sku" {
    type    = string
    default = "A1"
}

variable "powerbi_embedded_admins" {
    type    = list(string)
    default = ["c39c9bac-9d1f-4dfb-aa29-27f6365e5cb7"]
    description = "Azure Advisor - admin, cant be guest user"
}

#App Service
variable "app_service_plan_name" {
    type    = string
    default = "iot-app-service-plan"
}

variable "app_service_plan_sku_tier" {
    type    = string
    default = "Basic"
}

variable "app_service_plan_sku_size" {
    type    = string
    default = "B1"
}


variable "app_service_name" {
    type    = string
    default = "iot-app"
}

variable "app_service_dotnet_version" {
    type    = string
    default = "v6.0"
}

variable "app_service_scm_type" {
    type    = string
    default = "LocalGit"
}


#Logic App
variable "app_service_plan_logic_app_name" {
    type    = string
    default = "iot-logic-app-service-plan"
}

variable "logic_app_name" {
    type    = string
    default = "iot-logic-app-bachelor-2022"
}


#Dashboard
variable "dashboard_name" {
    type    = string
    default = "iot-dashboard"
}
