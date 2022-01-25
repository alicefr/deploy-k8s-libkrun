#!/bin/bash

CONT_NAME=critest-cont
set -x
sudo podman run --name $CONT_NAME -v /lib/modules:/lib/modules:ro \
	--privileged -dt  --systemd=true \
	critest
# Let crio starting
sleep 5
sudo podman exec -ti $CONT_NAME critest --annotation run.oci.handler="krun" \
	-ginkgo.skip="Image Manager" \
	-ginkgo.skip="runtime should support execSync"

sudo podman stop $CONT_NAME
sudo podman rm $CONT_NAME
