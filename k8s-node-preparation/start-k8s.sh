#!/bin/bash
set -xe

swapoff -a
kubeadm init --config /var/lib/installation/kubeadm.yaml
mkdir -p /root/.kube/
lsmod | grep br_netfilter || modprobe br_netfilter
echo '1' > /proc/sys/net/ipv4/ip_forward
cp /etc/kubernetes/admin.conf /root/.kube/config
kubectl apply -f /var/lib/installation/calico.yaml
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl apply -f /var/lib/installation/runtime-class.yaml

