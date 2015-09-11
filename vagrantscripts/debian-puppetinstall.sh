#!/bin/bash
iptables --flush
wget https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb
dpkg -i puppetlabs-release-wheezy.deb
apt-get update
apt-get install -o Dpkg::Options::="--force-confold" -y puppet
