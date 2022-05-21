resource "local_file" "kubeconfig" {
  depends_on = [linode_lke_cluster.tn_playground_cluster]
  filename   = "kube-config"
  content    = base64decode(linode_lke_cluster.tn_playground_cluster.kubeconfig)
}