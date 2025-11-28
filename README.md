# CAST AI Database Optimizer Terraform Module

This module deploys the CAST AI Database Optimizer (DBO) Helm chart.

## Usage Example

```hcl
# Create a cache group for PostgreSQL instance
resource "castai_cache_group" "this" {
  name          = "my-postgres-cache"
  protocol_type = "PostgreSQL"

  endpoints {
    hostname = "my-database.example.com"
    port     = 5432
    name     = "primary"
  }
}

# Create cache configuration for a specific database
resource "castai_cache_configuration" "this" {
  cache_group_id = castai_cache_group.this.id
  database_name  = "myapp"
  mode           = "Auto"
}

# Deploy CAST AI Database Optimizer
module "castai_dbo" {
  source = "castai/dbo/castai"

  castai_api_token = var.castai_api_token
  cache_group_id   = castai_cache_group.this.id

  # Optional: customize Helm chart values
  dbo_values = [
    yamlencode({
      replicas = 1
      resources = {
        proxy = {
          cpu           = "200m"
          memoryRequest = "500Mi"
          memoryLimit   = "500Mi"
        }
        queryProcessor = {
          cpu    = "200m"
          memory = "400Mi"
        }
      }
    })
  ]
}
```

For more Helm chart values, see the [castai-db-optimizer chart](https://github.com/castai/helm-charts/tree/main/charts/castai-db-optimizer).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_castai"></a> [castai](#requirement\_castai) | >= 8.4.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_castai"></a> [castai](#provider\_castai) | >= 8.4.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.castai_dbo](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [castai_cache_group.this](https://registry.terraform.io/providers/castai/castai/latest/docs/data-sources/cache_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cache_group_id"></a> [cache\_group\_id](#input\_cache\_group\_id) | ID of the cache group to use for DBO configuration | `string` | n/a | yes |
| <a name="input_castai_api_token"></a> [castai\_api\_token](#input\_castai\_api\_token) | CAST AI API token for authentication | `string` | n/a | yes |
| <a name="input_castai_api_url"></a> [castai\_api\_url](#input\_castai\_api\_url) | CAST AI API URL | `string` | `"api.cast.ai"` | no |
| <a name="input_dbo_namespace"></a> [dbo\_namespace](#input\_dbo\_namespace) | Kubernetes namespace where DBO will be installed | `string` | `"castai-db-optimizer"` | no |
| <a name="input_dbo_values"></a> [dbo\_values](#input\_dbo\_values) | List of YAML formatted strings with additional values for the DBO Helm chart | `list(string)` | `[]` | no |
| <a name="input_dbo_version"></a> [dbo\_version](#input\_dbo\_version) | Version of the castai-dbo Helm chart to install. Defaults to 0.50.0 | `string` | `"0.50.0"` | no |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name) | Custom name for the Helm release. | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
