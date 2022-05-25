# Name of module



## Info / intro

This module sets up..

![3-monitoring.png](/img/3-monitoring.png)

## Configure Module
- Set the email recivers 
- Set the webhook reciver
- set the recurent type 
- set the schedule for the start and end for the action rule
- set the phone number
- set the alert rule template for sentinel

----------------------------------------------

### Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |


### Resources

| Name | Type |
|------|------|
| [azurerm_advanced_threat_protection.advanced_threat_protection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/advanced_threat_protection) | resource |
| [azurerm_eventhub.eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_authorization_rule.eventhub_authorization_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_authorization_rule) | resource |
| [azurerm_eventhub_namespace.eventhub_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_log_analytics_linked_storage_account.linked_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_linked_storage_account) | resource |
| [azurerm_log_analytics_solution.log_analytics_solution](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution) | resource |
| [azurerm_log_analytics_storage_insights.log_analytics_storage_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_storage_insights) | resource |
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_action_group.monitor_action_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_action_rule_suppression.monitor_action_rule_suppression](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_rule_suppression) | resource |
| [azurerm_monitor_activity_log_alert.monitor_activity_log_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_activity_log_alert) | resource |
| [azurerm_monitor_log_profile.monitor_log_profile](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_log_profile) | resource |
| [azurerm_monitor_metric_alert.monitor_metric_alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_resource_group.resource_group_monitoring](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_security_center_automation.security_center_automation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_automation) | resource |
| [azurerm_security_center_contact.security_center_contact](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_contact) | resource |
| [azurerm_sentinel_alert_rule_fusion.sentinel_alert_rule_fusion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_alert_rule_fusion) | resource |
| [azurerm_sentinel_alert_rule_machine_learning_behavior_analytics.sentinel_alert_machine_learning](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_alert_rule_machine_learning_behavior_analytics) | resource |
| [azurerm_sentinel_alert_rule_ms_security_incident.sentinel_alert_ms_security_incident](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_alert_rule_ms_security_incident) | resource |
| [azurerm_sentinel_automation_rule.sentinel_automation_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_automation_rule) | resource |
| [azurerm_sentinel_data_connector_azure_advanced_threat_protection.sentinel_data_connector_azure_atp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_data_connector_azure_advanced_threat_protection) | resource |
| [azurerm_sentinel_data_connector_azure_security_center.sentinel_data_connector_azure_security_center](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_data_connector_azure_security_center) | resource |
| [azurerm_sentinel_data_connector_microsoft_defender_advanced_threat_protection.sentinel_data_microsoft_defender_atp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_data_connector_microsoft_defender_advanced_threat_protection) | resource |
| [azurerm_sentinel_data_connector_threat_intelligence.sentinel_data_connector_threat_intelligence](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_data_connector_threat_intelligence) | resource |
| [azurerm_sentinel_watchlist.sentinel_watchlist](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_watchlist) | resource |
| [azurerm_storage_account.storage_account_test_monitor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

### Inputs

| Name | Description | Type | Default | Should Default be changed? |
|------|-------------|------|---------|:--------:|
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | n/a | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | n/a | `string` | `"Standard"` | no |
| <a name="input_automation_account_name"></a> [automation\_account\_name](#input\_automation\_account\_name) | n/a | `string` | `"automation-test-account"` | yes |
| <a name="input_automation_runbook_name"></a> [automation\_runbook\_name](#input\_automation\_runbook\_name) | n/a | `string` | `"webhook-test"` | yes |
| <a name="input_automation_runbook_reciver_name"></a> [automation\_runbook\_reciver\_name](#input\_automation\_runbook\_reciver\_name) | n/a | `string` | `"test-reciver"` | yes |
| <a name="input_email"></a> [email](#input\_email) | n/a | `list` | <pre>[<br>  "user1@test.no",<br>  "user2@test.no"<br>]</pre> | yes |
| <a name="input_email_address_reciver"></a> [email\_address\_reciver](#input\_email\_address\_reciver) | #Variables that needs to be changed | `string` | `"test@test.no"` | yes |
| <a name="input_eventhub_authorization_rule_name"></a> [eventhub\_authorization\_rule\_name](#input\_eventhub\_authorization\_rule\_name) | n/a | `string` | `"eventhub-rule-name"` | yes |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | n/a | `string` | `"testeventhub"` | yes |
| <a name="input_eventhub_namespace_name"></a> [eventhub\_namespace\_name](#input\_eventhub\_namespace\_name) | n/a | `string` | `"eventhub-logprofile"` | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"norwayeast"` | no |
| <a name="input_log_analytics_storage_insights_name"></a> [log\_analytics\_storage\_insights\_name](#input\_log\_analytics\_storage\_insights\_name) | n/a | `string` | `"storage-insights-analytics"` | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | n/a | `string` | `"log-analytics-workspace"` | yes |
| <a name="input_monitor_action_group_name"></a> [monitor\_action\_group\_name](#input\_monitor\_action\_group\_name) | n/a | `string` | `"monitor-action-group"` | yes |
| <a name="input_monitor_action_rule_suppression_name"></a> [monitor\_action\_rule\_suppression\_name](#input\_monitor\_action\_rule\_suppression\_name) | n/a | `string` | `"monitor-suppression-test"` | yes |
| <a name="input_monitor_activity_log_alert_name"></a> [monitor\_activity\_log\_alert\_name](#input\_monitor\_activity\_log\_alert\_name) | n/a | `string` | `"log-alert"` | yes |
| <a name="input_monitor_autoscale_setting_example_name"></a> [monitor\_autoscale\_setting\_example\_name](#input\_monitor\_autoscale\_setting\_example\_name) | n/a | `string` | `"auto-scaleing-test"` | yes |
| <a name="input_monitor_metric_alert_name"></a> [monitor\_metric\_alert\_name](#input\_monitor\_metric\_alert\_name) | n/a | `string` | `"metric-alert-test"` | yes |
| <a name="input_name_reciver"></a> [name\_reciver](#input\_name\_reciver) | n/a | `string` | `"test"` | yes |
| <a name="input_reciver"></a> [reciver](#input\_reciver) | The email reciver from the monito action group | <pre>list(object({<br>        name                    = string<br>        email_address           = string<br>        use_common_alert_schema = bool<br>    }))</pre> | <pre>[<br>  {<br>    "email_address": "employee1@temp.no",<br>  
  "name": "employee name 1",<br>    "use_common_alert_schema": true<br>  },<br>  {<br>    "email_address": "employee2@temp.no",<br>    "name": "Employee Name 2",<br>    "use_common_alert_schema": true<br>  }<br>]</pre> | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `"monitoring"` | yes |
| <a name="input_security_center_automation_name"></a> [security\_center\_automation\_name](#input\_security\_center\_automation\_name) | n/a | `string` | `"security-center-automation"` | yes |
| <a name="input_security_center_contact_email"></a> [security\_center\_contact\_email](#input\_security\_center\_contact\_email) | n/a | `string` | `"test@test.com"` | yes |
| <a name="input_security_center_contact_phone"></a> [security\_center\_contact\_phone](#input\_security\_center\_contact\_phone) | n/a | `string` | `"+1-555-555-5555"` | yes |
| <a name="input_short_name_action_group"></a> [short\_name\_action\_group](#input\_short\_name\_action\_group) | n/a | `string` | `"monitoraction"` | yes |
| <a name="input_sku_eventhub"></a> [sku\_eventhub](#input\_sku\_eventhub) | n/a | `string` | `"Standard"` | no |
| <a name="input_sku_log_analytics_workspace"></a> [sku\_log\_analytics\_workspace](#input\_sku\_log\_analytics\_workspace) | n/a | `string` | `"PerGB2018"` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | n/a | `string` | `"Basic"` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | n/a | `string` | `"monitorstorageaccount55"` | yes |
| <a name="input_webhook_receiver_name"></a> [webhook\_receiver\_name](#input\_webhook\_receiver\_name) | n/a | `string` | `"webhook-receiver"` | yes |
| <a name="input_webhook_resoruce_id"></a> [webhook\_resoruce\_id](#input\_webhook\_resoruce\_id) | n/a | `string` | `"/subscriptions/00000000-0000-0000-0000-000000000000/resourcegroups/rg-runbooks/providers/microsoft.automation/automationaccounts/aaa001/webhooks/webhook_alert"` | yes |
| <a name="input_webhook_uri"></a> [webhook\_uri](#input\_webhook\_uri) | A Webhook to desired application | `string` | `"https://example_webhook.com/123abc"` | yes |


------------------------------------------------------

## References 
Link to the Azure resource can be found in the [Resources table](#resources). By clicking on the name of the resource you will be sent to the HashiCorps Terraform documentation/registry for that resource.

Micorsoft Documenation:
- [Manage Azure resource groups by using the Azure portal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal)



------------------------------
Virtual Machines: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set
monitor activity log alert: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_activity_log_alert
action rule suppression: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_rule_suppression
monitor autoscaling: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting
monitor log profile: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_log_profile
monitor metric alert: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert
log analytics linked storage: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_linked_storage_account
log analytics linked service: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_linked_service
log analytics storage insights: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_storage_insights
log analytics workspace: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace
advanced threat protection = https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/advanced_threat_protection
security center contact = https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_contact
security center automation = https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_automation


Se videre på monitor action group: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group

Se videre på: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_smart_detector_alert_rule

sentinel machine learning = https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/azurerm_sentinel_alert_rule_machine_learning_behavior_analytics
sentinel alert rule fusion = https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_alert_rule_fusion
sentinel alert rule ms security incident = https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_alert_rule_ms_security_incident
sentinel automation rule = https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_automation_rule
sentinel connector threat protection = https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_data_connector_azure_advanced_threat_protection
sentinel connector security center = https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_data_connector_azure_security_center
sentinel connecor ms defender ATP = https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_data_connector_microsoft_defender_advanced_threat_protection
sentinel connecotr threat intelligence = https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_data_connector_threat_intelligence
sentinel watchlist = https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sentinel_watchlist
