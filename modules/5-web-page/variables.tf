variable "environment" {
    type    = string
    default = ""
}

variable "resource_group_name" {
    type    = string
    default = "web-page"
} 

variable "location" {
    type    = string
    default = "norwayeast"
}

#Virtual Network Variables
variable "virtual_network_name" {
    type    = string
    default = "Web-Page-vnet"
}

variable "address_space" {
    type    = list(string)
    default = ["10.0.0.0/16"]
}

#subnet Variables
variable "subnet" {
    type    = map
    default = {
        "app-service-subnet"            = ["10.0.1.0/24"]
        "database-subnet"               = ["10.0.2.0/24"]
        "redis-cache-subnet"            = ["10.0.3.0/24"]
        "application-gateway-subnet"    = ["10.0.4.0/24"]
    }
}

#Contetn Delivery Network - CDN
variable "cdn_profile_name" {
    type    = string
    default = "cdn-profile-web-page"
}

variable "cdn_profile_sku" {
    type    = string
    default = "Standard_Microsoft"
}

variable "cdn_endpoint_name" {
    type    = string
    default = "cdn-endpoint-web-page"
}

variable "cdn_endpoint_optimazation" {
    type    = string
    default = "GeneralWebDelivery"
}

#Network Security group
variable "network_security_group_name" {
    type        = string
    default     = "nsg-web-page"
}

variable "network_security_rule_name" {
    type        = string
    default     = "nsg-rule-web-page"
}

variable "web_application_firewall_policy_name" {
    type    = string
    default = "wafpolicy-web-page"
}


#App service plan
variable "app_service_plan_name" {
    type        = string
    default     = "appservice-plan"
}

variable "app_service_plan_sku_tier" {
    type        = string
    default     = "Standard"
                        #"Basic"
}

variable "app_service_plan_sku_size" {
    type        = string
    default     = "S1"
                        #"B1"
}


#App service
variable "app_service_name" {
    type        = string
    default     = "bachelor-2022-web-page-app-service"
}

variable "app_service_connection_string_name" {
    type        = string
    default     = "app-service-conection-string-name"
}

variable "app_service_php_version" {
    type    = string
    default = "7.4"
}

variable "app_service_tls_version" {
    type    = string
    default = "1.2"
}

variable "app_service_dotnet_framework_version" {
    type    = string    
    default = "v4.0"
}

variable "app_service_ftps_state" {
    type    = string
    default = "Disabled"
}


#Static Web site
variable "static_site_name" {
    type    = string
    default = "bachelor-2022-static-website"
}

variable "static_site_sku_tier" {
    type    = string
    default = "Free"
}

variable "static_site_sku_size" {
    type    = string
    default = "Standard"
}

#SQL server
variable "mssql_server_name" {
    type    = string
    default = "bachelor-2022-web-page-sql-server"
}

variable "mssql_server_version" {
    type    = string
    default = "12.0"
}

variable "mssql_server_admin_login" {
    type    = string
    default = "mssqladmin"
}

#SQL Database
variable "mssql_database_name" {
    type    = string
    default = "mssql-db-web-page"
}



#Redis Cache
variable "redis_cache_name" {
    type        = string
    default     = "redis-cache-web-page"
}

variable "redis_cache_capacity" {
    type        = number
    default     = 0
}

variable "redis_cache_family" {
    type        = string
    default     = "C"
}

variable "redis_cache_sku_name" {
    type        = string
    default     = "Basic"
}


#Cosmos DB
variable "cosmosdb_account_name" {
    type    = string
    default = "bachelor-2022-cosmosdb-account"
}

variable "cosmosdb_sql_database_name" {
    type    = string
    default = "bachelor-2022-cosmosdb-sql-db-web-page"
}

variable "cosmosdb_sql_container_name" {
    type    = string
    default = "bachelor-2022-cosmosdb-sql-container-web-page"
}


#Application Insight
variable "application_insights_name" {
    type    = string
    default = "application-insight-web-page"
}

variable "application_insights_type" {
    type    = string
    default = "web"
    description = "Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created."
}

#Application Insight smart detection rule
variable "application_insights_smart_detection_rule_email" {
    type        = list
    default     = ["test1@test.com", "test2@test.com"]
    description = "Memebers reciving email incase of preformance issues"
}



#Application Gateway 
variable "ddos_protection_plan_name" {
    type    = string
    default = "ddos-protection-plan-web-page"
}


