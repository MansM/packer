#!/bin/bash
#sshkey
mkdir ${rootfs}/home/vagrant/.ssh
chmod 700 ${rootfs}/home/vagrant/.ssh
wget -q --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O ${rootfs}/home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh
