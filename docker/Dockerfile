FROM ubuntu:xenial

ENV PACKER_LOG 1
RUN apt-get update 
RUN apt-get -y install qemu unzip curl xwayland-hwe-16.04
RUN curl -L  -o packer.zip https://releases.hashicorp.com/packer/0.12.2/packer_0.12.2_linux_amd64.zip && unzip packer.zip -d /usr/bin
RUN chmod +x /usr/bin/packer
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
WORKDIR /root