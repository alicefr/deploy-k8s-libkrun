FROM libkrun-dev-env

RUN git clone https://github.com/containers/libkrun.git \
    && cd libkrun \
    && make && make install

RUN git clone https://github.com/containers/crun.git \
    && cd crun \
    && ./autogen.sh \
    && ./configure --with-libkrun CFLAGS="-I/usr/local/include/" \
    && make && make install
