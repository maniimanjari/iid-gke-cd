#!/usr/bin/env bash
# shellcheck shell=bash

#
# Metrics quickstart: https://grafana.com/docs/grafana-cloud/quickstart/agent-k8s/k8s_agent_metrics/
# Logs quickstart: https://grafana.com/docs/grafana-cloud/quickstart/agent-k8s/k8s_agent_logs/
#

check_installed() {
  if ! type "$1" >/dev/null 2>&1; then
    echo "error: $1 not installed" >&2
    exit 1
  fi
}

check_installed kubectl

MANIFEST_BRANCH=v0.21.1
NAMESPACE=default
export NAMESPACE
CLUSTER=$1
export CLUSTER

if [ -z ${CLUSTER} ]; then
	echo "Usage: metrics-gke.sh <cluster-name>"
	exit 1
fi
eval "echo \"$(cat metrics-gke-cfg.yaml)\"" | kubectl apply --context $1 -n $NAMESPACE --validate=false -f -