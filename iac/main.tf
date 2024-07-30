# Definition of the Terraform providers and state management.
terraform {
  # Defines the providers used by the provisioning.
  required_providers {
    linode = {
      source = "linode/linode"
    }
  }
}