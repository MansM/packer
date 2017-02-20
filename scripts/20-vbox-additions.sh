mount -o loop VBoxGuestAdditions.iso /mnt
yum install -y kernel-headers kernel-devel bzip2 gcc
# Install the drivers
/mnt/VBoxLinuxAdditions.run

# Cleanup
umount /mnt
