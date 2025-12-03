terraform {
  required_providers {
    castai = {
      source  = "castai/castai"
      version = ">= 8.4.0"
    }
    google = {
      source = "hashicorp/google"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
  required_version = ">= 1.3.2"
}
