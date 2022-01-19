#!/bin/bash
set -xe

swapoff -a
kubeadm init --config /var/lib/installation/kubeadm.yaml
mkdir -p /root/.kube/
cp /etc/kubernetes/admin.conf /root/.kube/config
kubectl apply -f /var/lib/installation/calico.yaml
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl apply -f /var/lib/installation/runtime-class.yaml

