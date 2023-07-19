[![Release][release-image]][release] [![CI][ci-image]][ci] [![License][license-image]][license] [![Registry][registry-image]][registry]

# terraform-azurerm-service-vmss

A Terraform module which forms the base of all `vmss` deployments for Snowplow OS services where we deploy a group of nodes running one or more services.  This module serves to reduce the boilerplate code that we incur otherwise to simplify maintenance across all of our OS modules.

The default `user-data.sh` that is pre-pended to all servers launched contains a few helpful bash functions:

1. `get_instance_id`: Will return the `vmId` of the server which we use primarily for Telemetry capture
2. `get_application_memory_mb`: Will return the amount of memory that can be assigned to a service running on the box.  It factors in a minimum allocation for the operating system and then returns a percentage of the available memory to assign.
  - Default is 80% of the available memory to the service and 384mb for the Operating System left available
  - Both settings can be overriden with positional arguments (e.g. `get_application_memory_mb 60 500` would allocate 60% to the service and 500mb to the OS)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.58.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.58.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine_scale_set.vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_ssh_public_key"></a> [admin\_ssh\_public\_key](#input\_admin\_ssh\_public\_key) | The SSH public key attached for access to the servers | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A name which will be pre-pended to the resources created | `string` | n/a | yes |
| <a name="input_network_security_group_id"></a> [network\_security\_group\_id](#input\_network\_security\_group\_id) | The security group to attach to the deployed servers | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to deploy the instances into | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet id to deploy the instances across | `string` | n/a | yes |
| <a name="input_user_supplied_script"></a> [user\_supplied\_script](#input\_user\_supplied\_script) | The user-data script extension to execute | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The username to be set as the server admin | `string` | `"snowplow"` | no |
| <a name="input_application_gateway_backend_address_pool_ids"></a> [application\_gateway\_backend\_address\_pool\_ids](#input\_application\_gateway\_backend\_address\_pool\_ids) | The ID of the backend address pool to bind the scale-set to when used with a load balancer | `list(string)` | `[]` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Whether to assign a public ip address to this instance | `bool` | `true` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | The number of instances to deploy in the scale-set | `number` | `1` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | The size of the Operating System disk in gb | `number` | `30` | no |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type) | The type of disk to use for the Operating System | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the instances to be deployed | `string` | `"Standard_B1ms"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to append to this resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vmss_admin_username"></a> [vmss\_admin\_username](#output\_vmss\_admin\_username) | The admin username used for SSH in the deployed instances |
| <a name="output_vmss_id"></a> [vmss\_id](#output\_vmss\_id) | The ID of the deployed VMSS |
| <a name="output_vmss_identity"></a> [vmss\_identity](#output\_vmss\_identity) | The identity block of the deployed VMSS |

# Copyright and license

The Azure Service VMSS project is Copyright 2023-present Snowplow Analytics Ltd.

Licensed under the [Snowplow Community License](https://docs.snowplow.io/community-license-1.0). _(If you are uncertain how it applies to your use case, check our answers to [frequently asked questions](https://docs.snowplow.io/docs/contributing/community-license-faq/).)_

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[release]: https://github.com/snowplow-devops/terraform-azurerm-service-vmss/releases/latest
[release-image]: https://img.shields.io/github/v/release/snowplow-devops/terraform-azurerm-service-vmss

[ci]: https://github.com/snowplow-devops/terraform-azurerm-service-vmss/actions?query=workflow%3Aci
[ci-image]: https://github.com/snowplow-devops/terraform-azurerm-service-vmss/workflows/ci/badge.svg

[license]: https://docs.snowplow.io/docs/contributing/community-license-faq/
[license-image]: https://img.shields.io/badge/license-Snowplow--Community-blue.svg?style=flat

[registry]: https://registry.terraform.io/modules/snowplow-devops/service-vmss/azurerm/latest
[registry-image]: https://img.shields.io/static/v1?label=Terraform&message=Registry&color=7B42BC&logo=terraform
