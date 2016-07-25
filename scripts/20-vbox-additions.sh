mount -o loop VBoxGuestAdditions.iso /mnt
# Install the drivers
/mnt/VBoxLinuxAdditions.run

# Cleanup
umount /mnt
