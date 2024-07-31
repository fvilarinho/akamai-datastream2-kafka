# Fetches LKE Load Balancers IDs.
locals {
  nodeBalancers = toset(split(",", data.external.lkeLoadBalancers.result.nodeBalancers))
}

data "external" "lkeLoadBalancers" {
  program    = [ "./lkeLoadBalancers.sh", var.linodeToken ]
  depends_on = [ linode_lke_cluster.default ]
}

# Creates the LKE cluster firewall.
resource "linode_firewall" "default" {
  inbound_policy  = "DROP"
  label           = "${var.settings.namespace}-firewall"
  tags            = var.settings.tags
  outbound_policy = "ACCEPT"

  dynamic "inbound" {
    for_each = { for rule in var.settings.trafficPermitted : rule.name => rule }

    content {
      label    = inbound.key
      protocol = "TCP"
      action   = "ACCEPT"
      ports    = inbound.value.ports
      ipv4     = inbound.value.from
    }
  }

  nodebalancers = local.nodeBalancers
}