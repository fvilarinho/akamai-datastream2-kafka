# Applies the LKE settings.
resource "null_resource" "applyLkeSettings" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    quiet   = true
    command = "./applyLkeSettings.sh"

    environment = {
      KUBECONFIG = local_sensitive_file.kubeconfig.filename
      NAMESPACE  = var.settings.namespace
    }
  }

  depends_on = [
    local_sensitive_file.privateKey,
    local_sensitive_file.certificate,
    local_sensitive_file.kubeconfig,
    local_sensitive_file.authentication
  ]
}

# Applies the LKE services and deployments.
resource "null_resource" "applyLkeStack" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    quiet   = true
    command = "./applyLkeStack.sh"

    environment = {
      KUBECONFIG  = local_sensitive_file.kubeconfig.filename
      NAMESPACE   = var.settings.namespace
      NODES_COUNT = var.settings.nodeCount
    }
  }

  depends_on = [ null_resource.applyLkeSettings ]
}