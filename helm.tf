resource "helm_release" "external-dns" {
  depends_on = [linode_lke_cluster.cluster]

  name             = "external-dns"
  chart            = "external-dns"
  repository       = "https://charts.bitnami.com/bitnami"
  namespace        = "external-dns"
  version          = "6.4.4"
  wait             = true
  force_update     = true
  recreate_pods    = true
  create_namespace = false
  max_history = 3

  values = [
    "${file("app-values/external-dns/values.yaml")}"
  ]

  set {
    name  = "cloudflare.secretName"
    value = kubernetes_secret.cloudflare_api_token.metadata[0].name
  }

  set {
    name  = "zoneIdFilters"
    value = "{${var.cloudflare_zone_id_filter}}"
  }
}

resource "helm_release" "traefik" {
  depends_on = [linode_lke_cluster.cluster]

  name             = "traefik"
  chart            = "traefik"
  repository       = "https://helm.traefik.io/traefik"
  namespace        = "traefik"
  version          = "10.20.0"
  wait             = true
  force_update     = true
  recreate_pods    = true
  create_namespace = false
  max_history = 3

  values = [
    "${file("app-values/traefik/values.yaml")}"
  ]
}