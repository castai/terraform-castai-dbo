data "castai_cache_group" "this" {
  id = var.cache_group_id
}

resource "helm_release" "castai_dbo" {
  name             = local.helm_release_name
  repository       = "https://castai.github.io/helm-charts"
  chart            = "castai-db-optimizer"
  namespace        = var.dbo_namespace
  create_namespace = true
  cleanup_on_fail  = true
  wait             = true

  version = var.dbo_version != "" ? var.dbo_version : null
  values  = var.dbo_values

  set = concat(
    local.set_api_url,
    local.set_cache_group_id,
    local.set_protocol,
    local.set_endpoints,
    local.set_name_override
  )

  set_sensitive = [
    {
      name  = "apiKey"
      value = var.castai_api_token
    }
  ]
}
