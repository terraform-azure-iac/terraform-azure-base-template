#Iot rasbery pi simulator
#https://azure-samples.github.io/raspberry-pi-web-simulator/

/*
Resources:
- External
    - Azure Sphere (OS that can be used on the IoT device)
- IoT Edge Hub

- Ingestion
    - IoT Hub
    - Event Hub
    - Azure Digital Twins
- Hot path
    - Stream Analythics Jobs
    - HD Insight Cluster
    - Azure Data Explorer Cluster
- Cold path
    - Machine Learning
    - Azure Databricks
- Storage/data
    - Storage Account
    - Data LAke Storage
    - Azure CosmosDB
- GUI - user interface
    - App Services
    - Power BI
    - Dashboard
    - Logic Apps
    - Allerts 
*/


resource "azurerm_resource_group" "iot" {
    name        = "${var.resource_group_name}-${var.environment}"
    location    = var.location
}

resource "random_integer" "int" {
    min = 1
    max = 50000
}

resource "azurerm_iotcentral_application" "iotcentral_application" {
    name                = "${var.iotcentral_application_name}-${random_integer.int.result}"
    resource_group_name = azurerm_resource_group.iot.name
    location            = "northeurope"
    sub_domain          = var.iotcentral_application_subdomain
    sku                 = var.iotcentral_application_sku

    tags = {
        environment = var.environment
    }
}


#####################
#     Ingestion     #
#####################
#Event Hub
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace
resource "azurerm_eventhub_namespace" "eventhub_namespace" {
    name                = var.eventhub_namespace_name
    resource_group_name = azurerm_resource_group.iot.name
    location            = var.location
    sku                 = var.eventhub_namespace_sku
    capacity            = var.eventhub_namespace_capacity
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub
resource "azurerm_eventhub" "eventhub" {
    name                = var.eventhub_name
    namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
    resource_group_name = azurerm_resource_group.iot.name
    partition_count     = var.eventhub_partition_count
    message_retention   = var.eventhub_message_retention
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_authorization_rule
resource "azurerm_eventhub_authorization_rule" "eventhub_authorization_rule" {
    name                = var.eventhub_authorization_rule_name
    namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
    eventhub_name       = azurerm_eventhub.eventhub.name
    resource_group_name = azurerm_resource_group.iot.name
    listen              = true
    send                = true
    manage              = false
}

resource "azurerm_eventhub_consumer_group" "eventhub_consumer_group" {
    name                = var.eventhub_consumer_group_name
    namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
    eventhub_name       = azurerm_eventhub.eventhub.name
    resource_group_name = azurerm_resource_group.iot.name
    user_metadata       = var.eventhub_consumer_group_user_data
}

#IoT Hub
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub
resource "azurerm_iothub" "iothub" {
    name                            = var.iothub_name
    resource_group_name             = azurerm_resource_group.iot.name
    location                        = var.location
    
    event_hub_partition_count       = var.eventhub_partition_count
    event_hub_retention_in_days     = var.eventhub_message_retention
    public_network_access_enabled   = false
    sku {
        name        = var.iothub_sku_name
        capacity    = var.iothub_sku_capacity
    }
    endpoint {
        type                = "AzureIotHub.EventHub"
        name                = var.iothub_endpoint_name
        authentication_type = var.iothub_endpoint_authentication_type
        connection_string   = azurerm_eventhub_authorization_rule.eventhub_authorization_rule.primary_connection_string
    }
    route {
        name            = var.iothub_route_name
        source          = var.iothub_route_source
        endpoint_names  = [var.iothub_endpoint_name]
        enabled         = true
    }
    fallback_route {
        source          = "DeviceMessages"
        condition       = "true"
        endpoint_names  = [var.iothub_endpoint_name]
        enabled         = true
    }
    identity {
        type            = var.iothub_identity_type
        #identity_ids    =
    }
    /*ip_filter_rule {
        name    = var.iothub_ip_filter_name
        ip_mask = var.iothub_ip_filter_ip_mask
        action  = var.iothub_ip_filter_action
    }*/
    enrichment {
        key             = "tenant"
        value           = "$iothubname"
        endpoint_names  = [var.iothub_endpoint_name]
    }
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_consumer_group
resource "azurerm_iothub_consumer_group" "iothub_consumer_group" {
    name                   = var.iothub_consumer_group_name
    iothub_name            = azurerm_iothub.iothub.name
    eventhub_endpoint_name = "events"
    resource_group_name    = azurerm_resource_group.iot.name
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_shared_access_policy
resource "azurerm_iothub_shared_access_policy" "iothub_shared_access_policy" {
    name                    = var.iothub_shared_access_policy_name
    resource_group_name     = azurerm_resource_group.iot.name
    iothub_name             = azurerm_iothub.iothub.name

    registry_read           = true
    registry_write          = false
}



#Azure Digital Twins
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_instance
resource "azurerm_digital_twins_instance" "digital_twins_instance" {
    name                = var.digital_twins_instance_name
    resource_group_name = azurerm_resource_group.iot.name
    location            = "northeurope"
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_endpoint_eventhub
resource "azurerm_digital_twins_endpoint_eventhub" "digital_twins_eventhub" {
    name                                    = var.digital_twins_eventhub_name
    digital_twins_id                        = azurerm_digital_twins_instance.digital_twins_instance.id
    eventhub_primary_connection_string      = azurerm_eventhub_authorization_rule.eventhub_authorization_rule.primary_connection_string
    eventhub_secondary_connection_string    = azurerm_eventhub_authorization_rule.eventhub_authorization_rule.secondary_connection_string
}


#####################
#    Hot Path       #
#####################
#Stream Analythics Jobs
#azurerm_stream_analytics_cluster
resource "azurerm_stream_analytics_job" "stream_analytics_job" {
    name                = var.stream_analytics_job_name
    resource_group_name = azurerm_resource_group.iot.name
    location            = var.location
    compatibility_level = "1.2"
    streaming_units     = "3"
    transformation_query = <<QUERY
        SELECT *
        INTO [YourOutputAlias]
        FROM [YourInputAlias]
    QUERY
}

/*
resource "azurerm_stream_analytics_stream_input_iothub" "stream_analytics_stream_input_iothub" {
    name                            = var.stream_analytics_input_iothub_name
    resource_group_name             = azurerm_resource_group.iot.name
    stream_analytics_job_name       = azurerm_stream_analytics_job.stream_analytics_job.name
    eventhub_consumer_group_name    = "$Default"
    endpoint                        = "messages/events"
    iothub_namespace                = azurerm_iothub.iothub.name
    shared_access_policy_key        = azurerm_iothub.iothub.shared_access_policy[0].primary_key
    shared_access_policy_name       = azurerm_iothub.iothub.shared_access_policy[0].key_name
    
    serialization {
        type            = "Json"
        encoding        = "UTF8"

    }
}
*/

resource "azurerm_stream_analytics_stream_input_eventhub" "stream_analytics_stream_input_eventhub" {
    name                         = var.stream_analytics_input_eventhub_name
    stream_analytics_job_name    = azurerm_stream_analytics_job.stream_analytics_job.name
    resource_group_name          = azurerm_resource_group.iot.name
    eventhub_consumer_group_name = azurerm_eventhub_consumer_group.eventhub_consumer_group.name
    eventhub_name                = azurerm_eventhub.eventhub.name
    servicebus_namespace         = azurerm_eventhub_namespace.eventhub_namespace.name
    shared_access_policy_key     = azurerm_eventhub_namespace.eventhub_namespace.default_primary_key
    shared_access_policy_name    = "RootManageSharedAccessKey"
    
    serialization {
        type            = "Csv"
        encoding        = "UTF8"
        field_delimiter = ";" 
    }
}

#HD Insight Cluster
/*
resource "random_password" "hdinsight_password" {
    length           = 16
    special          = true
}
resource "azurerm_storage_account" "storage_account" {
    name                     = var.storage_account_hdinsight_name
    resource_group_name      = azurerm_resource_group.iot.name
    location                 = var.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storage_container" {
    name                  = var.storage_container_hdinsight_name
    storage_account_name  = azurerm_storage_account.storage_account.name
    container_access_type = "private"
}

#Kafka cluster cant be used because of the quota limit of cores that is set in the subscription
# Go in the subscritpioon settings - usage + quatas and change the number og cores/vCPU

resource "azurerm_hdinsight_kafka_cluster" "example" {
    name                            = var.hdinsight_kafka_cluster_name
    resource_group_name             = azurerm_resource_group.iot.name
    location                        = var.location
    cluster_version                 = var.hdinsight_kafka_cluster_version
    tier                            = var.hdinsight_kafka_cluster_tier
    #tls_min_version                 = "1.2"
    #encryption_in_transit_enabled   = true

    component_version {
        kafka = "2.1"
    }

    gateway {
        enabled     = true
        password    = random_password.hdinsight_password.result
        username    = var.hdinsight_kafka_cluster_username
    }

    storage_account {
        storage_container_id = azurerm_storage_container.storage_container.id
        storage_account_key  = azurerm_storage_account.storage_account.primary_access_key
        is_default           = true
    }

    roles {
        head_node {
            vm_size     = var.hdinsight_kafka_cluster_vm_size
            username    = var.hdinsight_kafka_cluster_username
            password    = random_password.hdinsight_password.result
            #ssh_keys
            #subnet_id
            #virtual_network_id
        }
        worker_node {
            vm_size                     = var.hdinsight_kafka_cluster_vm_size
            username                    = var.hdinsight_kafka_cluster_username
            password                    = random_password.hdinsight_password.result
            number_of_disks_per_node    = var.hdinsight_kafka_cluster_worker_nr_disks
            target_instance_count       = var.hdinsight_kafka_cluster_worker_count
        }
        zookeeper_node {
            vm_size     = var.hdinsight_kafka_cluster_vm_size
            username    = var.hdinsight_kafka_cluster_username
            password    = random_password.hdinsight_password.result
        }
        #kafka_management_node {
        #    vm_size     = var.hdinsight_kafka_cluster_vm_size
        #    username    = var.hdinsight_kafka_cluster_username
        #    password    = random_password.hdinsight_password.result
        #}
    }
}
*/

#HD Insight Cluster types:
#azurerm_hdinsight_hadoop_cluster
#azurerm_hdinsight_hbase_cluster
#azurerm_hdinsight_interactive_query_cluster
#azurerm_hdinsight_kafka_cluster
#azurerm_hdinsight_ml_services_cluster
#azurerm_hdinsight_rserver_cluster
#azurerm_hdinsight_spark_cluster
#azurerm_hdinsight_storm_cluster

#Azure Data Explorer 
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster
resource "azurerm_kusto_cluster" "kusto_cluster" {
    name                = var.kusto_cluster_name
    resource_group_name = azurerm_resource_group.iot.name
    location            = var.location

    sku {
        name     = var.kusto_cluster_sku_name
        capacity = var.kusto_cluster_sku_capacity
    }
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_database
resource "azurerm_kusto_database" "kusto_database" {
    name                = var.kusto_database_name
    resource_group_name = azurerm_resource_group.iot.name
    location            = var.location
    cluster_name        = azurerm_kusto_cluster.kusto_cluster.name
    
    hot_cache_period   = "P7D"
    soft_delete_period = "P31D"
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_attached_database_configuration - liten file i terraform example
#resource "azurerm_kusto_attached_database_configuration" "example" {
#}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_eventhub_data_connection
resource "azurerm_kusto_eventhub_data_connection" "eventhub_connection" {
    name                    = var.kusto_eventhub_connection_name
    location                = var.location
    resource_group_name     = azurerm_resource_group.iot.name
    cluster_name            = azurerm_kusto_cluster.kusto_cluster.name
    database_name           = azurerm_kusto_database.kusto_database.name
    
    eventhub_id             = azurerm_eventhub.eventhub.id
    consumer_group          = azurerm_eventhub_consumer_group.eventhub_consumer_group.name
    #data_format             = var.kusto_connection_data_format 
    #table_name        = "my-table"         #(Optional)
    #mapping_rule_name = "my-table-mapping" #(Optional)
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_iothub_data_connection
/*
resource "azurerm_kusto_iothub_data_connection" "iothub_connection" {
    name                        = var.kusto_iothub_connection_name
    resource_group_name         = azurerm_resource_group.iot.name
    location                    = var.location
    cluster_name                = azurerm_kusto_cluster.kusto_cluster.name
    database_name               = azurerm_kusto_database.kusto_database.name

    iothub_id                   = azurerm_iothub.iothub.id
    consumer_group              = azurerm_iothub_consumer_group.iothub_consumer_group.name
    shared_access_policy_name   = azurerm_iothub_shared_access_policy.iothub_shared_access_policy.name
    event_system_properties     = ["message-id", "sequence-number", "to"]

    table_name                  = "my-table"
    mapping_rule_name           = "my-table-mapping"
    data_format                 = var.kusto_connection_data_format
}
*/

#####################
#   Storage/Data    #
#####################
#Storage Account

resource "random_integer" "int_stor" {
    min     = 100
    max     = 999
}

resource "azurerm_storage_account" "storage_account" {
    name                     = "${var.storage_account_name}${random_integer.int_stor.result}"
    resource_group_name      = azurerm_resource_group.iot.name
    location                 = var.location
    account_tier             = var.storage_account_tier
    account_replication_type = var.storage_account_replication_type

    tags = {
        environment = var.environment
    }
}

#Data Lake Storage
resource "azurerm_storage_data_lake_gen2_filesystem" "data_lake_gen2_file" {
    name               = "example"
    storage_account_id = azurerm_storage_account.storage_account.id
}

/*
resource "azurerm_data_lake_store" "data_lake_store" {
    name                = var.data_lake_store_name
    resource_group_name = azurerm_resource_group.iot.name
    location            = "northeurope"
    encryption_state    = var.data_lake_store_encryption_state
    encryption_type     = var.data_lake_store_encryption_type
    tier                = var.data_lake_store_tier
    firewall_state      = "Enabled"
}
*/

#Azure CosmosDB


resource "azurerm_cosmosdb_account" "cosmosdb_account_iot" {
    name                = "${var.cosmosdb_account_name}${random_integer.int_stor.result}"
    location            = var.location
    resource_group_name = azurerm_resource_group.iot.name
    offer_type          = "Standard"
    enable_free_tier    = true

    capabilities {
        name    = "EnableTable"
        #name    = "EnableCassandra"
    }

    geo_location {
        location            = var.location
        failover_priority   = 0
    }

    consistency_policy {
        consistency_level       = "BoundedStaleness"
        max_interval_in_seconds = 300
        max_staleness_prefix    = 100000
    }
    
    backup {
        type                = "Periodic"
        interval_in_minutes = 180
        retention_in_hours  = 24
        storage_redundancy  = "Local"
    }
}

resource "azurerm_cosmosdb_table" "cosmosdb_table" {
    name                = var.cosmosdb_table_name
    resource_group_name = azurerm_resource_group.iot.name
    account_name        = azurerm_cosmosdb_account.cosmosdb_account_iot.name
    throughput          = var.cosmosdb_table_throughput
}

/*
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_cassandra_keyspace
resource "azurerm_cosmosdb_cassandra_keyspace" "cassandra_keyspace" {
    name                = var.cosmosdb_cassandra_keyspace_name
    resource_group_name = azurerm_resource_group.iot.name
    account_name        = azurerm_cosmosdb_account.cosmosdb_account_iot.name
    throughput          = var.cosmosdb_cassandra_keyspace_throughput
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_cassandra_table
resource "azurerm_cosmosdb_cassandra_table" "cassandra_table" {
    name                  = var.cosmosdb_cassandra_table_name
    cassandra_keyspace_id = azurerm_cosmosdb_cassandra_keyspace.cassandra_keyspace.id

    schema {
        column {
        name = "test1"
        type = "ascii"
        }

        column {
        name = "test2"
        type = "int"
        }

        partition_key {
        name = "test1"
        }
    }
}*/





#####################
#    Cold Path      #
#####################

resource "azurerm_application_insights" "application_insights" {
    name                = var.application_insight_name
    resource_group_name = azurerm_resource_group.iot.name
    location            = var.location
    application_type    = var.application_insight_type
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
    name                = var.key_vault_name
    resource_group_name = azurerm_resource_group.iot.name
    location            = var.location
    sku_name            = var.key_vault_sku
    tenant_id           = data.azurerm_client_config.current.tenant_id
}


resource "random_password" "ml_password" {
    length           = 16
    special          = true
} 

#Networking
resource "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name
    resource_group_name = azurerm_resource_group.iot.name
    location            = var.ml_location
    address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "subnet" {
    name                 = var.subnet_name
    resource_group_name  = azurerm_resource_group.iot.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = var.subnet_address_prefixes
}

#Machine Learning
resource "azurerm_machine_learning_workspace" "ml_workspace" {
    name                    = var.ml_workspace_name
    location                = var.ml_location
    resource_group_name     = azurerm_resource_group.iot.name
    application_insights_id = azurerm_application_insights.application_insights.id
    key_vault_id            = azurerm_key_vault.key_vault.id
    storage_account_id      = azurerm_storage_account.storage_account.id

    identity {
        type = "SystemAssigned"
    }
}

resource "azurerm_machine_learning_compute_instance" "ml_compute_instance" {
    name                            = var.ml_compute_instance_name
    location                        = var.ml_location
    machine_learning_workspace_id   = azurerm_machine_learning_workspace.ml_workspace.id
    virtual_machine_size            = var.ml_compute_instance_vm
    authorization_type              = "personal"
    subnet_resource_id              = azurerm_subnet.subnet.id
    description                     = "base template ML compute instance"
    /*
    ssh {
        public_key = var.ml_ssh_key
    }
    */
    tags = {
        environment = var.environment
    }
}

resource "azurerm_machine_learning_compute_cluster" "ml_compute_cluster" {
    name                            = var.ml_compute_cluster_name
    location                        = var.ml_location
    vm_priority                     = var.ml_compute_cluster_vm_pri
    vm_size                         = var.ml_compute_cluster_vm
    machine_learning_workspace_id   = azurerm_machine_learning_workspace.ml_workspace.id
    subnet_resource_id              = azurerm_subnet.subnet.id
    description                     = "base template ML compute cluster"
    
    scale_settings {
        min_node_count                       = 0
        max_node_count                       = 1
        scale_down_nodes_after_idle_duration = var.ml_compute_cluster_scale_down
    }

    identity {
        type = "SystemAssigned"
    }

    /*
    ssh {
        admin_username  = "ml-cluster-admin"
        admin_password  = random_password.ml_password.result
        key_value       = var.ml_ssh_key
    }
    */
}


#Azure Databricks
resource "azurerm_databricks_workspace" "databricks_workspace" {
    name                = var.databricks_workspace_name
    resource_group_name = azurerm_resource_group.iot.name
    location            = var.location
    sku                 = "standard"
}





#####################
#  User Interface   #
#####################
#PowerBI
/*
resource "azurerm_powerbi_embedded" "powerbi" {
    name                = var.powerbi_embedded_name
    resource_group_name = azurerm_resource_group.iot.name
    location            = var.location
    sku_name            = var.powerbi_embedded_sku
    administrators      = var.powerbi_embedded_admins
}
*/

#App Service
resource "azurerm_app_service_plan" "app_service_plan" {
    name                = var.app_service_plan_name
    location            = var.location
    resource_group_name = azurerm_resource_group.iot.name

    sku {
        tier = var.app_service_plan_sku_tier
        size = var.app_service_plan_sku_size
    }
}

resource "azurerm_app_service" "app_service" {
    name                = var.app_service_name
    location            = var.location
    resource_group_name = azurerm_resource_group.iot.name
    app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

    site_config {
        dotnet_framework_version = "v6.0"
        scm_type                 = "LocalGit"
    }
}


#Logic App
resource "azurerm_app_service_plan" "app_service_plan_logic_app" {
    name                = var.app_service_plan_logic_app_name
    location            = var.location
    resource_group_name = azurerm_resource_group.iot.name
    kind                = "Linux"
    reserved            = true

    sku {
        tier = "WorkflowStandard"
        size = "WS1"
    }
}

resource "azurerm_logic_app_standard" "example" {
    name                       = var.logic_app_name
    location                   = var.location
    resource_group_name        = azurerm_resource_group.iot.name
    app_service_plan_id        = azurerm_app_service_plan.app_service_plan_logic_app.id
    storage_account_name       = azurerm_storage_account.storage_account.name
    storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
}

#Allerts

/*
#Dashboard
#Do we need Dashboard when we have App and PowerBI
resource "azurerm_dashboard" "dashboard" {
    name                = var.dashboard_name
    resource_group_name = azurerm_resource_group.iot.name
    location            = var.location

    #Some JSON data 
    #(Required) JSON data representing dashboard body. See above for details on how to obtain this from the Portal.
    #This JSON data is exported from the Basic Dashboard in Azure
    dashboard_properties = <<DASH
        {
        "properties": {
            "lenses": {
            "0": {
                "order": 0,
                "parts": {
                "0": {
                    "position": {
                    "x": 0,
                    "y": 0,
                    "colSpan": 4,
                    "rowSpan": 6
                    },
                    "metadata": {
                    "inputs": [
                        {
                        "name": "resourceType",
                        "value": "Microsoft.Resources/resources"
                        }
                    ],
                    "type": "Extension/HubsExtension/PartType/BrowseAllResourcesPinnedPart",
                    "viewState": {
                        "content": {
                        "selectableData": {
                            "activatedItems": [],
                            "selectedItems": []
                        }
                        }
                    }
                    }
                },
                "1": {
                    "position": {
                    "x": 0,
                    "y": 6,
                    "colSpan": 2,
                    "rowSpan": 1
                    },
                    "metadata": {
                    "inputs": [],
                    "type": "Extension/HubsExtension/PartType/ServicesHealthPart"
                    }
                },
                "2": {
                    "position": {
                    "x": 4,
                    "y": 0,
                    "colSpan": 4,
                    "rowSpan": 2
                    },
                    "metadata": {
                    "inputs": [],
                    "type": "Extension/HubsExtension/PartType/AzureProjectGettingStartedPart"
                    }
                },
                "3": {
                    "position": {
                    "x": 4,
                    "y": 2,
                    "colSpan": 4,
                    "rowSpan": 5
                    },
                    "metadata": {
                    "inputs": [],
                    "type": "Extension/HubsExtension/PartType/GettingStartedPart"
                    }
                },
                "4": {
                    "position": {
                    "x": 2,
                    "y": 6,
                    "colSpan": 2,
                    "rowSpan": 1
                    },
                    "metadata": {
                    "inputs": [
                        {
                        "name": "selectedMenuItemId",
                        "value": "",
                        "isOptional": true
                        }
                    ],
                    "type": "Extension/HubsExtension/PartType/GalleryTile"
                    }
                }
                }
            }
            },
            "metadata": {
            "model": {}
            }
        },
        "name": "My Dashboard",
        "type": "Microsoft.Portal/dashboards",
        "location": "INSERT LOCATION",
        "tags": {
            "hidden-title": "My Dashboard"
        },
        "apiVersion": "2015-08-01-preview"
        }
    DASH
}
*/
