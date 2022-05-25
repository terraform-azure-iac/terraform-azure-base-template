resource "azurerm_resource_group" "web_page" {
    name        = "${var.resource_group_name}-${var.environment}"
    location    = var.location
}

/*
#DDos Protection plan is a high cost service (ca. 25 000kr/month)
resource "azurerm_network_ddos_protection_plan" "ddos_protection_plan" {
    name                = "example-protection-plan"
    location            = var.location
    resource_group_name = azurerm_resource_group.web_page.name
}
*/

resource "azurerm_web_application_firewall_policy" "waf_policy" {
    name                = var.web_application_firewall_policy_name
    resource_group_name = azurerm_resource_group.web_page.name
    location            = var.location
/*
    custom_rules {
        name                = "waf-web-page-custom-rule"
        priority            = 100
        rule_type           = "MatchRule"   # or RateLimitRule
        match_conditions {
            match_variables {

            }
            match_values    =
            operator        =
        }
        action              = "Block"
    }
*/
    policy_settings {
        enabled                     = true
        mode                        = "Prevention" 
        request_body_check          = true
        file_upload_limit_in_mb     = 400
        max_request_body_size_in_kb = 128
    }

    managed_rules {
        managed_rule_set {
        type    = "OWASP"       #Microsoft_BotManagerRuleSet or OWASP
        version = "3.2"
        #rule_group_override {}
        }
    }
}
/*
resource "azurerm_public_ip" "public_ip_app_gateway" {
    name                = "public-ip-app-gateway"
    resource_group_name = azurerm_resource_group.web_page.name
    location            = var.location
    allocation_method   = "Static"
}


locals {
    backend_address_pool_name      = "${azurerm_virtual_network.vnet.name}-beap"
    frontend_port_name             = "${azurerm_virtual_network.vnet.name}-feport"
    frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feip"
    http_setting_name              = "${azurerm_virtual_network.vnet.name}-be-htst"
    listener_name                  = "${azurerm_virtual_network.vnet.name}-httplstn"
    request_routing_rule_name      = "${azurerm_virtual_network.vnet.name}-rqrt"
    redirect_configuration_name    = "${azurerm_virtual_network.vnet.name}-rdrcfg"
}

resource "azurerm_application_gateway" "application_gateway" {
    name                = "web-page-appgateway"
    resource_group_name = azurerm_resource_group.web_page.name
    location            = var.location

    firewall_policy_id  = azurerm_web_application_firewall_policy.waf_policy.id

    sku {
        name     = "Standard_Small"
        tier     = "Standard"
        capacity = 1
    }

    gateway_ip_configuration {
        name      = "app-gateway-ip-configuration"
        subnet_id = azurerm_subnet.subnet["application-gateway-subnet"].id
    }

    frontend_port {
        name = "app-gate-frontend-port"
        port = 80
    }

    frontend_ip_configuration {
        name                 = local.frontend_ip_configuration_name
        public_ip_address_id = azurerm_public_ip.public_ip_app_gateway.id
    }

    backend_address_pool {
        name = local.backend_address_pool_name
    }

    backend_http_settings {
        name                  = local.http_setting_name
        cookie_based_affinity = "Disabled"
        path                  = "/path1/"
        port                  = 80
        protocol              = "Http"
        request_timeout       = 60
    }

    http_listener {
        name                           = local.listener_name
        frontend_ip_configuration_name = local.frontend_ip_configuration_name
        frontend_port_name             = local.frontend_port_name
        protocol                       = "Https"
    }

    request_routing_rule {
        name                       = local.request_routing_rule_name
        rule_type                  = "Basic"
        http_listener_name         = local.listener_name
        backend_address_pool_name  = local.backend_address_pool_name
        backend_http_settings_name = local.http_setting_name
    }
}
*/

resource "azurerm_cdn_profile" "cdn_profile" {
    name                = var.cdn_profile_name
    location            = "northeurope"
    resource_group_name = azurerm_resource_group.web_page.name
    sku                 = var.cdn_profile_sku

    tags = {
        environment = var.environment
    }
}

resource "azurerm_cdn_endpoint" "example" {
    name                = var.cdn_endpoint_name
    profile_name        = azurerm_cdn_profile.cdn_profile.name
    location            = "northeurope"
    resource_group_name = azurerm_resource_group.web_page.name
    is_http_allowed     = false
    is_https_allowed     = true
    optimization_type   = var.cdn_endpoint_optimazation

    origin {
        name      = "cdn-origin"
        host_name = azurerm_app_service.app_service.default_site_hostname
    }
}


resource "azurerm_network_security_group" "network_security_group" {
    name                = var.network_security_group_name
    location            = var.location
    resource_group_name = azurerm_resource_group.web_page.name

    security_rule {
        name                        = var.network_security_rule_name
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "*"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
        access                      = "Allow"
        priority                    = 100
        direction                   = "Inbound"
    }
}

resource "azurerm_virtual_network" "vnet" {
    resource_group_name     = azurerm_resource_group.web_page.name
    location                = var.location
    name                    = var.virtual_network_name
    address_space           = var.address_space

    depends_on              = [azurerm_resource_group.web_page]
/*
#DDos Protection plan is a high cost service (ca. 25 000kr/month)
    ddos_protection_plan {
        id      = azurerm_network_ddos_protection_plan.ddos_protection_plan.id
        enabled = true
    }
*/
}

resource "azurerm_subnet" "subnet" {
    for_each                = var.subnet
    resource_group_name     = azurerm_resource_group.web_page.name
    virtual_network_name    = azurerm_virtual_network.vnet.name
    name                    = each.key
    address_prefixes        = each.value
    #Service endpoint for SQL "Microsoft.sql",CosmosDB ("Microsoft.AzureCosmosDB"),App Service ("Microsoft.Web")
    #https://docs.microsoft.com/nb-no/azure/virtual-network/virtual-network-service-endpoints-overview
    #https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
    #enforce_private_link_endpoint_network_policies = true
    service_endpoints        = ["Microsoft.Web", "Microsoft.sql", "Microsoft.AzureCosmosDB"]
    delegation {
        name    = "subnet-delegation"
        service_delegation {
            name    = "Microsoft.Web/serverFarms"
            actions  = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        }
    }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
    subnet_id                 = azurerm_subnet.subnet["database-subnet"].id
    network_security_group_id = azurerm_network_security_group.network_security_group.id
}

resource "azurerm_virtual_network" "vnet2" {
    resource_group_name     = azurerm_resource_group.web_page.name
    location                = var.location
    name                    = "${var.virtual_network_name}2"
    address_space           = var.address_space

    depends_on              = [azurerm_resource_group.web_page]

    subnet {
        name                = "subnet-name"
        address_prefix      = "10.0.1.0/24"
        security_group      = azurerm_network_security_group.network_security_group.id
    }
/*
    ddos_protection_plan {
        id      = azurerm_network_ddos_protection_plan.ddos_protection_plan.id
        enabled = true
    }
*/
}



#App service + Application Insight
resource "azurerm_app_service_plan" "app_service_plan" {
    name                = var.app_service_plan_name
    location            = var.location
    resource_group_name = azurerm_resource_group.web_page.name
    kind                = "Windows"               

    sku {
        tier = var.app_service_plan_sku_tier
        size = var.app_service_plan_sku_size
    }
}

resource "azurerm_application_insights" "application_insights" {
    name                = var.application_insights_name
    location            = var.location
    resource_group_name = azurerm_resource_group.web_page.name
    application_type    = var.application_insights_type
}

resource "azurerm_application_insights_smart_detection_rule" "smart_detection_rule" {
    name                                = "Slow page load time"
    application_insights_id             = azurerm_application_insights.application_insights.id
    enabled                             = true
    send_emails_to_subscription_owners  = false
    #additional_email_reciptionts        = var.application_insights_smart_detection_rule_email
}


#Posible to use the new Web APP or Static Web app?
#Configure based on needs
resource "azurerm_app_service" "app_service" {
    name                = var.app_service_name
    location            = var.location
    resource_group_name = azurerm_resource_group.web_page.name
    app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

    #connects app service to the application insight
    app_settings = {
        "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.application_insights.instrumentation_key
        "MSSQLDB_URL"   = azurerm_cosmosdb_account.cosmosdb_account.connection_strings[0]
        "REDIS_HOST"    = azurerm_redis_cache.redis_cache.primary_connection_string
        "REDIS_PASSWORD" = azurerm_redis_cache.redis_cache.primary_access_key
    }
    #Managed Identity
    identity {
        type    = "SystemAssigned"
    }
    enabled = true
    https_only  = false
    
    site_config {
        dotnet_framework_version    = "v4.0"
        ftps_state      = var.app_service_ftps_state

        min_tls_version = "1.2"
        php_version     = "7.4"

    }
    
    /*
    connection_string {
        name    = "${var.app_service_connection_string_name}-redis"
        type    = "RedisCache"
        value   = "Server=${azurerm_redis_cache.redis.hostname}"
    }
    connection_string {
        name    = "${var.app_service_connection_string_name}-sql-azure"
        type    = "SQLAzure"
        value   = "Server=some-server.mydomain.com;Integrated Security=SSPI"
    }
    */


    
    /*
    source_control {
        repo_url    = "https://github.com/Azure-Samples/php-docs-hello-world"
        branch      = "master"
    }
    
    logs {
        applcation_logs {
            azure_blob_storage {
                level               = 
                sas_url             = 
                retention_in_days   = 
            }
            file_system_level = 
        }
        http_logs {
            azure_blob_storage {
                sas_url             = 
                retention_in_days   = 365
            }
        }
        detailed_error_messages_enabled = false
        failed_request_tracing_enabled  = false
    }
    */
    
    #auth_settings {}
    /*
    backup {
        name                =
        enabled             = true
        storage_account_url =
        schedule {
            frequency_interval
            frequency_unit
            keep_at_least_one_backup
            retention_period_in_days
            start_time
        }
    }
    */
    
    #storage_account {}
}

#Connect App Service to a Vnet and Subnet with vnet-integration
resource "azurerm_app_service_virtual_network_swift_connection" "example" {
    app_service_id = azurerm_app_service.app_service.id
    subnet_id      = azurerm_subnet.subnet["app-service-subnet"].id
}


#Static Web site
/*
resource "azurerm_static_site" "static_site_webpage"{
    name                = var.static_site_name
    resource_group_name = azurerm_resource_group.web_page.name
    location            = "West Europe"
    sku_tier            = var.static_site_sku_tier
    sku_size            = var.static_site_sku_size
}
*/

#MsSQL server & database
resource "random_password" "password" {
    length           = 16
    special          = true
}

resource "azurerm_mssql_server" "mssql_server" {
    name                            = var.mssql_server_name
    location                        = var.location
    resource_group_name             = azurerm_resource_group.web_page.name
    version                         = var.mssql_server_version
    administrator_login             = var.mssql_server_admin_login
    administrator_login_password    = random_password.password.result

    tags = {
        enviroment = var.environment
    }
}

resource "azurerm_mssql_virtual_network_rule" "mssql_vnet_rule" {
    name        = "sql-vnet-rule"
    server_id   = azurerm_mssql_server.mssql_server.id
    subnet_id   = azurerm_subnet.subnet["database-subnet"].id
    
    ignore_missing_vnet_service_endpoint = true
}

resource "azurerm_mssql_database" "mssql_database" {
    name        = var.mssql_database_name
    server_id   = azurerm_mssql_server.mssql_server.id
    
    long_term_retention_policy {
        weekly_retention    = "P4W"
        monthly_retention   = "P6M"
        yearly_retention    = "P3Y"
        week_of_year        = "5"
    }
}


#Cosmos DB
resource "random_integer" "int" {
    min     = 100
    max     = 999
}


resource "azurerm_cosmosdb_account" "cosmosdb_account" {
    name                = "${var.cosmosdb_account_name}-${random_integer.int.result}"
    location            = var.location
    resource_group_name = azurerm_resource_group.web_page.name
    offer_type          = "Standard"
    enable_free_tier    = true
    #ip_range_filter     = data.azurerm_subnet.subnet_app_service.address_prefixes
    #virtual_network_rule {
    #    id  = data.azurerm_subnet.subnet_app_service.id
    #}
    consistency_policy {
        consistency_level       = "BoundedStaleness"
        max_interval_in_seconds = 300
        max_staleness_prefix    = 100000
    }
    geo_location {
        location            = var.location
        failover_priority   = 0
    }
    backup {
        type                = "Periodic"
        interval_in_minutes = 240
        retention_in_hours  = 12
        storage_redundancy  = "Local"
    }
    is_virtual_network_filter_enabled = true
    virtual_network_rule {
        id                                   = azurerm_subnet.subnet["database-subnet"].id
        ignore_missing_vnet_service_endpoint = true
    }
}

resource "azurerm_cosmosdb_sql_database" "cosmosdb_sql_database" {
    name                    = var.cosmosdb_sql_database_name
    resource_group_name     = azurerm_resource_group.web_page.name
    account_name            = azurerm_cosmosdb_account.cosmosdb_account.name
    throughput              = 400
}

#Redis Cache
resource "azurerm_redis_cache" "redis_cache" {
    name                    = "${var.redis_cache_name}"
    location                = var.location
    resource_group_name     = azurerm_resource_group.web_page.name
    capacity                = var.redis_cache_capacity
    family                  = var.redis_cache_family
    sku_name                = var.redis_cache_sku_name

    #Subnet can only be activated with premium SKU. and the subnet can only contain Azure cache for redis
    #subnet_id               = 
}









############################################################################
#Private endpoints to add resources to subnets
/*
resource "azurerm_private_endpoint" "private_endpoint_app" {
    name                = "app-service-endpoint"
    location            = var.location
    resource_group_name = azurerm_resource_group.web_page.name
    subnet_id           = azurerm_subnet.subnet["app-service-subnet"].id

    private_service_connection {
        name                           = "app-service-connection"
        private_connection_resource_id = azurerm_app_service.app_service.id
        is_manual_connection           = false
    }
}

resource "azurerm_private_endpoint" "private_endpoint_cosmosdb" {
    name                = "cosmosdb-endpoint"
    location            = var.location
    resource_group_name = azurerm_resource_group.web_page.name
    subnet_id           = azurerm_subnet.subnet["database-subnet"].id

    private_service_connection {
        name                           = "cosmosdb-service-connection"
        private_connection_resource_id = azurerm_cosmosdb_sql_database.cosmosdb_sql_database.id
        is_manual_connection           = false
    }
}

resource "azurerm_private_endpoint" "private_endpoint_redis" {
    name                = "redis-endpoint"
    location            = var.location
    resource_group_name = azurerm_resource_group.web_page.name
    subnet_id           = azurerm_subnet.subnet["redis-cache-subnet"].id

    private_service_connection {
        name                           = "redis_service-connection"
        private_connection_resource_id = azurerm_redis_cache.redis_cache.id
        is_manual_connection           = false
    }
}
*/