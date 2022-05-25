# Name of module



## Info / intro

This module sets up an template for how the modules should look like.

This module is used as a template for the setup of the other modules, in addition to the modules in the base template this will also be used when creating the modules for the two case template.

Here is are also a demonstration on the usage of terraform docs, a tool to generate documentation from Terraform modules in various output formats, see [terraform-docs introduction](https://terraform-docs.io/user-guide/introduction/) for more information on the tool.

Run the command ``` terraform-docs markdown table . ``` in the module folder you want to creat the Terraform documentation for, also in the root module. The command will output something looking like the section [Terraform documentation](#terraform-documentation). 


![0-template.png](/img/0-template.png)

## Configure Module
- Do A to fit it to the needs of the user
- Do B to fit it to the needs of the user
- Do C to fit it to the needs of the user

---------------------------------------------------
## Terraform documentation 
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>2.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_web-page"></a> [template-module](./modules/0-template-module) | ./modules/0-template-module | n/a |

### Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"norwayeast"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `"example"` | no |

### Outputs
| Name | Description |
|------|-------------|
| <a name="output_output-0.12"></a> [output-0.12](#output\_output-0.12) | terraform 0.12 only |
| <a name="output_output-1"></a> [output-1](#output\_output-1) | It's output number one. |
| <a name="output_output-2"></a> [output-2](#output\_output-2) | It's output number two. |
| <a name="output_unquoted"></a> [unquoted](#output\_unquoted) | It's unquoted output. |







---------------------------------------------------------
## References 
Link to the Azure resource can be found in the [Resources table](#resources). By clicking on the name of the resource you will be sent to the HashiCorps Terraform documentation/registry for that resource.

Micorsoft Documenation:
- [Manage Azure resource groups by using the Azure portal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal)

Terraform-docs
- [Generate markdown table using terraform-docs](https://terraform-docs.io/reference/markdown-table/)
- [Introduction to terrafomr-docs](https://terraform-docs.io/user-guide/introduction/)
