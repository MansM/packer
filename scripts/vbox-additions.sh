#!/bin/bash
mount -t iso9660 -o loop /vagrant/VBoxGuestAdditions.iso /mnt

# Install the drivers
/mnt/VBoxLinuxAdditions.run

# Cleanup
umount /mnt
