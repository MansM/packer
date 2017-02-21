FROM ubuntu:xenial

RUN apt-get update 
RUN apt-get -y install qemu unzip curl xwayland-hwe-16.04
RUN curl -L  -o packer.zip https://releases.hashicorp.com/packer/0.12.2/packer_0.12.2_linux_amd64.zip && unzip packer.zip -d /usr/bin
RUN chmod +x /usr/bin/packer
COPY travis.json /root/travis.json
COPY scripts /root/scripts
COPY http /root/http
VOLUME /root/packer_cache
WORKDIR /root