#!/bin/bash

# Checks the dependencies to execute this script.
function checksDependencies() {
  if [ -z "$1" ]; then
    echo "Please provide the Akamai Cloud Computing credentials!"

    exit 1
  fi
}

# Prepares to execute this script.
function prepareToExecute() {
  export LINODE_CLI_TOKEN="$1"
}

# Fetches the Load Balancers IDs provisioned by the LKE cluster.
function fetchNodeBalancersIds() {
  LOAD_BALANCERS_IDS=$($LINODE_CLI_CMD nodebalancers list --json | $JQ_CMD -r '.[].id')

  echo -n "{"
  echo -n "\"nodeBalancers\": \""

  i=0

  for LOAD_BALANCER_ID in $LOAD_BALANCERS_IDS
  do
    if [ $i -gt 0 ]; then
      echo -n ","
    fi

    echo -n "$LOAD_BALANCER_ID"

    ((i++))
  done

  echo "\"}"
}

# Main function.
function main() {
  checksDependencies "$1"
  prepareToExecute "$1"
  fetchNodeBalancersIds
}

main "$1"