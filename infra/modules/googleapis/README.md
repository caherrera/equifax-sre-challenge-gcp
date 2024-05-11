# Google Project Service Enabler

Terraform module that allows management of a single
API service for a Google Cloud Platform project.

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
| [google_project_service.project](https://registry.terraform.io/providers/hashicorp/google/5.25.0/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project"></a> [project](#input\_project) | The GCP project name | `string` | `""` | no |
| <a name="input_services"></a> [services](#input\_services) | The list of GCP services to enable | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_services"></a> [services](#output\_services) | n/a |
