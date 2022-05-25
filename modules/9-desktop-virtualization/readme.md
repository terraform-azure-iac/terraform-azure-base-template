# Azure Virtual Desktop



## Info / intro

This module sets up Azure Desktop Virtualization with a number of Windows virtual machines. Users given access can log on to the VMs with Remote Desktop client on their PC.

![9-virtual-desktop](/img/9-virtual-desktop.png)

How it works:

- VMs are created and added to a host pool
- Azure AD users are added to a Azure AD group, which is given access to the VMs
- Users log in to Remote Desktop client with their user which is set in Azure AD
- Network Security Groups can be configured to allow only RDP, and only from certain IP addresses (private home IP or office IP)

## Configure Module
- Number of VMs to provision
- Naming for resources 
- Location 
- Tier, Size, sku, capacity and Version of the resources
- Admin user name
- Domain name
- Expiration date - host pool
- Add users to the Azure AD Group to give them access to VMs in the host pool


## Terraform documentation 

### Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |



### Resources

| Name | Type |
|------|------|
| [azuread_group.aad_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group.dc_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_service_principal.adds](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_user.dc_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/user) | resource |
| [azurerm_active_directory_domain_service.adds](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/active_directory_domain_service) | resource |
| [azurerm_network_interface.dv_vm_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.adds](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_resource_group.adds](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.dv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_provider_registration.adds](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_provider_registration) | resource |
| [azurerm_role_assignment.admin_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_subnet.adds](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.vms](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.adds](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.nsg_ass](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_desktop_application_group.dag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_application_group) | resource |
| [azurerm_virtual_desktop_host_pool.hostpool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool) | resource |
| [azurerm_virtual_desktop_host_pool_registration_info.dv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool_registration_info) | resource |
| [azurerm_virtual_desktop_host_pool_registration_info.registration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool_registration_info) | resource |
| [azurerm_virtual_desktop_workspace.workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_workspace) | resource |
| [azurerm_virtual_desktop_workspace_application_group_association.ws-dag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_workspace_application_group_association) | resource |
| [azurerm_virtual_machine_extension.domainjoin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.vmext_dsc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.wait-for-domain-to-provision](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_network.adds](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.vms](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.adds_to_dv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.dv_to_adds](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_windows_virtual_machine.dv_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.dv_vm](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [time_rotating.avd_token](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [azurerm_role_definition.admin_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_role_definition.role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

### Inputs

| Name | Description | Type | Default | Should Default be changed? |
|------|-------------|------|---------|:--------:|
| <a name="input_active_directory_admin"></a> [active\_directory\_admin](#input\_active\_directory\_admin) | The name of the Active Directory domain admin user | `string` | `""` | yes |
| <a name="input_active_directory_admin_password"></a> [active\_directory\_admin\_password](#input\_active\_directory\_admin\_password) | The name of the Active Directory domain admin user | `string` | `""` | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of the Active Directory domain | `string` | `""` | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_local_admin_username"></a> [local\_admin\_username](#input\_local\_admin\_username) | local admin username for VMs | `string` | `"superduperadmin"` | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"northeurope"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | n/a | `string` | `"desktop-virt"` | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `"desktop-virtualization"` | yes |
| <a name="input_vm_count"></a> [vm\_count](#input\_vm\_count) | n/a | `number` | `1` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Size of the machine to deploy | `string` | `"Standard_B2s"` | no |


-----------------------------------------


## References

- Azure AD 
  - [Azure Active Directory fundamentals documentation](https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/)
  - [What is Azure Active Directory?](https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-whatis)
  - azuread domain service
    - [Azure AD Domain Services documentation](https://docs.microsoft.com/en-us/azure/active-directory-domain-services/)
    - [What is Azure Active Directory Domain Services?](https://docs.microsoft.com/en-us/azure/active-directory-domain-services/overview)
- Virtual Desktop
  - [Azure Virtual Desktop documentation](https://docs.microsoft.com/en-us/azure/virtual-desktop/)
  - [What is Azure Virtual Desktop?](https://docs.microsoft.com/en-us/azure/virtual-desktop/overview)
- [Virtual machines in Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/)
  - [Windows virtual machines in Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/overview)
- [Azure resource providers and types](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-providers-and-types)
- [What is Azure role-based access control (Azure RBAC)?](https://docs.microsoft.com/en-us/azure/role-based-access-control/overview)
- network
  - [Virtual Network documentation](https://docs.microsoft.com/en-us/azure/virtual-network/)
  - [Network security groups](https://docs.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)
  - [Create, change, or delete a network interface](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-network-interface)
  - [Virtual networks and virtual machines in Azure - Network interfaces](https://docs.microsoft.com/en-us/azure/virtual-network/network-overview)
