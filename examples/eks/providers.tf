provider "aws" {
  region = var.cluster_region
}

provider "castai" {
  api_token = var.castai_api_token
  api_url   = var.castai_api_url
}

data "aws_eks_cluster" "my_cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "my_cluster" {
  name = var.cluster_name
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.my_cluster.endpoint
    token                  = data.aws_eks_cluster_auth.my_cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.my_cluster.certificate_authority[0].data)
  }
}
