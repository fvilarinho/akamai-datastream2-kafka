#!/bin/bash

# Prepares the environment to execute this script.
function prepareToExecute() {
  cd .. || exit 1

  source functions.sh

  cd iac || exit 1
}

# Applies the LKE storages.
function applyLkeStorages() {
  manifestFilename="linode-lke-storages.yml"

  # Applies the manifest.
  $KUBECTL_CMD apply -f "$manifestFilename" -n "$NAMESPACE"
}

# Applies the LKE deployments.
function applyLkeDeployments() {
  manifestFilename="linode-lke-deployments.yml"

  # Prepares the manifest.
  cp -f "$manifestFilename" "$manifestFilename".tmp
  sed -i -e 's|${DOCKER_REGISTRY_URL}|'"$DOCKER_REGISTRY_URL"'|g' "$manifestFilename".tmp
  sed -i -e 's|${DOCKER_REGISTRY_ID}|'"$DOCKER_REGISTRY_ID"'|g' "$manifestFilename".tmp
  sed -i -e 's|${IDENTIFIER}|'"$IDENTIFIER"'|g' "$manifestFilename".tmp
  sed -i -e 's|${BUILD_VERSION}|'"$BUILD_VERSION"'|g' "$manifestFilename".tmp

  # Applies the manifest.
  $KUBECTL_CMD apply -f "$manifestFilename".tmp
}

# Applies the LKE services.
function applyLkeServices() {
  manifestFilename="linode-lke-services.yml"

  # Applies the manifest.
  $KUBECTL_CMD apply -f "$manifestFilename" -n "$NAMESPACE"
}

# Clean-up.
function cleanUp() {
  rm -f *.yml.tmp
}

# Main function.
function main() {
  prepareToExecute
  applyLkeStorages
  applyLkeDeployments
  applyLkeServices
  cleanUp
}

main