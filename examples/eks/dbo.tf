# Create a cache group for the PostgreSQL instance
resource "castai_cache_group" "this" {
  name          = "my-cache-group"
  protocol_type = "PostgreSQL"

  endpoints {
    hostname = "my-rds-instance.abcdefghijkl.us-east-1.rds.amazonaws.com"
    port     = 5432
    name     = "primary"
  }

  endpoints {
    hostname = "my-rds-instance-ro.abcdefghijkl.eu-north-1.rds.amazonaws.com"
    port     = 5432
    name     = "ro"
  }
}

# (Optional) Create cache configuration for a specific database within the instance.
resource "castai_cache_configuration" "this" {
  cache_group_id = castai_cache_group.this.id
  database_name  = "mydb"
  mode           = "Auto" # use "DontCache" for passthrough mode
}

# Deploy CAST AI DBO (Database Optimizer)
module "castai_dbo" {
  source = "../../"

  castai_api_token = var.castai_api_token
  castai_api_url   = trimsuffix(trimprefix(var.castai_api_url, "https://"), "/")
  cache_group_id   = castai_cache_group.this.id

  # Uncomment if you want to pin to a specific version
  #dbo_version      = "0.53.0"

  depends_on = [castai_cache_group.this]
}
