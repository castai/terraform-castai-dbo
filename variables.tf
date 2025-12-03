variable "castai_api_url" {
  type        = string
  description = "CAST AI API URL"
  default     = "api.cast.ai"
}

variable "castai_api_token" {
  type        = string
  description = "CAST AI API token for authentication"
  sensitive   = true
}

variable "cache_group_id" {
  type        = string
  description = "ID of the cache group to use for DBO configuration"
}

variable "dbo_version" {
  type        = string
  description = "Version of the castai-dbo Helm chart to install. Defaults to 0.50.0"
  default     = "0.50.0"
}

variable "dbo_namespace" {
  type        = string
  description = "Kubernetes namespace where DBO will be installed"
  default     = "castai-db-optimizer"
}

variable "dbo_values" {
  type        = list(string)
  description = "List of YAML formatted strings with additional values for the DBO Helm chart"
  default     = []
}

variable "helm_release_name" {
  type        = string
  description = "Custom name for the Helm release"
  default     = ""
}
