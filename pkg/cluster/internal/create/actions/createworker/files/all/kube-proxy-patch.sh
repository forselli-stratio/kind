#!/usr/bin/env bash

#
# I couldn't find a better/simpler way to change kube-proxy configuration. See:
# https://github.com/kubernetes-sigs/cluster-api/issues/4512
#

set -o errexit
set -o nounset
set -o pipefail

readonly dir="/run/kubeadm"

# Run this script only if this is the init node.
if [[ ! -f ${dir}/kubeadm.yaml ]]; then
    exit 0
fi

# Exit fast if already appended.
if [[ ! -f ${dir}/kube-proxy-config.yaml ]]; then
    exit 0
fi

cat ${dir}/kube-proxy-config.yaml >> ${dir}/kubeadm.yaml
rm ${dir}/kube-proxy-config.yaml