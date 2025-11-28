provider "google" {
  project = var.project_id
  region  = var.cluster_region
}

provider "castai" {
  api_token = var.castai_api_token
  api_url   = var.castai_api_url
}

data "google_container_cluster" "my_cluster" {
  name     = var.cluster_name
  location = var.cluster_region
}

provider "helm" {
  kubernetes = {
    host                   = "https://${data.google_container_cluster.my_cluster.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate)
  }
}

data "google_client_config" "default" {}
