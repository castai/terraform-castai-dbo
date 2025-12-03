variable "cluster_name" {
  type        = string
  description = "GKE cluster name in GCP project."
}

variable "cluster_region" {
  type        = string
  description = "The region to create the cluster."
}

variable "project_id" {
  type        = string
  description = "GCP project ID in which GKE cluster would be created."
}

# CAST AI variables
variable "castai_api_token" {
  type        = string
  description = "CAST AI API token created in console.cast.ai API Access keys section."
  sensitive   = true
}

variable "castai_api_url" {
  type        = string
  description = "CAST AI API URL."
  default     = "https://api.cast.ai"
}
