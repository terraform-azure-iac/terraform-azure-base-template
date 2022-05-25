##Variables that needs to be changed
variable "email_address_reciver" {
    type      = string
    default   = "test@test.no"
}

variable "webhook_resoruce_id" {
    type      = string
    //Example for resoruce, need id and the desired resoruce
    default   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourcegroups/rg-runbooks/providers/microsoft.automation/automationaccounts/aaa001/webhooks/webhook_alert"
}

variable "reciver" {
    type    = list(object({
        name                    = string
        email_address           = string
        use_common_alert_schema = bool
    }))
    default = [{
        name                    = "employee name 1"
        email_address           = "employee1@temp.no"
        use_common_alert_schema = true
    },
    {
        name                    = "Employee Name 2"
        email_address           = "employee2@temp.no"
        use_common_alert_schema = true
    }]
    description = "The email reciver from the monito action group"
}

variable "email" {
  type = list
  default = [
    "user1@test.no",
    "user2@test.no"
  ]
    
}

variable "security_center_contact_email" {
  type      = string
  default   = "test@test.com"
}

variable "security_center_contact_phone" {
  type      = string
  default   = "+1-555-555-5555"
}

variable "webhook_uri" {
  type        = string
  default     = "https://example_webhook.com/123abc"
  description = "A Webhook to desired application"
}


##Variables with names that should be changed

variable "resource_group_name" {
  type      = string 
  default   = "monitoring"
}

variable "storage_account_name" {
  type      = string
  default   = "monitorstorageaccount55"
}

variable "short_name_action_group" {
    type      = string
    default   = "monitoraction"
}

variable "name_reciver" {
    type      = string
    default   = "test"
}

variable "webhook_receiver_name" {
  type      = string
  default   = "webhook-receiver"
}

variable "monitor_action_group_name" {
  type      = string 
  default   = "monitor-action-group"
}

variable "monitor_activity_log_alert_name" {
  type      = string 
  default   = "log-alert"
}

variable "monitor_action_rule_suppression_name" {
  type      = string
  default   = "monitor-suppression-test"
}

variable "monitor_autoscale_setting_example_name" {
  type      = string 
  default   = "auto-scaleing-test"
}



variable "eventhub_namespace_name" {
  type      = string
  default   = "eventhub-logprofile"
}

variable "monitor_metric_alert_name" {
  type      = string
  default   = "metric-alert-test"
}

variable "automation_account_name" {
  type     = string
  default  = "automation-test-account"
}

variable "automation_runbook_name" {
  type      = string
  default   = "webhook-test"
}

variable "automation_runbook_reciver_name" {
  type      = string
  default   = "test-reciver"
}

variable "log_analytics_workspace_name" {
  type      = string
  default   = "log-analytics-workspace"
}

variable "log_analytics_storage_insights_name" {
  type      = string
  default   = "storage-insights-analytics"
}

variable "eventhub_name" {
  type      = string
  default   = "testeventhub"
}

variable "eventhub_authorization_rule_name" {
  type      = string
  default   = "eventhub-rule-name"
}



variable "security_center_automation_name" {
  type      = string
  default   = "security-center-automation"
}


##Variables that can be changed, depending on needs

variable "account_tier" {
    type      = string
    default   = "Standard"
}

variable "account_replication_type" {
    type      = string
    default   = "LRS"
}


variable "sku_name" {
    type      = string
    default  = "Basic"
}

variable "sku_eventhub" {
    type      = string
    default  = "Standard"
}

variable "sku_log_analytics_workspace" {
    type      = string
    default  = "PerGB2018"
}

##Variables that should not be changed

variable "location" {
  type      = string
  default   = "norwayeast"
}











