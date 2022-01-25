FROM k8s-fedora-35

ENV CRI_TEST_VERSION "v1.23.0"
COPY ./crio.conf /etc/crio/crio.conf
RUN dnf install -y wget golang git make
RUN go get -u github.com/onsi/ginkgo/ginkgo 
# Critest with annotations support
RUN git clone -b add-annotations https://github.com/alicefr/cri-tools.git \
    && cd cri-tools \
    && make critest && make install
#RUN wget https://github.com/kubernetes-sigs/cri-tools/releases/download/${CRI_TEST_VERSION}/critest-${CRI_TEST_VERSION}-linux-amd64.tar.gz \
#  && tar zxvf critest-${CRI_TEST_VERSION}-linux-amd64.tar.gz -C /usr/local/bin \
#  && rm -f critest-${CRI_TEST_VERSION}-linux-amd64.tar.gz

