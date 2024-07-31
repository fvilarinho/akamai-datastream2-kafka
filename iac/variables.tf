# Linode API token.
variable "linodeToken" {
  type = string
}

# Deployment settings.
variable "settings" {
  default = {
    label     = "akamai-datastream2-cluster"
    namespace = "akamai-datastream2"
    tags      = [ "observability" ]
    region    = "<region>"
    version   = "<version>"
    ha        = true
    nodeType  = "<nodeType>"
    nodeCount = 3

    auth = {
      user     = "<user>"
      password = "<password>"
    }

    trafficPermitted = [
      {
        name  = "ingest-events"
        from  = [ "0.0.0.0/0" ]
        ports = "443"
      },
      {
        name  = "export-events"
        from  = [ "0.0.0.0/0" ]
        ports = "9092"
      },
      {
        name  = "admin"
        from  = [ "0.0.0.0/0" ]
        ports = "9443"
      }
    ]
  }
}