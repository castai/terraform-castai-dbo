variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster."
}

variable "cluster_region" {
  type        = string
  description = "AWS region where the EKS cluster is deployed."
}

variable "castai_api_token" {
  type        = string
  description = "CAST AI API token created in console.cast.ai API Access keys section."
  sensitive   = true
}

variable "castai_api_url" {
  type        = string
  description = "CAST AI API URL"
  default     = "https://api.cast.ai"
}
