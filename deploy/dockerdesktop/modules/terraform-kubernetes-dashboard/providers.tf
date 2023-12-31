terraform {
  required_version = ">=0.13"
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">=2.11.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">=2.5.1"
    }
  }
}