terraform {
  cloud {
    organization = "mioogbeni"

    workspaces {
      name = "tn-playground"
    }
  }

  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.27.2"
    }

    helm = {
      source = "hashicorp/helm"
      version = "2.5.1"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }
}

provider "linode" {
  # Configuration options
}

provider "kubernetes" {
  host                   = yamldecode(base64decode(linode_lke_cluster.cluster.kubeconfig)).clusters[0].cluster.server
  token                  = yamldecode(base64decode(linode_lke_cluster.cluster.kubeconfig)).users[0].user.token
  cluster_ca_certificate = base64decode(yamldecode(base64decode(linode_lke_cluster.cluster.kubeconfig)).clusters[0].cluster.certificate-authority-data)
}

provider "helm" {
  kubernetes {
    host                   = yamldecode(base64decode(linode_lke_cluster.cluster.kubeconfig)).clusters[0].cluster.server
    token                  = yamldecode(base64decode(linode_lke_cluster.cluster.kubeconfig)).users[0].user.token
    cluster_ca_certificate = base64decode(yamldecode(base64decode(linode_lke_cluster.cluster.kubeconfig)).clusters[0].cluster.certificate-authority-data)
  }
}