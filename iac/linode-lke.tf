# Creates a LKE cluster that will run the stack.
resource "linode_lke_cluster" "default" {
  k8s_version = var.settings.version
  label       = var.settings.label
  region      = var.settings.region

  pool {
    type  = var.settings.nodeType
    count = var.settings.nodeCount
  }

  control_plane {
    high_availability = var.settings.ha
  }
}

# Downloads the LKE configuration file used to connect in the LKE cluster created.
resource "local_sensitive_file" "kubeconfig" {
  filename        = ".kubeconfig"
  content_base64  = linode_lke_cluster.default.kubeconfig
  file_permission = "600"
  depends_on      = [ linode_lke_cluster.default ]
}