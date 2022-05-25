# Azure Key Vault

## Info / intro
This Module sets up a Keyvault in Azure, with some basic access policies. 


![1-key-vault.png](/img/1-key-vault.png)

## Configure Module
- Set the name of the key vault
- Set the right access policy for the Key Vault for the use case

--------------------------------------------------
## Terraform documentation 

### Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

### Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_resource_group.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |


### Inputs

| Name | Description | Type | Default | Should variable be changed? |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_keyvault_name"></a> [keyvault\_name](#input\_keyvault\_name) | n/a | `string` | `"bachelor-keyvault"` | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"norwayeast"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `"keyvault"` | yes |


-------------------------------------------------
## References 
Link to the Azure resource can be found in the [Resources table](#resources). By clicking on the name of the resource you will be sent to the HashiCorps Terraform documentation/registry for that resource.

Micorsoft Documenation:
- [Azure Key Vault documentation](https://docs.microsoft.com/en-us/azure/key-vault/general/)
- [About Azure Key Vault](https://docs.microsoft.com/en-us/azure/key-vault/general/overview)
- [Azure Key Vault basic concepts](https://docs.microsoft.com/en-us/azure/key-vault/general/basic-concepts)



