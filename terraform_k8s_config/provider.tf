terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "kubectl" {
  host                   = data.terraform_remote_state.eks_infra.outputs.cluster_endpoint
  cluster_ca_certificate = data.terraform_remote_state.eks_infra.outputs.cluster_cert
  token                  = data.terraform_remote_state.eks_infra.outputs.cluster_token
  load_config_file       = false
}

terraform {
  backend "s3" {
    bucket = "my-terraform-bucket-alef"
    key    = "mytfstate-k8s-config"
    region = "eu-west-1"
  }
}

data "terraform_remote_state" "eks_infra" {
  backend = "s3"
  config = {
    bucket = "my-terraform-bucket-alef"
    key    = "mytfstate"
    region = "eu-west-1"
  }
}