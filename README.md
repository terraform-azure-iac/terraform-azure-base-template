# base-template


### File tree structure

<!--- ![file-structure.png](/img/file-structure.png) --->



ð¦base-template  <br/>
 â£ ð[img/](img)  <br/>
 â â£ ð[0-template.png](img/0-template.png)  <br/>
 â â£ ð[1-storage-account.png](img/1-storage-account.png)  <br/>
 â â£ ð[2-budget.png](img/2-budget.png)  <br/>
 â â£ ð[3-monitoring.png](img/3-monitoring.png)  <br/>
 â â£ ð[6-storage.png](img/6-storage.png)  <br/>
 â â£ ð[8-iot.png](img/8-iot.png)  <br/>
 â£ ð[modules/](modules)  <br/>
 â â£ ð[0-template-module/](modules/0-template-module)  <br/>
 â â â ð[readme.md](modules/0-template-module/readme.md)  <br/>
 â â£ ð[1-key-vault/](modules/1-key-vault)  <br/>
 â â â£ ð[main.tf](modules/1-key-vault/main.tf)  <br/>
 â â â£ ð[outputs.tf](modules/1-key-vault/outputs.tf)  <br/>
 â â â£ ð[readme.md](modules/1-key-vault/readme.md)  <br/>
 â â â ð[variables.tf](modules/1-key-vault/variables.tf)  <br/>
 â â£ ð[2-budget-monitoring/](modules/2-budget-monitoring)  <br/>
 â â â£ ð[main.tf](modules/2-budget-monitoring/main.tf)  <br/>
 â â â£ ð[outputs.tf](modules/2-budget-monitoring/outputs.tf)  <br/>
 â â â£ ð[readme.md](modules/2-budget-monitoring/readme.md)  <br/>
 â â â ð[variables.tf](modules/2-budget-monitoring/variables.tf)     <br/>
 â â£ ð[3-monitoring/](modules/3-monitoring)  <br/>
 â â â£ ð [main.tf](modules/3-monitoring/main.tf)  <br/>
 â â â£ ð [outputs.tf](modules/3-monitoring/outputs.tf)  <br/>
 â â â£ ð [readme.md](modules/3-monitoring/readme.md)  <br/>
 â â â£ ð [variables.tf](modules/3-monitoring/variables.tf)  <br/>
 â â â ð [webhook.ps1](modules/3-monitoring/webhook.ps1)  <br/>
 â â£ ð [5-web-page/](modules/5-web-page)  <br/>
 â â â£ ð [main.tf](modules/5-web-page/main.tf)  <br/>
 â â â£ ð [outputs.tf](modules/5-web-page/outputs.tf)  <br/>
 â â â£ ð [readme.md](modules/5-web-page/readme.md)  <br/>
 â â â ð [variables.tf](modules/5-web-page/variables.tf)  <br/>
 â â£ ð [6-storage/](modules/6-storage)  <br/>
 â â â£ ð [main.tf](modules/6-storage/main.tf)  <br/>
 â â â£ ð [outputs.tf](modules/6-storage/outputs.tf)  <br/>
 â â â£ ð [readme.md](modules/6-storage/readme.md)  <br/>
 â â â ð [variables.tf](modules/6-storage/variables.tf)  <br/>
 â â£ ð [8-iot/](modules/8-iot)  <br/>
 â â â£ ð [main.tf](modules/8-iot/main.tf)  <br/>
 â â â£ ð [outputs.tf](modules/8-iot/outputs.tf)  <br/>
 â â â£ ð [README.md](modules/8-iot/README.md)  <br/>
 â â â ð [variables.tf](modules/8-iot/variables.tf)  <br/>
 â â ð [9-desktop-virtualization/](modules/9-desktop-virtualization)  <br/>
 â â â£ ð [main.tf](modules/9-desktop-virtualization/main.tf)  <br/>
 â â â£ ð [output.tf](modules/9-desktop-virtualization/output.tf)  <br/>
 â â â£ ð [readme.md](modules/9-desktop-virtualization/readme.md)  <br/>
 â â â ð [variables.tf](modules/9-desktop-virtualization/variables.tf)  <br/>
 â£ ð [prod/](prod)  <br/>
 â â ð [prod.tfvars](prod/prod.tfvars)  <br/>
 â£ ð [stage/](stage)  <br/>
 â â ð [stage.tfvars](stage/stage.tfvars)  <br/>
 â£ ð [test/](test)  <br/>
 â â ð [test.tfvars](test/test.tfvars)  <br/>
 â£ ð [.gitignore](.gitignore)  <br/>
 â£ ð [backend.tf](backend.tf)  <br/>
 â£ ð [backend_override.tf](backend_override.tf)  <br/>
 â£ ð [main.tf](main.tf)  <br/>
 â£ ð [output.tf](output.tf)  <br/>
 â£ ð [README.md](README.md)  <br/>
 â ð [variables.tf](variables.tf)  <br/>


------------------------
## Terraform Docs
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>2.0 |

### Providers

No providers.

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key-vault"></a> [key-vault](#module\_key-vault) | ./modules/1-key-vault | n/a |
| <a name="module_budget-monitoring"></a> [budget-monitoring](#module\_budget-monitoring) | ./modules/2-budget-monitoring | n/a |
| <a name="module_monitoring"></a> [monitoring](#module\_monitoring) | ./modules/3-monitoring | n/a |
| <a name="module_web-page"></a> [web-page](#module\_web-page) | ./modules/5-web-page | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ./modules/6-storage | n/a |
| <a name="module_iot"></a> [iot](#module\_iot) | ./modules/8-iot | n/a |
| <a name="module_desktop-virtualization"></a> [desktop-virtualization](#module\_desktop-virtualization) | ./modules/9-desktop-virtualization | n/a |
### Resources

No resources.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |

### Outputs

No outputs.


---------------------