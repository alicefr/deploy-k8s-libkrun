FROM libkrun-build as builder
FROM fedora:35

RUN dnf install -y systemd passwd
ENV VERSION 1.21 
RUN  dnf module enable -y cri-o:${VERSION} \
     && dnf install -y \
      cri-o \
      kubernetes-client \
      kubernetes-kubeadm \
      kubernetes-node \
      iproute-tc \
      iptables-nft \
      crictl \
      crun \
      findutils \
      procps-ng \
      podman \
      ethtool
RUN passwd -d root      
RUN sed -i 's/.*driver =.*/driver = \"vfs\"/' /etc/containers/storage.conf 
RUN systemctl enable crio && systemctl enable kubelet
RUN mkdir -p /var/lib/installation
COPY kubeadm.yaml /var/lib/installation/kubeadm.yaml
COPY ./calico.yaml /var/lib/installation/calico.yaml
COPY ./crio.conf /etc/crio/crio.conf
COPY ./start-k8s.sh  /var/lib/installation/start-k8s.sh
COPY ./runtime-class.yaml /var/lib/installation/runtime-class.yaml
COPY ./init.sh /init.sh
COPY ./example-pod-libkrun.yaml /root
COPY --from=builder /usr/local/lib64/libkrunfw.so /usr/lib64/libkrunfw.so
COPY --from=builder /usr/local/lib64/libkrun.so /usr/lib64/libkrun.so
COPY --from=builder /usr/local/include/libkrun.h /usr/include/libkrun.h
COPY --from=builder /usr/local/bin/crun /usr/local/bin/crun
RUN dnf remove zram-generator-defaults
CMD [ "/init.sh" ]
