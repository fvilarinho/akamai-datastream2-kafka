#!/bin/bash

# Prepares the environment to execute this script.
function prepareToExecute() {
  cd .. || exit 1

  source functions.sh

  cd iac || exit 1
}

# Applies the LKE stack settings.
function applyLkeStackSettings() {
  # Namespace definition.
  $KUBECTL_CMD create namespace "$NAMESPACE" -o yaml --dry-run=client | $KUBECTL_CMD apply -f -

  # Credentials and settings definition.
  $KUBECTL_CMD create configmap fluentd-settings --from-file=../fluentd/etc/settings.conf -n "$NAMESPACE" -o yaml --dry-run=client | $KUBECTL_CMD apply -f -
  $KUBECTL_CMD create configmap kafka-broker-init --from-file=../kafka-broker/bin/init.sh -n "$NAMESPACE" -o yaml --dry-run=client | $KUBECTL_CMD apply -f -
  $KUBECTL_CMD create configmap kafka-broker-settings --from-file=../kafka-broker/etc/settings.conf -n "$NAMESPACE" -o yaml --dry-run=client | $KUBECTL_CMD apply -f -
  $KUBECTL_CMD create configmap nginx-settings --from-file=../nginx/etc/settings.conf -n "$NAMESPACE" -o yaml --dry-run=client | $KUBECTL_CMD apply -f -
  $KUBECTL_CMD create configmap nginx-auth --from-file=../nginx/etc/.htpasswd -n "$NAMESPACE" -o yaml --dry-run=client | $KUBECTL_CMD apply -f -
  $KUBECTL_CMD create configmap nginx-tls-certificate --from-file=../nginx/etc/ssl/certs/cert.crt -n "$NAMESPACE" -o yaml --dry-run=client | $KUBECTL_CMD apply -f -
  $KUBECTL_CMD create configmap nginx-tls-private-key --from-file=../nginx/etc/ssl/private/cert.key -n "$NAMESPACE" -o yaml --dry-run=client | $KUBECTL_CMD apply -f -
}

# Main function.
function main(){
  prepareToExecute
  applyLkeStackSettings
}

main