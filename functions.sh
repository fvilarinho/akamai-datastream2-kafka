#!/bin/bash

# Shows the labels.
function showLabel() {
  if [[ "$0" == *"undeploy.sh"* ]]; then
    echo "*** UNDEPLOY ***"
  elif [[ "$0" == *"deploy.sh"* ]]; then
    echo "*** DEPLOY ***"
  elif [[ "$0" == *"package.sh"* ]]; then
    echo "*** PACKAGE ***"
  elif [[ "$0" == *"publish.sh"* ]]; then
    echo "*** PUBLISH ***"
  fi

  echo
}

# Shows the banner.
function showBanner() {
  if [ -f banner.txt ]; then
    cat banner.txt
  fi

  showLabel "$1"
}

# Prepares the environment to execute the commands of this script.
function prepareToExecute() {
  # Mandatory binaries.
  export TERRAFORM_CMD=$(which terraform)
  export KUBECTL_CMD=$(which kubectl)
  export DOCKER_CMD=$(which docker)

  # Mandatory environment variables.
  export WORK_DIR="$PWD"/iac
  export ENV_FILENAME=$WORK_DIR/.env

  source "$ENV_FILENAME"
}

prepareToExecute