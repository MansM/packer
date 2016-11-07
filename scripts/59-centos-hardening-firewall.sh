#!/bin/bash

systemctl enable firewalld
systemctl start firewalld

firewall-cmd --set-default-zone=drop --permanent
firewall-cmd --zone=public --change-interface=en0ps3 --permanent