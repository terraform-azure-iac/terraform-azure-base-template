#Making a test resource for module
resource "azurerm_resource_group" "resource_group_monitoring" {
    name      = var.resource_group_name
    location  = var.location
}

#Variable for the curret client config
data "azurerm_client_config" "current" {}

#Temp test storage account
resource "azurerm_storage_account" "storage_account_test_monitor" {
    name                      = var.storage_account_name
    resource_group_name       = azurerm_resource_group.resource_group_monitoring.name
    location                  = var.location 
    account_tier              = var.account_tier
    account_replication_type  = var.account_replication_type
}

#Monitor action group
resource "azurerm_monitor_action_group" "monitor_action_group" {
    name                  = var.monitor_action_group_name
    resource_group_name   = azurerm_resource_group.resource_group_monitoring.name
    short_name            = var.short_name_action_group

    #Not sure how to get it working
    webhook_receiver {
      name          = var.webhook_receiver_name
      service_uri   = var.webhook_uri
    }

    #Sending alerts to the specified email
    email_receiver {
      name = var.name_reciver
      email_address = var.email_address_reciver
    }
    //For adding mulitple reciver
    dynamic "email_receiver" {
      for_each    = var.reciver
      content {
        name                    = "${email_receiver.value.name}-email"
        email_address           = email_receiver.value.email_address
        use_common_alert_schema = email_receiver.value.use_common_alert_schema
      }
    } 

    #Another way of setting up a webhook
    /*automation_runbook_receiver {
      name                    = var.automation_runbook_reciver_name
      automation_account_id   = azurerm_automation_account.automation_account.id
      runbook_name            = azurerm_automation_runbook.automation_runbook.name
      webhook_resource_id     = var.webhook_resource_id
      is_global_runbook       = true
      service_uri             = var.webhook_uri
    } 
  */
}

#An automation account for running scripts, not optimilized, but the way to run scripts
/*resource "azurerm_automation_account" "automation_account" {
    name                  = var.automation_account_name
    location              = var.location
    resource_group_name   = azurerm_resource_group.resource_group_monitoring.name

    sku_name              = var.sku_name
}

data "local_file" "scripts" {
  filename = "${path.module}/webhook.ps1"
}

#Using template_file creates the posibility to use variable
data "template_file" "init" {
  template = "${file("${path.module}/webhook.ps1")}"
  vars = {
    uri  = var.webhook_uri
  }
}

#A runbook for webhook
resource "azurerm_automation_runbook" "automation_runbook" {
  name                      = var.automation_runbook_name
  location                  = var.location
  resource_group_name       = azurerm_resource_group.resource_group_monitoring.name
  automation_account_name   = azurerm_automation_account.automation_account.name
  log_verbose               = "true"
  log_progress              = "true"
  description               = "Test runbook for webhooks"
  runbook_type              = "PowerShell"
  content                   = data.local_file.scripts.content
}
*/

#Checks transactions on storage account, and if they go over the specified amount a alert will be sent
resource "azurerm_monitor_metric_alert" "monitor_metric_alert" {
    name                  = var.monitor_activity_log_alert_name
    resource_group_name   = azurerm_resource_group.resource_group_monitoring.name
    scopes                = [azurerm_storage_account.storage_account_test_monitor.id]
    description           = "Will trigger alert when transaction is higher than 50"

    criteria {
      metric_namespace  = "Microsoft.Storage/storageAccounts"
      metric_name       = "Transactions"
      aggregation       = "Total"
      operator          = "GreaterThan"
      threshold         = 20

      dimension {
        name      = "ApiName"
        operator  = "Include"
        values    = ["*"]
      }
    
    }

  action {
    action_group_id = azurerm_monitor_action_group.monitor_action_group.id
  }
    
}

#Monitors the specified resource
resource "azurerm_monitor_activity_log_alert" "monitor_activity_log_alert" {
    name                  = var.monitor_activity_log_alert_name
    resource_group_name   = azurerm_resource_group.resource_group_monitoring.name
    scopes                = [azurerm_resource_group.resource_group_monitoring.id]
    description           = "Will monitor the specified storage account"

    criteria {
    resource_id     = azurerm_storage_account.storage_account_test_monitor.id
    operation_name  = "Microsoft.Storage/storageAccounts/write"
    category        = "Recommendation"
    }

  action {
    action_group_id     = azurerm_monitor_action_group.monitor_action_group.id
    webhook_properties  = {
      from = "terraform"
    }
  }
}

#Action rule, for when the rule should activate
resource "azurerm_monitor_action_rule_suppression" "monitor_action_rule_suppression" {
    name                  = var.monitor_action_rule_suppression_name
    resource_group_name   = azurerm_resource_group.resource_group_monitoring.name

    scope {
      type          = "ResourceGroup"
      resource_ids  = [azurerm_resource_group.resource_group_monitoring.id]
    }

    suppression {
      recurrence_type   = "Weekly"

      schedule {
        start_date_utc      = "2022-02-24T01:02:03Z"
        end_date_utc        = "2023-02-24T15:02:07Z"
        recurrence_weekly   = ["Sunday", "Monday", "Friday", "Saturday"]
      }
    }
}

#Creates a eventhub namespace for the eventhub
resource "azurerm_eventhub_namespace" "eventhub_namespace" {
    name                  = var.eventhub_namespace_name
    location              = var.location
    resource_group_name   = azurerm_resource_group.resource_group_monitoring.name
    sku                   = var.sku_eventhub
    capacity              = 1
}

#Creates a eventhub resource
resource "azurerm_eventhub" "eventhub" {
    name                  = var.eventhub_name
    namespace_name        = azurerm_eventhub_namespace.eventhub_namespace.name
    resource_group_name   = azurerm_resource_group.resource_group_monitoring.name
    partition_count       = 2
    message_retention     = 2
}

#Eventhub rule 
resource "azurerm_eventhub_authorization_rule" "eventhub_authorization_rule" {
    name                  = var.eventhub_authorization_rule_name
    namespace_name        = azurerm_eventhub_namespace.eventhub_namespace.name
    eventhub_name         = azurerm_eventhub.eventhub.name
    resource_group_name   = azurerm_resource_group.resource_group_monitoring.name
    listen                = true
    send                  = false
    manage                = false
}

#A monitor log profile, specifying which actions it can take and how long it should store the data
resource "azurerm_monitor_log_profile" "monitor_log_profile" {
    name = "default"

  categories = [ 
    "Action",
    "Delete",
    "Write", 
    ]

  locations = [ 
    "norwayeast", 
    ]

  servicebus_rule_id = "${azurerm_eventhub_namespace.eventhub_namespace.id}/authorizationrules/RootManageSharedAccessKey"
  storage_account_id = azurerm_storage_account.storage_account_test_monitor.id

  retention_policy {
    enabled = true
    days    = 6
  }
}

#Makes a analytics workspace resource
resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                  = var.log_analytics_workspace_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.resource_group_monitoring.name
  sku                   = var.sku_log_analytics_workspace
}

#Links the analytics workspace to the storage account
resource "azurerm_log_analytics_linked_storage_account" "linked_storage_account" {
  data_source_type        = "customlogs" 
  resource_group_name     = azurerm_resource_group.resource_group_monitoring.name
  workspace_resource_id   = azurerm_log_analytics_workspace.log_analytics_workspace.id
  storage_account_ids     = [azurerm_storage_account.storage_account_test_monitor.id]
}

#Manages Storage Insight resource to view events happening on the storage account
resource "azurerm_log_analytics_storage_insights" "log_analytics_storage_insights" {
  name                  = var.log_analytics_storage_insights_name
  resource_group_name   = azurerm_resource_group.resource_group_monitoring.name
  workspace_id          = azurerm_log_analytics_workspace.log_analytics_workspace.id
  storage_account_id    = azurerm_storage_account.storage_account_test_monitor.id
  storage_account_key   = azurerm_storage_account.storage_account_test_monitor.primary_access_key
}

#Eksempel på hvordan bruke monitoring til å regulere instanser av VM'er etter CPU bruk på maskinene
/*resource "azurerm_monitor_autoscale_setting" "monitor_autoscale_setting_example" {
    name                  = var.monitor_autoscale_setting_example_name
    resource_group_name   = azurerm_resource_group.resource_group_monitoring.name
    location              = var.location
    target_resource_id    = 

  profile {
    name  = "testprofil1"

    capacity {
      default = 1
      minimum = 1 
      maximum = 5
    }

    rule {
      metric_trigger {
      metric_name         = "Percentage CPU"
      metric_resource_id  = 
      time_grain          = "PT1M"
      statistic           = "Average"
      time_window         = "PT5M"
      time_aggregation    = "Average"
      operator            = "GreaterThan"
      threshold           = 90
      }
    
      scale_action {
        direction   = "Increase"
        type        = "ChangeCount"
        value       = "2"
        cooldown    = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name         = "Percentage CPU"
        metric_resource_id  = 
        time_grain          = "PT1M"
        statistic           = "Average"
        time_window         = "PT5M"
        time_aggregation    = "Average"
        operator            = "LessThan"
        threshold           = 10
      }
      scale_action {
        direction   = "Decrease"
        type        = "ChangeCount"
        value       = "2"
        cooldown    = "PT1M"
      }
    }

    recurrence {
      frequency   = "Week"
      timezone    = "Greenwich Mean Time Zone"
      days        = ["Saturday", "Sunday"]
      hours       = [12]
      minutes     = [0]
    }
  }
  
  notification {
    email {
      send_to_subscription_administrator      = true
      send_to_subscription_co_administrator   = true
      custom_emails                           = var.email
    }
  }
}
*/


#Determines if adcanced threat protection should be enabled on the resource
resource "azurerm_advanced_threat_protection" "advanced_threat_protection" {
    target_resource_id  = azurerm_storage_account.storage_account_test_monitor.id
    enabled             = true
}

#Specifies which email and phone number that should get alerts on events from security center
resource "azurerm_security_center_contact" "security_center_contact" {
    email                 = var.security_center_contact_email
    phone                 = var.security_center_contact_phone
    alert_notifications   = true
    alerts_to_admins      = true
}


resource "azurerm_security_center_automation" "security_center_automation" {
    name                  = var.security_center_automation_name
    location              = var.location
    resource_group_name   = azurerm_resource_group.resource_group_monitoring.name

    action {
      type              = "EventHub"
      resource_id       = azurerm_eventhub.eventhub.id
      connection_string  = azurerm_eventhub_authorization_rule.eventhub_authorization_rule.primary_connection_string
    }

    source {
      event_source  = "Alerts"
        rule_set {
          rule {
            property_path   = "properties.metadata.severity"
            operator        = "Equals"
            expected_value  = "High"
            property_type   = "String"
          }
        }
      }
  
  scopes = [ "/subscriptions/${data.azurerm_client_config.current.subscription_id}" ]
}

resource "azurerm_log_analytics_solution" "log_analytics_solution" {
    solution_name           = "SecurityInsights"
    location                = var.location 
    resource_group_name     = azurerm_resource_group.resource_group_monitoring.name
    workspace_resource_id   = azurerm_log_analytics_workspace.log_analytics_workspace.id
    workspace_name          = azurerm_log_analytics_workspace.log_analytics_workspace.name

    plan {
      publisher   = "Microsoft"
      product     = "OMSGallery/SecurityInsights"
    }

}

resource "azurerm_sentinel_alert_rule_fusion" "sentinel_alert_rule_fusion" {
    name                        = "test-sentinal-fusion-alert" 
    log_analytics_workspace_id  = azurerm_log_analytics_workspace.log_analytics_workspace.id
    alert_rule_template_guid    = "f71aba3d-28fb-450b-b192-4e76a83015c8"
}

resource "azurerm_sentinel_alert_rule_machine_learning_behavior_analytics" "sentinel_alert_machine_learning" {
    name                        = "machine_learning_alert_rule"
    log_analytics_workspace_id  = azurerm_log_analytics_solution.log_analytics_solution.workspace_resource_id 
    alert_rule_template_guid    = "737a2ce1-70a3-4968-9e90-3e6aca836abf"
}

resource "azurerm_sentinel_alert_rule_ms_security_incident" "sentinel_alert_ms_security_incident" {
    name                        = "test_ms_security_incident"
    log_analytics_workspace_id  = azurerm_log_analytics_solution.log_analytics_solution.workspace_resource_id 
    product_filter              = "Microsoft Cloud App Security"
    display_name                = "test rule"
    severity_filter             = [ "High" ]
}

resource "azurerm_sentinel_automation_rule" "sentinel_automation_rule" {
    name                        = "56094f72-ac3f-40e7-a0c0-47bd95f70336"
    log_analytics_workspace_id  = azurerm_log_analytics_solution.log_analytics_solution.workspace_resource_id 
    display_name                = "automation_rule_test"
    order                       = 1
    action_incident {
      order   = 1
      status  = "Active"
    } 
}

##Resoruces for connecting resoruces in Azure to the Sentiel solution
resource "azurerm_sentinel_data_connector_azure_advanced_threat_protection" "sentinel_data_connector_azure_atp" {
    name                        = "test-atp"
    log_analytics_workspace_id  = azurerm_log_analytics_solution.log_analytics_solution.workspace_resource_id   
}

resource "azurerm_sentinel_data_connector_azure_security_center" "sentinel_data_connector_azure_security_center" {
    name                        = "test-security-center"
    log_analytics_workspace_id  = azurerm_log_analytics_solution.log_analytics_solution.workspace_resource_id 
}

resource "azurerm_sentinel_data_connector_microsoft_defender_advanced_threat_protection" "sentinel_data_microsoft_defender_atp" {
    name                        = "test-microsoftdefender-atp"
    log_analytics_workspace_id  = azurerm_log_analytics_solution.log_analytics_solution.workspace_resource_id 
}

resource "azurerm_sentinel_data_connector_threat_intelligence" "sentinel_data_connector_threat_intelligence" {
    name                        = "test-threat-"
    log_analytics_workspace_id  = azurerm_log_analytics_solution.log_analytics_solution.workspace_resource_id 
}

resource "azurerm_sentinel_watchlist" "sentinel_watchlist" {
  name                        = "test-watchlist"
  log_analytics_workspace_id  = azurerm_log_analytics_solution.log_analytics_solution.workspace_resource_id 
  display_name                = "test-watchlist"
}