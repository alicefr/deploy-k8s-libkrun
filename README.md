# Deploy a Kubernetes single-node cluster with libkrun
This repository contains the self contained environment to deploy a single-node k8s cluster with libkrun configured.

The base image and setup is currently based on fedora 35.

## Build the images
```bash
$ make images
```
Three images are build:
  * `libkrun-dev-env`: contains all the dependecies and libraries needed in order to build libkrun. It can be used also as development environment to correctly compile libkrun for fedora 35
  * `libkrun-build`: builds the upstream libkrun and crun with libkrun enablement
  * `k8s-fedora-35`: contains the setup to deploy the kubernetes cluster with libkrun configured

## Start the cluster
```bash
$ cd k8s-node-preparation
$ ./start-k8s-node.bash
```
After the initialization you can exec in the container and deploy the example:
```bash
$ sudo podman exec -ti k8s-node bash
[root@5ef06f6ebec1 /]# kubectl get po -A
NAMESPACE     NAME                                     READY   STATUS    RESTARTS   AGE
kube-system   calico-kube-controllers-76c5bc74-r9v5c   1/1     Running   0          16m
kube-system   calico-node-ppvkf                        1/1     Running   0          16m
kube-system   coredns-558bd4d5db-59mzn                 1/1     Running   0          16m
kube-system   coredns-558bd4d5db-694xw                 1/1     Running   0          16m
kube-system   etcd-5ef06f6ebec1                        1/1     Running   0          16m
kube-system   kube-apiserver-5ef06f6ebec1              1/1     Running   0          16m
kube-system   kube-controller-manager-5ef06f6ebec1     1/1     Running   0          16m
kube-system   kube-proxy-8t8fv                         1/1     Running   0          16m
kube-system   kube-scheduler-5ef06f6ebec1              1/1     Running   0          16m
[root@5ef06f6ebec1 /]# kubectl apply -f /root/example-pod-libkrun.yaml 
pod/libkrun-pod created
[root@5ef06f6ebec1 /]# kubectl get po 
NAME          READY   STATUS    RESTARTS   AGE
libkrun-pod   1/1     Running   0          19s
[root@5ef06f6ebec1 /]# kubectl attach -ti libkrun-pod
If you don't see a command prompt, try pressing enter.
[root@libkrun-pod /]# uname -a
Linux libkrun-pod 5.10.10 #1 SMP Wed Jan 19 10:38:09 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
exit
[root@5ef06f6ebec1 /]# kubectl get po
NAME          READY   STATUS      RESTARTS   AGE
libkrun-pod   0/1     Completed   0          71s
```
The container images pulled by kubernetes running the container are cache in the volume `k8s-node-images` in order to speed-up the next run. If you want to clean up, you could simply remove the volume `sudo podman volume rm k8s-node-images`.

## Run critest
In order to inject the annotation `run.oci.handler="krun"`, we are currently using a custom critest. 
Build the critest image:
```bash
$ make build-critest
```
Run the tests:
```bash
$ critest/start-critest.sh
```
### Disclaimers
This is a first setup and there is a lot of space for improvment. The containers images and the kubernetes node container are deployed using root podman. Therefore, there are `sudo podman` hardcoded commands
