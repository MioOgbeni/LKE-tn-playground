resource "helm_release" "external-dns" {
  depends_on = [kubernetes_namespace.default_namespaces]

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
  depends_on = [helm_release.external-dns]

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

resource "helm_release" "metrics-server" {
  depends_on = [helm_release.traefik]

  name             = "metrics-server"
  chart            = "metrics-server"
  repository       = "https://charts.bitnami.com/bitnami"
  namespace        = "metrics-server"
  version          = "6.0.4"
  wait             = true
  force_update     = true
  recreate_pods    = true
  create_namespace = false
  max_history = 3

  values = [
    "${file("app-values/metrics-server/values.yaml")}"
  ]
}