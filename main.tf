resource "linode_lke_cluster" "cluster" {
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

data "linode_lke_cluster" "cluster" {
  id = linode_lke_cluster.cluster.id
}

resource "kubernetes_namespace" "default_namespaces" {
  depends_on = [linode_lke_cluster.cluster]

  for_each = var.default_namespaces

  metadata {
    annotations = {
      name = each.value
    }

    labels = {
      name = each.value
      namespace = each.value
    }

    name = each.value
  }
}

resource "kubernetes_secret" "cloudflare_api_token" {
  depends_on = [linode_lke_cluster.cluster]

  metadata {
    name = "cloudflare-api-token"
    namespace = "external-dns"
  }

  data = {
    cloudflare_api_token = var.cloudflare_api_token
  }
}