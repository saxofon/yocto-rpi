FROM ubuntu:24.04

USER root

RUN apt-get clean && apt-get update \
  && apt-get install -y locales \
  && locale-gen en_US.UTF-8

RUN DEBIAN_FRONTEND="noninteractive" apt install -y tzdata

RUN apt-get install -y bash build-essential file git-core wget socat chrpath cpio unzip texinfo \
     gawk diffstat xz-utils iputils-ping \
     python3 python3-pip python3-pexpect python3-git python3-jinja2 pylint \
     libfindbin-libs-perl \
     libelf-dev bison flex bc kmod jq rsync sudo cifs-utils \
     lz4 xz-utils zstd \
     vim \
  && ln -sf /bin/bash /bin/sh \
  && sed s#^SHELL.*#SHELL=/bin/bash#g -i /etc/default/useradd

RUN useradd -m -c "My name is Builder, Yocto Builder" -G users builder \
    && echo 'builder ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /cache/downloads
RUN mkdir -p /cache/sstate
RUN mkdir -p /build
RUN chown -R builder /cache/downloads /cache/sstate /build

USER builder
