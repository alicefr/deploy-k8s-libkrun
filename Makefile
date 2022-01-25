NODE_NAME=k8s-fedora-35
BUILDER=libkrun-dev-env
BUILD_LIBKRUN=libkrun-build
CRITEST=critest
images: build-libkrun-builder build-libkrun build-image-k8s-node

build-libkrun-builder:
	sudo podman build  -t ${BUILDER} build-libkrun-dev-env

build-libkrun: build-libkrun-builder
	sudo podman build  -t ${BUILD_LIBKRUN} build-libkrun

build-image-k8s-node:
	sudo podman build  -t ${NODE_NAME} k8s-node-preparation

build-critest:
	 sudo podman build  -t ${CRITEST} critest
