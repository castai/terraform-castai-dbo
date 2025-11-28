terraform {
  required_version = ">= 0.13"

  required_providers {
    castai = {
      source  = "castai/castai"
      version = ">= 8.4.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0.0"
    }
  }
}
