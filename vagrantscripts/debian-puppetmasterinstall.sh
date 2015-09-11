#!/bin/bash
apt-get update && apt-get install -o Dpkg::Options::="--force-confold" -y puppetmaster-passenger  && apt-get -y -o Dpkg::Options::="--force-confold" install puppetmaster
