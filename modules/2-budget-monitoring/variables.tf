variable "enviroment" {
    type    = string
    default = ""
}

variable "resource_group_name" {
    type    = string
    default = "budget-monitoring"
} 

variable "location" {
    type    = string
    default = "norwayeast"
}

variable "action_group_name" {
    type    = string
    default = "monitor-action-group"
}

variable "action_group_short_name" {
    type    = string
    default = "budget-mon"
}

variable "email_reciver" {
    type    = list(object({
        name                    = string
        email_address           = string
        use_common_alert_schema = bool
    }))
    default = [{
        name                    = "employee name 1"
        email_address           = "employee1@test.no"
        use_common_alert_schema = true
    },
    {
        name                    = "Employee Name 2"
        email_address           = "employee2@test.no"
        use_common_alert_schema = true
    }]
}

variable "webhook_reciver_name" {
    type    = string
    default = "budget-webhook"
}

variable "webhook_reciver_uri" {
    type    = string
    default = "https://example_webhook.com/123abc"
}


#consumption budget subscription
variable "consumption_budget_subscription_name" {
    type    = string
    default = "consumption-budget-subscription-base"
}

variable "consumption_budget_subscription_amount" {
    type    = number
    default = 10
}

variable "consumption_budget_subscription_time_grain" {
    type    = string
    default = "Monthly"
}

variable "consumption_budget_subscription_time_period" {
    type    = list
    default = ["2022-04-01T00:00:00Z", "2023-01-01T00:00:00Z"]
}

#consumption budget resource group
variable "consumption_budget_resource_group_name" {
    type    = string
    default = "consumption-budget-resource-group-base"
}

variable "consumption_budget_resource_group_amount" {
    type    = number
    default = 100
}

variable "consumption_budget_resource_group_time_grain" {
    type    = string
    default = "Monthly"
}

variable "consumption_budget_resource_group_time_period" {
    type    = list
    default = ["2022-04-01T00:00:00Z", "2023-01-01T00:00:00Z"]
}


#The resource group that is going to be tracked
variable "resource_group_id" {
    type    = string
    default = ""
}