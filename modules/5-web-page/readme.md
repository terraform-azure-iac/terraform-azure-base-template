# Azure Budget Management

Provisons in infrastructure for a web page. It uses App service for deployment of the web page and either a MsSQL database or CosmomsDB for database storage and with redis cache for caching either for the databsae or the web page, or both.....



![5-web-page.png](/img/5-web-page.png)


## Configure Module

- Naming for resources (AppService, Network componenets, database)
- Location 
- Tier, Size, sku and Version of the resources
- Application Insight - application type (ios, java, MobileCenter, Node.JS, other, phone, store and web)
- MsSQL retention policy, how long you would like to keep the diferent backups, [Micorsoft docs](https://docs.microsoft.com/en-us/azure/azure-sql/database/long-term-retention-overview) 
- App Service
- Email address recivers
- Rule Configuration

#### Launch you web page
One option is to: Deploy the php web page from GitHub based on [Micosoft docs](https://docs.microsoft.com/nb-no/azure/app-service/quickstart-php?pivots=platform-windows#code-try-9), or you can deploy it using [ASP.NET](https://docs.microsoft.com/nb-no/azure/app-service/quickstart-dotnetcore?tabs=net60&pivots=development-environment-vs), [Java](https://docs.microsoft.com/nb-no/azure/app-service/quickstart-java?tabs=javase&pivots=platform-windows), [Node.js](https://docs.microsoft.com/nb-no/azure/app-service/quickstart-nodejs?tabs=windows&pivots=development-environment-vscode) or [Python](https://docs.microsoft.com/nb-no/azure/app-service/quickstart-python?tabs=flask%2Cwindows%2Cazure-portal%2Cterminal-bash%2Cvscode-deploy%2Cdeploy-instructions-azportal%2Cdeploy-instructions-zip-azcli) and more.

### Module Usage

*/main.tf*

```
module "web-page" {
  source                = "./modules/5-web-page"
}
```

----------------------------------------------------
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
| [azurerm_app_service_virtual_network_swift_connection.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_application_insights_smart_detection_rule.smart_detection_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_smart_detection_rule) | resource |
| [azurerm_cdn_endpoint.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_endpoint) | resource |
| [azurerm_cdn_profile.cdn_profile](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_profile) | resource |
| [azurerm_cosmosdb_account.cosmosdb_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |
| [azurerm_cosmosdb_sql_database.cosmosdb_sql_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_database) | resource |
| [azurerm_mssql_database.mssql_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |
| [azurerm_mssql_server.mssql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_mssql_virtual_network_rule.mssql_vnet_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_network_rule) | resource |
| [azurerm_network_security_group.network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_redis_cache.redis_cache](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |
| [azurerm_resource_group.web_page](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.nsg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.vnet2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_web_application_firewall_policy.waf_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy) | resource |
| [random_integer.int](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

### Inputs

| Name | Description | Type | Default | Should Default be changed? |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | n/a | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | yes |
| <a name="input_app_service_connection_string_name"></a> [app\_service\_connection\_string\_name](#input\_app\_service\_connection\_string\_name) | n/a | `string` | `"app-service-conection-string-name"` | yes |
| <a name="input_app_service_dotnet_framework_version"></a> [app\_service\_dotnet\_framework\_version](#input\_app\_service\_dotnet\_framework\_version) | n/a | `string` | `"v4.0"` | no |
| <a name="input_app_service_ftps_state"></a> [app\_service\_ftps\_state](#input\_app\_service\_ftps\_state) | n/a | `string` | `"Disabled"` | no |
| <a name="input_app_service_name"></a> [app\_service\_name](#input\_app\_service\_name) | App service | `string` | `"bachelor-2022-web-page-app-service"` | yes |
| <a name="input_app_service_php_version"></a> [app\_service\_php\_version](#input\_app\_service\_php\_version) | n/a | `string` | `"7.4"` | no |
| <a name="input_app_service_plan_name"></a> [app\_service\_plan\_name](#input\_app\_service\_plan\_name) | App service plan | `string` | `"appservice-plan"` | yes |
| <a name="input_app_service_plan_sku_size"></a> [app\_service\_plan\_sku\_size](#input\_app\_service\_plan\_sku\_size) | n/a | `string` | `"S1"` | no |
| <a name="input_app_service_plan_sku_tier"></a> [app\_service\_plan\_sku\_tier](#input\_app\_service\_plan\_sku\_tier) | n/a | `string` | `"Standard"` | no |
| <a name="input_app_service_tls_version"></a> [app\_service\_tls\_version](#input\_app\_service\_tls\_version) | n/a | `string` | `"1.2"` | no |
| <a name="input_application_insights_name"></a> [application\_insights\_name](#input\_application\_insights\_name) | Application Insight | `string` | `"application-insight-web-page"` | yes |
| <a name="input_application_insights_smart_detection_rule_email"></a> [application\_insights\_smart\_detection\_rule\_email](#input\_application\_insights\_smart\_detection\_rule\_email) | Memebers reciving email incase of preformance issues | `list` | <pre>[<br>  "test1@test.com",<br>  "test2@test.com"<br>]</pre> | yes |
| <a name="input_application_insights_type"></a> [application\_insights\_type](#input\_application\_insights\_type) | Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created. | `string` | `"web"` | no |
| <a name="input_cdn_endpoint_name"></a> [cdn\_endpoint\_name](#input\_cdn\_endpoint\_name) | n/a | `string` | `"cdn-endpoint-web-page"` | yes |
| <a name="input_cdn_endpoint_optimazation"></a> [cdn\_endpoint\_optimazation](#input\_cdn\_endpoint\_optimazation) | n/a | `string` | `"GeneralWebDelivery"` | no |
| <a name="input_cdn_profile_name"></a> [cdn\_profile\_name](#input\_cdn\_profile\_name) | Contetn Delivery Network - CDN | `string` | `"cdn-profile-web-page"` | yes |
| <a name="input_cdn_profile_sku"></a> [cdn\_profile\_sku](#input\_cdn\_profile\_sku) | n/a | `string` | `"Standard_Microsoft"` | no |
| <a name="input_cosmosdb_account_name"></a> [cosmosdb\_account\_name](#input\_cosmosdb\_account\_name) | Cosmos DB | `string` | `"bachelor-2022-cosmosdb-account"` | yes |
| <a name="input_cosmosdb_sql_container_name"></a> [cosmosdb\_sql\_container\_name](#input\_cosmosdb\_sql\_container\_name) | n/a | `string` | `"bachelor-2022-cosmosdb-sql-container-web-page"` | yes |
| <a name="input_cosmosdb_sql_database_name"></a> [cosmosdb\_sql\_database\_name](#input\_cosmosdb\_sql\_database\_name) | n/a | `string` | `"bachelor-2022-cosmosdb-sql-db-web-page"` | yes |
| <a name="input_ddos_protection_plan_name"></a> [ddos\_protection\_plan\_name](#input\_ddos\_protection\_plan\_name) | Application Gateway | `string` | `"ddos-protection-plan-web-page"` | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"norwayeast"` | no |
| <a name="input_mssql_database_name"></a> [mssql\_database\_name](#input\_mssql\_database\_name) | SQL Database | `string` | `"mssql-db-web-page"` | yes |
| <a name="input_mssql_server_admin_login"></a> [mssql\_server\_admin\_login](#input\_mssql\_server\_admin\_login) | n/a | `string` | `"mssqladmin"` | yes |
| <a name="input_mssql_server_name"></a> [mssql\_server\_name](#input\_mssql\_server\_name) | SQL server | `string` | `"bachelor-2022-web-page-sql-server"` | yes |
| <a name="input_mssql_server_version"></a> [mssql\_server\_version](#input\_mssql\_server\_version) | n/a | `string` | `"12.0"` | no |
| <a name="input_network_security_group_name"></a> [network\_security\_group\_name](#input\_network\_security\_group\_name) | Network Security group | `string` | `"nsg-web-page"` | yes |
| <a name="input_network_security_rule_name"></a> [network\_security\_rule\_name](#input\_network\_security\_rule\_name) | n/a | `string` | `"nsg-rule-web-page"` | yes |
| <a name="input_redis_cache_capacity"></a> [redis\_cache\_capacity](#input\_redis\_cache\_capacity) | n/a | `number` | `0` | no |
| <a name="input_redis_cache_family"></a> [redis\_cache\_family](#input\_redis\_cache\_family) | n/a | `string` | `"C"` | no |
| <a name="input_redis_cache_name"></a> [redis\_cache\_name](#input\_redis\_cache\_name) | Redis Cache | `string` | `"redis-cache-web-page"` | yes |
| <a name="input_redis_cache_sku_name"></a> [redis\_cache\_sku\_name](#input\_redis\_cache\_sku\_name) | n/a | `string` | `"Basic"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `"web-page"` | yes |
| <a name="input_static_site_name"></a> [static\_site\_name](#input\_static\_site\_name) | Static Web site | `string` | `"bachelor-2022-static-website"` | yes |
| <a name="input_static_site_sku_size"></a> [static\_site\_sku\_size](#input\_static\_site\_sku\_size) | n/a | `string` | `"Standard"` | no |
| <a name="input_static_site_sku_tier"></a> [static\_site\_sku\_tier](#input\_static\_site\_sku\_tier) | n/a | `string` | `"Free"` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | subnet Variables | `map` | <pre>{<br>  "app-service-subnet": [<br>    "10.0.1.0/24"<br>  ],<br>  "application-gateway-subnet": [<br>    "10.0.4.0/24"<br>  ],<br>  "database-subnet": [<br>    "10.0.2.0/24"<br>  ],<br>  "redis-cache-subnet": [<br>    "10.0.3.0/24"<br>  ]<br>}</pre> | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | Virtual Network Variables | `string` | `"Web-Page-vnet"` | yes |
| <a name="input_web_application_firewall_policy_name"></a> [web\_application\_firewall\_policy\_name](#input\_web\_application\_firewall\_policy\_name) | n/a | `string` | `"wafpolicy-web-page"` | yes |




-----------------------------------------------------

## References:
Link to the Azure resource can be found in the [Resources table](#resources). By clicking on the name of the resource you will be sent to the HashiCorps Terraform documentation/registry for that resource.

Micorsoft Documenation:
- [Manage Azure resource groups by using the Azure portal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal)
- [App Service documentation](https://docs.microsoft.com/nb-no/azure/app-service/)
- [Azure App Service plan overview](https://docs.microsoft.com/en-us/azure/app-service/overview-hosting-plans)
- [Application Insights overview](https://docs.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview)
- [Azure Cosmos DB documentation](https://docs.microsoft.com/en-us/azure/cosmos-db/)
- [Welcome to Azure Cosmos DB](https://docs.microsoft.com/en-us/azure/cosmos-db/introduction)
  - [Consistency levels in Azure Cosmos DB](https://docs.microsoft.com/en-us/azure/cosmos-db/consistency-levels)
- [Azure SQL documentation](https://docs.microsoft.com/en-us/azure/azure-sql/)
- [What is Azure SQL Database?](https://docs.microsoft.com/en-us/azure/azure-sql/database/sql-database-paas-overview)
- [Long-term retention - Azure SQL Database and Azure SQL Managed Instance](https://docs.microsoft.com/en-us/azure/azure-sql/database/long-term-retention-overview)
- [Azure Cache for Redis Documentation](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/)
- [About Azure Cache for Redis](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview)
- [Azure CDN Documentation](https://docs.microsoft.com/en-us/azure/cdn/)
- [Virtual Network documentation](https://docs.microsoft.com/en-us/azure/virtual-network/)
- [Web Application Firewall documentation](https://docs.microsoft.com/en-us/azure/web-application-firewall/)
- [Network security groups](https://docs.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)






Terraform documentation: 
  - Virtual network: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network 
  - Subnet: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet 
  - NSG: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group 
  - NSG: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association 
  - App service: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
  - App service plan: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan 
  - Random passsword: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
  - MsSQL server: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server
  - MsSQL db: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database 
  - CosmosDB: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account 
  - CosmosDB: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_database
  - Redis: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache
  - Application insight: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights 





