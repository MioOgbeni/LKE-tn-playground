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
  }
}

provider "linode" {
  # Configuration options
}

resource "linode_lke_cluster" "tn_playground_cluster" {
  label       = "tn-playground"
  k8s_version = "1.23"
  region      = "eu-central"

  pool {
    type  = "g6-standard-1"
    count = 3

    autoscaler {
      min = 3
      max = 6
    }
  }
}