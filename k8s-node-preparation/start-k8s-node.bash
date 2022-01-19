#!/bin/bash

CONT_NAME=k8s-node
CONT_STORAGE=k8s-node-images

sudo podman rm -f $CONT_NAME

set -xe
sudo podman volume exists $CONT_STORAGE || sudo podman volume create $CONT_STORAGE
sudo podman run --name $CONT_NAME -v /lib/modules:/lib/modules:ro \
	--privileged -td  --systemd=true \
	-v $CONT_STORAGE:/var/lib/containers/storage/ \
	k8s-fedora-35
sleep 15
sudo podman exec -ti $CONT_NAME /var/lib/installation/start-k8s.sh
