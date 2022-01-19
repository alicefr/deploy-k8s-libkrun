FROM fedora:35 as BUILD

ENV FW_VERSION 0.7

RUN dnf install -y \
   autoconf \
   automake \
   bc \
   bison \
   cargo \
   curl \
   diffutils \
   elfutils-libelf-devel \
   findutils \
   flex \
   git \
   gcc \
   glibc-static \
   glibc-static \
   go-md2man \
   libcap-devel \
   libseccomp-devel \
   libtool \
   make \
   openssl-devel \
   patch \
   python systemd-devel \
   python3 \
   python3-libmount \
   python3-pyelftools \
   rsync \
   tar \
   xz  \
   yajl-devel  \
   wget \
   && rm -rf /var/cache /var/log/dnf* /var/log/yum.*

RUN wget https://github.com/containers/libkrunfw/archive/refs/tags/v${FW_VERSION}.tar.gz \
    && tar -xf v${FW_VERSION}.tar.gz \
    && cd libkrunfw-${FW_VERSION} \
    && make \
    && make install
