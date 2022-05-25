resource "azurerm_resource_group" "budget" {
    name        = "base-${var.resource_group_name}-${var.enviroment}"
    location    = var.location
}


/* 
cost bugdet
cost alert
dashboard
*/
resource "azurerm_monitor_action_group" "monitor_action_group" {
    name                = var.action_group_name
    resource_group_name = azurerm_resource_group.budget.name
    short_name          = var.action_group_short_name

    dynamic "email_receiver" {
    for_each = var.email_reciver
        content {
            name                    = email_receiver.value.name
            email_address           = email_receiver.value.email_address
            use_common_alert_schema = email_receiver.value.use_common_alert_schema
        }
    }

    webhook_receiver {
        name                    = var.webhook_reciver_name
        service_uri             = var.webhook_reciver_uri
        use_common_alert_schema = true
    }

}

data "azurerm_subscription" "current" {}

resource "azurerm_consumption_budget_subscription" "budget_consump_sub" {
    name                = var.consumption_budget_subscription_name
    subscription_id     = data.azurerm_subscription.current.id
    amount              = var.consumption_budget_subscription_amount
    time_grain          = var.consumption_budget_subscription_time_grain
    time_period         {
        start_date  = var.consumption_budget_subscription_time_period[0] 
        end_date    = var.consumption_budget_subscription_time_period[1]
    }
    notification {
        enabled         = true
        operator        = "GreaterThan"    
        threshold       = 90.0
        threshold_type  = "Actual"      #Actual or Forecasted
        contact_groups  = [
            azurerm_monitor_action_group.monitor_action_group.id,
        ]
    }

}

resource "azurerm_consumption_budget_resource_group" "consumption_budget_resource_group" {
    name                = var.consumption_budget_resource_group_name
    #resource_group_id   = azurerm_resource_group.budget.id
    resource_group_id   = var.resource_group_id
    amount              = var.consumption_budget_resource_group_amount
    time_grain          = var.consumption_budget_resource_group_time_grain
    time_period {
        start_date = var.consumption_budget_resource_group_time_period[0]
        end_date   = var.consumption_budget_resource_group_time_period[1]
    }
    notification {
        enabled        = true
        threshold      = 100.0
        operator       = "GreaterThan"
        threshold_type = "Forecasted"
        contact_groups  = [
            azurerm_monitor_action_group.monitor_action_group.id,
        ]
    }
}
