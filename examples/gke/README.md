# GKE with CAST AI DBO (Database Optimizer)

This example demonstrates how to deploy DBO on an existing GKE cluster:
1. Configure DBO cache resources (cache group and configuration)
2. Deploy the DBO Helm chart using the terraform-castai-dbo module

## Overview

DBO (Database Optimizer) provides intelligent caching for database queries to improve
performance and reduce database load.

### Files

| File | Description |
|------|-------------|
| `dbo.tf` | Cache group, configuration, and DBO module |
| `providers.tf` | Provider configuration for GCP, CAST AI, and Helm |
| `variables.tf` | Input variables |
| `versions.tf` | Terraform and provider version constraints |

## Prerequisites

- Terraform >= 1.3.2
- Existing GKE cluster
- CAST AI account with API token
- Database accessible from your GKE cluster

## Usage

1. Copy the example variables file:
   ```bash
   cp tf.vars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your configuration

3. Update `dbo.tf` with your database endpoint and cache settings

4. Initialize and apply:
   ```bash
   terraform init
   terraform apply
   ```

## Configuration

Edit `dbo.tf` to configure your cache group:

```hcl
resource "castai_cache_group" "this" {
  name          = "my-cache-group"
  protocol_type = "PostgreSQL"  # or "MySQL"

  endpoints {
    hostname = "your-db.example.com"
    port     = 5432
    name     = "primary"
  }
}
```

## Cleanup

```bash
terraform destroy
```
