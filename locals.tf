locals {
  id_suffix = substr(var.cache_group_id, 0, 5)

  helm_release_name = var.helm_release_name != "" ? var.helm_release_name : (
    data.castai_cache_group.this.name != ""
    ? "${data.castai_cache_group.this.name}-${local.id_suffix}"
    : "castai-db-optimizer-${local.id_suffix}"
  )

  set_api_url = var.castai_api_url != "" ? [{
    name  = "apiURL"
    value = var.castai_api_url
  }] : []

  set_cache_group_id = [{
    name  = "cacheGroupID"
    value = var.cache_group_id
  }]

  set_name_override = [{
    name  = "nameOverride"
    value = local.helm_release_name
  }]

  set_protocol = [{
    name  = "protocol"
    value = data.castai_cache_group.this.protocol_type
  }]

  set_endpoints = flatten([
    for idx, endpoint in data.castai_cache_group.this.endpoints : concat(
      [
        {
          name  = "endpoints[${idx}].hostname"
          value = endpoint.hostname
        },
        {
          name  = "endpoints[${idx}].port"
          value = tostring(endpoint.port + idx)
        },
        {
          name  = "endpoints[${idx}].targetPort"
          value = tostring(endpoint.port)
        },
        {
          name  = "endpoints[${idx}].servicePort"
          value = tostring(endpoint.port)
        }
      ],
      endpoint.name != "" ? [{
        name  = "endpoints[${idx}].name"
        value = endpoint.name
      }] : []
    )
  ])
}
