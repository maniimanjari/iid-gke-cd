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

MANIFEST_BRANCH=v2.4.2
NAMESPACE=default
CLUSTER=$1

if [ -z ${CLUSTER} ]; then
        echo "Usage: logs-gke.sh <cluster-context-name>"
        exit 1
fi

DIR=`dirname $0`

sed -e "s#\${CLUSTER}#${CLUSTER}#" -e "s#\${NAMESPACE}#${NAMESPACE}#" $DIR/logs-gke-cfg.yaml | kubectl delete --context $CLUSTER -n $NAMESPACE --validate=false -f -
sleep 30s;
sed -e "s#\${CLUSTER}#${CLUSTER}#" -e "s#\${NAMESPACE}#${NAMESPACE}#" $DIR/logs-gke-cfg.yaml | kubectl apply --context $CLUSTER -n $NAMESPACE --validate=false -f -