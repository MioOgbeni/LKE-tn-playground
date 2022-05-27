resource "local_file" "kubeconfig" {
  depends_on = [linode_lke_cluster.cluster]
  filename   = "kubeconfig.yaml"
  content    = base64decode(linode_lke_cluster.cluster.kubeconfig)
}