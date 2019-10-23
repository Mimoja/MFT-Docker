FROM golang:alpine

ENV YARA_VERSION v3.8.1
ENV YARA_PY_VERSION v3.8.1

RUN apk add --no-cache openssl file jansson bison python tini su-exec git cmake make\
  gcc libtool build-base pkgconfig py-setuptools \
  openssl-dev \
  jansson-dev \
  python-dev \
  libc-dev \
  file-dev \
  automake \
  autoconf \
  libtool \
  flex

RUN set -x
RUN echo "Cloning Yara projects"
RUN git clone --branch $YARA_VERSION --recursive https://github.com/VirusTotal/yara.git /tmp/yara
RUN git clone --branch $YARA_PY_VERSION --recursive https://github.com/VirusTotal/yara-python /tmp/yara-python

WORKDIR /tmp/yara
RUN echo "Install Yara from source..."
RUN ./bootstrap.sh
RUN sync
RUN ./configure --with-crypto   --enable-magic  --enable-cuckoo  --enable-dotnet
RUN make
RUN make install

WORKDIR /tmp/yara-python
RUN echo "Install yara-python..."
RUN python setup.py build --dynamic-linking
RUN python setup.py install 


RUN echo "Cleaning up..."
RUN rm -rf /tmp/*
WORKDIR /go/src/app
