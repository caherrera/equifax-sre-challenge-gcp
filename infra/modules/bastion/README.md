# Google Compute Instance for Bastion

Terraform module that create a single
compute instance in Google Cloud Platform (GCP)
with the following features:
- No external IP
- Custom SSH keys
- Custom machine type

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.6.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.25.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.25.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_instance.bastion](https://registry.terraform.io/providers/hashicorp/google/5.25.0/docs/resources/compute_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Set to true to create the VM | `bool` | `true` | no |
| <a name="input_image"></a> [image](#input\_image) | n/a | `string` | `"debian-12-bookworm-v20240415"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name of the VM | `string` | `"bastion-vm"` | no |
| <a name="input_instances"></a> [instances](#input\_instances) | Number of instances to create | `number` | `1` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Machine type to deploy | `string` | `"e2-micro"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project to deploy the VM in., If empty it will use the default project | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | Region to deploy the VM in | `string` | `"us-east4"` | no |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | list of public ssh keys that have access to the VM | <pre>list(object({<br>    publickey = string<br>    user      = string<br>  }))</pre> | `[]` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | Subnet to deploy the VM in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance"></a> [instance](#output\_instance) | The instance object |
