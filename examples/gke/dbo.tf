resource "castai_cache_group" "this" {
  name          = "my-cache-group"
  protocol_type = "PostgreSQL"

  endpoints {
    hostname = "primary.db.example.com"
    port     = 5432
    name     = "primary"
  }
}

resource "castai_cache_configuration" "this" {
  cache_group_id = castai_cache_group.this.id
  database_name  = "mydb"
  mode           = "Auto"
}

module "castai_dbo" {
  source = "../../"

  castai_api_token = var.castai_api_token
  castai_api_url   = trimprefix(var.castai_api_url, "https://")
  cache_group_id   = castai_cache_group.this.id

  depends_on = [castai_cache_group.this]
}
